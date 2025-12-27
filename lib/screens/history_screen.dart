import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/assessment_bloc.dart';
import '../blocs/assessment_event.dart';
import '../blocs/assessment_state.dart';
import '../config/app_colors.dart';
import '../utils/helpers.dart';
import 'result_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Load history when screen opens
    context.read<AssessmentBloc>().add(const LoadAssessmentHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment History'),
        backgroundColor: AppColors.teal600,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<AssessmentBloc, AssessmentState>(
        builder: (context, state) {
          if (state is AssessmentHistoryLoaded) {
            if (state.assessments.isEmpty) {
              return _buildEmptyState();
            }
            return _buildHistoryList(state.assessments);
          } else if (state is AssessmentError) {
            return _buildEmptyState();
          }

          return const Center(
            child: CircularProgressIndicator(color: AppColors.teal600),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.teal50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.description_outlined,
                size: 64,
                color: AppColors.teal600,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Assessments Yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your heart health assessment history will appear here',
              style: TextStyle(fontSize: 14, color: AppColors.gray600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(List assessments) {
    return Column(
      children: [
        // Stats header
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.teal600, AppColors.primaryTeal],
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Total',
                '${assessments.length}',
                Icons.assessment,
              ),
              Container(width: 1, height: 40, color: Colors.white24),
              _buildStatItem(
                'This Month',
                '${assessments.where((a) => a.date.month == DateTime.now().month).length}',
                Icons.calendar_today,
              ),
              Container(width: 1, height: 40, color: Colors.white24),
              _buildStatItem(
                'Last',
                DateFormatter.formatRelative(assessments.first.date),
                Icons.schedule,
              ),
            ],
          ),
        ),

        // List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: assessments.length,
            itemBuilder: (context, index) {
              final assessment = assessments[index];
              return _buildHistoryCard(assessment);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: AppColors.teal100, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(assessment) {
    final riskLevel = assessment.riskLevel;
    final bgColor = AppColors.getRiskBackgroundColor(riskLevel);
    final textColor = AppColors.getRiskTextColor(riskLevel);
    final riskText = riskLevel[0].toUpperCase() + riskLevel.substring(1);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ResultScreen(assessment: assessment),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormatter.formatDate(assessment.date),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gray900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormatter.formatTime(assessment.date),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$riskText Risk',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Risk percentage bar
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: assessment.riskPercentage,
                        minHeight: 8,
                        backgroundColor: AppColors.gray200,
                        valueColor: AlwaysStoppedAnimation<Color>(textColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${(assessment.riskPercentage * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(
                    Icons.chevron_right,
                    color: AppColors.teal600,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Tap to view details',
                    style: TextStyle(fontSize: 12, color: AppColors.teal600),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    color: AppColors.gray500,
                    onPressed: () {
                      _showDeleteConfirmation(assessment.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(String assessmentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Assessment'),
        content: const Text(
          'Are you sure you want to delete this assessment? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AssessmentBloc>().add(
                DeleteAssessment(assessmentId),
              );
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Assessment deleted'),
                  backgroundColor: AppColors.teal600,
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.redDark),
            ),
          ),
        ],
      ),
    );
  }
}
