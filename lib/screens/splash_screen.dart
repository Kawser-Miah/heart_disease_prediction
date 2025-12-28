import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:heart_disease_prediction/screens/auth_gate.dart';

import '../config/app_colors.dart';
import '../config/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // Navigate to home screen after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AuthGate()),
        );
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AuthGate()),
        );
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.teal50,
                Colors.white,
                AppColors.teal50,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Heart Icon with pulse effect
                ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _pulseController,
                      curve: Curves.easeInOut,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer pulse rings
                      ...List.generate(2, (index) {
                        return FadeTransition(
                          opacity: Tween<double>(begin: 0.6, end: 0.0).animate(
                            CurvedAnimation(
                              parent: _pulseController,
                              curve: Interval(
                                index * 0.2,
                                1.0,
                                curve: Curves.easeOut,
                              ),
                            ),
                          ),
                          child: ScaleTransition(
                            scale: Tween<double>(
                                    begin: 1.0, end: 1.8 + index * 0.4)
                                .animate(
                              CurvedAnimation(
                                parent: _pulseController,
                                curve: Curves.easeOut,
                              ),
                            ),
                            child: Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.tealLight,
                                  width: 4,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      // Heart container
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primaryTeal,
                              AppColors.tealLight,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.teal100,
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // App Name
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: const Column(
                    children: [
                      Text(
                        AppConstants.appName,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.tealDark,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        AppConstants.appTagline,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                // Heartbeat line animation
                FadeInUp(
                  delay: const Duration(milliseconds: 600),
                  child: CustomPaint(
                    size: const Size(250, 40),
                    painter: HeartbeatPainter(animation: _pulseController),
                  ),
                ),
                const SizedBox(height: 80),
                // Tap to continue
                FadeInUp(
                  delay: const Duration(milliseconds: 1000),
                  child: const Text(
                    'Tap anywhere to continue',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.gray400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeartbeatPainter extends CustomPainter {
  final Animation<double> animation;

  HeartbeatPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryTeal
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Create heartbeat pattern
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width * 0.2, size.height / 2);
    path.lineTo(size.width * 0.25, size.height * 0.25);
    path.lineTo(size.width * 0.3, size.height * 0.75);
    path.lineTo(size.width * 0.35, size.height * 0.125);
    path.lineTo(size.width * 0.4, size.height * 0.875);
    path.lineTo(size.width * 0.45, size.height / 2);
    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(HeartbeatPainter oldDelegate) => true;
}
