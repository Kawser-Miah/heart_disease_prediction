import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/health_assessment.dart';
import '../config/app_colors.dart';
import '../utils/helpers.dart';
import 'explain_screen.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  final HealthAssessment assessment;

  const ResultScreen({super.key, required this.assessment});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prediction = widget.assessment.prediction;
    final riskLevel = widget.assessment.riskLevel;
    final riskPercentage = widget.assessment.riskPercentage;
    final bgColor = AppColors.getRiskBackgroundColor(riskLevel);
    final textColor = AppColors.getRiskTextColor(riskLevel);
    final progressColor = AppColors.getRiskProgressColor(riskLevel);

    print(widget.assessment.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Results'),
        backgroundColor: AppColors.teal600,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top gradient section
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.teal600, AppColors.teal50],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 60),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    children: [
                      // Risk percentage circle
                      CircularPercentIndicator(
                        radius: 80.0,
                        lineWidth: 12.0,
                        percent: riskPercentage,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${(riskPercentage * 100).toStringAsFixed(1)}%',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            Text(
                              '$riskLevel Risk',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.gray600,
                              ),
                            ),
                          ],
                        ),
                        progressColor: progressColor,
                        backgroundColor: AppColors.gray200,
                        circularStrokeCap: CircularStrokeCap.round,
                        animation: true,
                        animationDuration: 1200,
                      ),
                      const SizedBox(height: 24),

                      // Risk level badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          prediction
                              ? 'High risk of heart disease detected'
                              : 'No significant risk of heart disease detected',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Date
                      Text(
                        'Assessed on ${DateFormatter.formatDate(widget.assessment.date)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary card
                  _buildSummaryCard(riskLevel),
                  const SizedBox(height: 24),

                  // Recommendations section
                  const Text(
                    'Recommendations',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.tealDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...widget.assessment.recommendations.map(
                    (rec) => _buildRecommendationItem(rec),
                  ),
                  const SizedBox(height: 32),

                  // Action buttons
                  _buildActionButton(
                    icon: Icons.psychology,
                    label: 'View AI Explanation',
                    color: AppColors.teal600,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ExplainScreen(assessment: widget.assessment),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    icon: Icons.download,
                    label: 'Download Report',
                    color: AppColors.gray700,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Report download feature coming soon'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    icon: Icons.share,
                    label: 'Share with Doctor',
                    color: Colors.blue,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Share feature coming soon'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Disclaimer
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
                          Icons.info_outline,
                          color: AppColors.teal600,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'This assessment is based on AI analysis and should not replace professional medical diagnosis. Please consult with a healthcare provider for proper evaluation.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.gray700,
                            ),
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

  Widget _buildSummaryCard(String riskLevel) {
    String summaryText;
    IconData summaryIcon;

    switch (riskLevel) {
      case 'Low':
        summaryText =
            'Your heart health indicators are generally within normal range. Continue maintaining a healthy lifestyle.';
        summaryIcon = Icons.check_circle;
        break;
      case 'Medium':
        summaryText =
            'Some indicators suggest moderate cardiovascular risk. Consider lifestyle modifications and regular monitoring.';
        summaryIcon = Icons.warning;
        break;
      case 'High':
        summaryText =
            'Your results indicate elevated cardiovascular risk. Please consult a cardiologist as soon as possible.';
        summaryIcon = Icons.error;
        break;
      default:
        summaryText = 'Assessment completed.';
        summaryIcon = Icons.info;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              summaryIcon,
              color: AppColors.getRiskTextColor(riskLevel),
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                summaryText,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.gray700,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String recommendation) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.teal600,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              recommendation,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.gray700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
    );
  }
}
