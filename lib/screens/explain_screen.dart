import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../models/health_assessment.dart';

class ExplainScreen extends StatelessWidget {
  final HealthAssessment assessment;

  const ExplainScreen({super.key, required this.assessment});

  @override
  Widget build(BuildContext context) {
    final sortedFactors = [...assessment.contributingFactors]
      ..sort((a, b) => b.contribution.compareTo(a.contribution));

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Explanation'),
        backgroundColor: AppColors.teal600,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.teal600, AppColors.teal50],
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.psychology,
                          color: AppColors.teal600,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AI-Powered Analysis',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Understanding your risk factors',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.teal100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contributing Factors',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.tealDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'These factors contributed to your risk assessment:',
                    style: TextStyle(fontSize: 14, color: AppColors.gray600),
                  ),
                  const SizedBox(height: 24),

                  // Factors list
                  if (sortedFactors.isEmpty)
                    _buildNoFactorsCard()
                  else
                    ...sortedFactors.map((factor) {
                      return _buildFactorCard(factor);
                    }),

                  const SizedBox(height: 24),

                  // Info box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.teal50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.teal100),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.lightbulb_outline,
                          color: AppColors.teal600,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'How to interpret this',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.tealDark,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Each factor is assigned an impact level (high, medium, or low) and a contribution percentage. Higher contributions indicate stronger influence on your overall risk assessment.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.gray700,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFactorCard(FactorContribution factor) {
    Color impactColor;
    Color impactBgColor;

    switch (factor.impact) {
      case 'high':
        impactColor = AppColors.redDark;
        impactBgColor = AppColors.redLight;
        break;
      case 'medium':
        impactColor = AppColors.yellowDark;
        impactBgColor = AppColors.yellowLight;
        break;
      case 'low':
        impactColor = AppColors.greenDark;
        impactBgColor = AppColors.greenLight;
        break;
      default:
        impactColor = AppColors.gray600;
        impactBgColor = AppColors.gray100;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    factor.factorName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray900,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: impactBgColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${factor.impact.toUpperCase()} IMPACT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: impactColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Contribution bar
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: factor.contribution,
                      minHeight: 8,
                      backgroundColor: AppColors.gray200,
                      valueColor: AlwaysStoppedAnimation<Color>(impactColor),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${(factor.contribution * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: impactColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Explanation
            Text(
              factor.explanation,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.gray700,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoFactorsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.info_outline, color: AppColors.gray400, size: 48),
              SizedBox(height: 16),
              Text(
                'No significant risk factors identified',
                style: TextStyle(fontSize: 16, color: AppColors.gray600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
