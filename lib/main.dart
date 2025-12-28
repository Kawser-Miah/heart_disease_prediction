import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/assessment_bloc.dart';
import 'blocs/profile_bloc.dart';
import 'config/app_colors.dart';
import 'config/app_constants.dart';
import 'data/repository_iml/authentication_repository_iml.dart';
import 'data/repository_iml/factor_contribution_repo_iml.dart';
import 'data/repository_iml/health_assessment_repo_iml.dart';
import 'data/repository_iml/heart_disease_repository_iml.dart';
import 'datasource/db/heart_disease_db.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'utils/risk_calculator.dart';
import 'utils/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize shared preferences
  final prefs = await SharedPreferences.getInstance();
  final storageService = StorageService(prefs);
  Future<HeartDiseaseDb> db = $FloorHeartDiseaseDb
      .databaseBuilder('heart_disease.db')
      .build();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final riskCalculator = RiskCalculator();
  final heartDiseaseRepository = HeartDiseaseRepositoryIml();
  final factorContributionRepoIml = FactorContributionRepoIml(await db);
  final healthAssessmentRepoIml = HealthAssessmentRepoIml(await db);
  final AuthenticationRepositoryIml authenticationRepositoryIml =
      AuthenticationRepositoryIml(firebaseAuth, firestore);

  runApp(
    MyApp(
      storageService: storageService,
      riskCalculator: riskCalculator,
      heartDiseaseRepository: heartDiseaseRepository,
      healthAssessmentRepoIml: healthAssessmentRepoIml,
      factorContributionRepoIml: factorContributionRepoIml,
      authenticationRepositoryIml: authenticationRepositoryIml,
    ),
  );
}

class MyApp extends StatelessWidget {
  final StorageService storageService;
  final RiskCalculator riskCalculator;
  final HeartDiseaseRepositoryIml heartDiseaseRepository;
  final HealthAssessmentRepoIml healthAssessmentRepoIml;
  final FactorContributionRepoIml factorContributionRepoIml;
  final AuthenticationRepositoryIml authenticationRepositoryIml;

  const MyApp({
    super.key,
    required this.storageService,
    required this.riskCalculator,
    required this.heartDiseaseRepository,
    required this.healthAssessmentRepoIml,
    required this.factorContributionRepoIml,
    required this.authenticationRepositoryIml,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AssessmentBloc>(
          create: (context) => AssessmentBloc(
            storageService: storageService,
            riskCalculator: riskCalculator,
            heartDiseaseRepository: heartDiseaseRepository,
            healthAssessmentRepoIml: healthAssessmentRepoIml,
            factorContributionRepoIml: factorContributionRepoIml,
            authenticationRepositoryIml: authenticationRepositoryIml,
          ),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            storageService: storageService,
            authenticationRepositoryIml: authenticationRepositoryIml,
          ),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryTeal,
            brightness: Brightness.light,
          ),
          textTheme: GoogleFonts.interTextTheme(),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
          cardTheme: const CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
