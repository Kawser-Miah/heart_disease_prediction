import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_disease_prediction/data/repository_iml/authentication_repository_iml.dart';
import 'package:heart_disease_prediction/data/repository_iml/factor_contribution_repo_iml.dart';
import 'package:heart_disease_prediction/data/repository_iml/health_assessment_repo_iml.dart';
import 'package:uuid/uuid.dart';
import '../data/repository/heart_disease_repository.dart';
import '../data/repository_iml/heart_disease_repository_iml.dart';
import 'assessment_event.dart';
import 'assessment_state.dart';
import '../models/health_assessment.dart';
import '../utils/risk_calculator.dart';
import '../utils/storage_service.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final StorageService storageService;
  final RiskCalculator riskCalculator;
  final HeartDiseaseRepositoryIml heartDiseaseRepository;
  final HealthAssessmentRepoIml healthAssessmentRepoIml;
  final FactorContributionRepoIml factorContributionRepoIml;
  final AuthenticationRepositoryIml authenticationRepositoryIml;

  AssessmentBloc({
    required this.storageService,
    required this.riskCalculator,
    required this.heartDiseaseRepository,
    required this.healthAssessmentRepoIml,
    required this.factorContributionRepoIml,
    required this.authenticationRepositoryIml,
  }) : super(const AssessmentInitial()) {
    on<UpdateFormField>(_onUpdateFormField);
    on<SubmitAssessment>(_onSubmitAssessment);
    on<LoadAssessmentHistory>(_onLoadAssessmentHistory);
    on<ClearCurrentAssessment>(_onClearCurrentAssessment);
    on<DeleteAssessment>(_onDeleteAssessment);
    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  void _onUpdateFormField(
    UpdateFormField event,
    Emitter<AssessmentState> emit,
  ) {
    emit(AssessmentFormInProgress(event.formData));
  }

  Future<void> _onSubmitAssessment(
    SubmitAssessment event,
    Emitter<AssessmentState> emit,
  ) async {
    try {
      String id = const Uuid().v4();
      // Emit analyzing state
      emit(AssessmentAnalyzing(event.formData));

      // Simulate analysis delay
      await Future.delayed(const Duration(seconds: 3));

      // Calculate risk
      final result = await heartDiseaseRepository.getHeartDiseasePrediction(
        event.formData,
      );
      final riskResult = riskCalculator.calculateRisk(
        event.formData,
        result.riskLevel!,
        id,
      );

      // Create assessment
      final assessment = HealthAssessment(
        id: id,
        date: DateTime.now(),
        prediction: result.prediction!,
        riskLevel: result.riskLevel!,
        riskPercentage: result.probability!,
        recommendations: riskResult.recommendations,
        contributingFactors: riskResult.contributingFactors,
      );

      // Save to storage
      await healthAssessmentRepoIml.insertHealthAssessment(
        HealthAssessmentEntity(
          id: assessment.id,
          date: assessment.date.toString(),
          prediction: assessment.prediction,
          riskLevel: assessment.riskLevel,
          riskPercentage: assessment.riskPercentage,
        ),
      );
      await factorContributionRepoIml.insertFactorContribution(
        assessment.contributingFactors,
      );

      // Emit completed state
      emit(AssessmentCompleted(assessment));
    } catch (e) {
      emit(AssessmentError('Failed to process assessment: ${e.toString()}'));
    }
  }

  Future<void> _onLoadAssessmentHistory(
    LoadAssessmentHistory event,
    Emitter<AssessmentState> emit,
  ) async {
    try {
      emit(const AssessmentLoading());

      List<HealthAssessment> assessments = [];

      final assessmentsResult = await healthAssessmentRepoIml.getAll();
      for (var assessment in assessmentsResult) {
        final factors = await factorContributionRepoIml.getAll(assessment.id);
        assessments.add(
          HealthAssessment(
            id: assessment.id,
            date: DateTime.parse(assessment.date),
            prediction: assessment.prediction,
            riskLevel: assessment.riskLevel,
            riskPercentage: assessment.riskPercentage,
            recommendations: riskCalculator.generateRecommendations(
              assessment.riskLevel,
              factors,
            ),
            contributingFactors: factors,
          ),
        );
      }
      final currentAssessment = assessments.isNotEmpty
          ? assessments.reduce((a, b) => a.date.isAfter(b.date) ? a : b)
          : null;

      assessments.sort((a, b) => b.date.compareTo(a.date));

      emit(
        AssessmentHistoryLoaded(
          assessments: assessments,
          currentAssessment: currentAssessment,
        ),
      );
    } catch (e) {
      emit(AssessmentError('Failed to load history: ${e.toString()}'));
    }
  }

  void _onClearCurrentAssessment(
    ClearCurrentAssessment event,
    Emitter<AssessmentState> emit,
  ) {
    emit(const AssessmentInitial());
  }

  Future<void> _onDeleteAssessment(
    DeleteAssessment event,
    Emitter<AssessmentState> emit,
  ) async {
    try {
      await healthAssessmentRepoIml.deleteHealthAssessment(event.assessmentId);
      await factorContributionRepoIml.deleteByForeignKey(event.assessmentId);

      add(const LoadAssessmentHistory());
    } catch (e) {
      emit(AssessmentError('Failed to delete assessment: ${e.toString()}'));
    }
  }

  Future<void> _onLoginEvent(
    LoginEvent event,
    Emitter<AssessmentState> emit,
  ) async {
    emit(const AssessmentLoading());
    try {
      await authenticationRepositoryIml.signInWithGoogle();

      emit(const SuccessLoginState());
    } catch (e) {
      emit(const ErrorLoginState());
    }
  }

  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AssessmentState> emit,
  ) async {
    emit(const AssessmentLoading());
    try {
      await authenticationRepositoryIml.signOut();

      emit(const SuccessLogoutState());
    } catch (e) {
      emit(const ErrorLogoutState());
    }
  }
}
