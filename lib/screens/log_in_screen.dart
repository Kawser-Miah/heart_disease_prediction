import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/assessment_bloc.dart';
import '../blocs/assessment_event.dart';
import '../blocs/assessment_state.dart';
import '../config/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _dialog(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: AppColors.teal600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FBF9),
      body: SafeArea(
        child: BlocListener<AssessmentBloc, AssessmentState>(
          listener: (context, state) {
            if (state is SuccessLoginState) {
              _dialog('Logged in successfully', context);
            }
            if (state is ErrorLoginState) {
              _dialog('Something went wrong.Please try again', context);
            }
            if (state is AssessmentLoading) {
              _dialog('Logging in', context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Circle
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F9D8A),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 46,
                  ),
                ),

                const SizedBox(height: 24),

                // App Name
                const Text(
                  'CardioCare AI',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F766E),
                  ),
                ),

                const SizedBox(height: 8),

                // Tagline
                const Text(
                  'Early detection. Better heart health.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 48),

                // Info text
                const Text(
                  'Sign in to continue monitoring your heart health',
                  style: TextStyle(fontSize: 15, color: Color(0xFF374151)),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Google Button (UI Only)
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      // UI only – no logic
                      context.read<AssessmentBloc>().add(const LoginEvent());
                      // try{
                      // await authenticationRepository.signInWithGoogle();}
                      // catch(e){
                      //   print(e.toString());
                      // }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.g_mobiledata, color: Colors.grey.shade700),
                        // Image.asset(
                        //   'assets/google.png', // add Google icon asset
                        //   height: 22,
                        // ),
                        const SizedBox(width: 12),
                        const Text(
                          'Continue with Google',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Privacy Note
                const Text(
                  'We do not store or share your personal data',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
