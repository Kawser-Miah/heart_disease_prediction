import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/assessment_bloc.dart';
import '../blocs/assessment_state.dart';
import '../config/app_colors.dart';
import 'result_screen.dart';

class AnalyzingScreen extends StatefulWidget {
  const AnalyzingScreen({super.key});

  @override
  State<AnalyzingScreen> createState() => _AnalyzingScreenState();
}

class _AnalyzingScreenState extends State<AnalyzingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AssessmentBloc, AssessmentState>(
      listener: (context, state) {
        if (state is AssessmentCompleted) {
          // Navigate to result screen when analysis is complete
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => ResultScreen(assessment: state.assessment),
            ),
          );
        } else if (state is AssessmentError) {
          // Show error and go back
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.redDark,
            ),
          );
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.teal50, Colors.white, AppColors.teal50],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated circular progress
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer rotating ring
                    RotationTransition(
                      turns: _controller,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.teal100,
                            width: 8,
                          ),
                        ),
                      ),
                    ),
                    // Middle pulsing ring
                    ScaleTransition(
                      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.tealLight,
                            width: 6,
                          ),
                        ),
                      ),
                    ),
                    // Inner heart icon
                    const Icon(
                      Icons.favorite,
                      color: AppColors.teal600,
                      size: 48,
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Analyzing text
                const Text(
                  'Analyzing Your Heart Health',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.tealDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Progress steps
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Column(
                    children: [
                      _buildProgressStep('Processing your data...', true),
                      _buildProgressStep('Calculating risk factors...', true),
                      _buildProgressStep('Generating recommendations...', true),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Heartbeat wave animation
                CustomPaint(
                  size: const Size(250, 40),
                  painter: HeartbeatWavePainter(animation: _controller),
                ),
                const SizedBox(height: 40),

                // Info text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    'Please wait while we analyze your health data using our AI-powered system',
                    style: TextStyle(fontSize: 14, color: AppColors.gray600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStep(String text, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.teal600 : AppColors.gray300,
            ),
            child: isActive
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: isActive ? AppColors.tealDark : AppColors.gray500,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeartbeatWavePainter extends CustomPainter {
  final Animation<double> animation;

  HeartbeatWavePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryTeal
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    path.moveTo(0, size.height / 2);
    path.lineTo(size.width * 0.2, size.height / 2);
    path.lineTo(size.width * 0.25, size.height * 0.2);
    path.lineTo(size.width * 0.3, size.height * 0.8);
    path.lineTo(size.width * 0.35, size.height * 0.1);
    path.lineTo(size.width * 0.4, size.height * 0.9);
    path.lineTo(size.width * 0.45, size.height / 2);
    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HeartbeatWavePainter oldDelegate) => true;
}
