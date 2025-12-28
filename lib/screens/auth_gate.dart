import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/assessment_bloc.dart';
import '../blocs/assessment_event.dart';
import 'home_screen.dart';
import 'log_in_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // User logged in
        if (snapshot.hasData) {
          context.read<AssessmentBloc>().add(const LoadAssessmentHistory());
          return const HomeScreen();
        }

        // User not logged in
        return const LoginScreen();
      },
    );
  }
}
