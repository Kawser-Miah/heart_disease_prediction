import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/assessment_bloc.dart';
import '../blocs/assessment_event.dart';
import '../blocs/assessment_state.dart';
import '../config/app_colors.dart';
import '../utils/helpers.dart';
import 'check_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load assessment history when home screen initializes
    context.read<AssessmentBloc>().add(const LoadAssessmentHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.teal50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Header
            _buildHeader(),
            // Content
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -48),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                  child: Column(
                    children: [
                      // Last Check Result Card
                      BlocBuilder<AssessmentBloc, AssessmentState>(
                        builder: (context, state) {
                          if (state is AssessmentHistoryLoaded &&
                              state.currentAssessment != null) {
                            return _buildLastCheckCard(
                              state.currentAssessment!.riskLevel,
                              state.currentAssessment!.date,
                            );
                          } else if (state is AssessmentCompleted) {
                            return _buildLastCheckCard(
                              state.assessment.riskLevel,
                              state.assessment.date,
                            );
                          }
                          return _buildNoCheckCard();
                        },
                      ),
                      const SizedBox(height: 24),
                      // Primary CTA
                      _buildPrimaryCTA(),
                      const SizedBox(height: 24),
                      // Quick Access Cards
                      _buildQuickAccessCard(
                        icon: Icons.favorite,
                        color: Colors.blue,
                        title: 'Heart Health Tips',
                        subtitle: 'Learn how to keep your heart healthy',
                        onTap: () {
                          // Navigate to tips screen (to be implemented)
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildQuickAccessCard(
                        icon: Icons.description,
                        color: Colors.purple,
                        title: 'History Reports',
                        subtitle: 'View your past assessments',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HistoryScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildQuickAccessCard(
                        icon: Icons.menu_book,
                        color: Colors.orange,
                        title: 'About Heart Disease',
                        subtitle: 'Understanding cardiovascular health',
                        onTap: () {
                          // Navigate to info screen (to be implemented)
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.teal600, AppColors.primaryTeal],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
          topLeft: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormatter.getGreeting(),
            style: const TextStyle(color: AppColors.teal100, fontSize: 14),
          ),
          const SizedBox(height: 4),
          const Text(
            'Heart Health Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'How is your heart feeling today?',
            style: TextStyle(color: AppColors.teal100, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildLastCheckCard(String risk, DateTime date) {
    final bgColor = AppColors.getRiskBackgroundColor(risk);
    final textColor = AppColors.getRiskTextColor(risk);
    final riskText = risk[0].toUpperCase() + risk.substring(1) + ' Risk';

    return Card(
      elevation: 8,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Last Heart Check',
                      style: TextStyle(fontSize: 12, color: AppColors.gray600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormatter.formatDate(date),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.tealDark,
                      ),
                    ),
                  ],
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
                    riskText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoryScreen()),
                );
              },
              icon: const Text('View detailed results'),
              label: const Icon(Icons.chevron_right, size: 20),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.teal600,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoCheckCard() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryTeal, AppColors.teal600],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(32),
        child: const Column(
          children: [
            Icon(Icons.favorite_border, color: Colors.white, size: 48),
            SizedBox(height: 16),
            Text(
              'No Health Check Yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Start your first heart health assessment',
              style: TextStyle(color: AppColors.teal100, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryCTA() {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CheckScreen()),
        );
      },
      icon: const Icon(Icons.favorite, color: Colors.white),
      label: const Text(
        'Start Heart Health Check',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.teal600,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        shadowColor: AppColors.teal100,
      ),
    );
  }

  Widget _buildQuickAccessCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.gray600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.gray400),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0, _selectedIndex == 0),
              _buildNavItem(Icons.assignment, 'Check', 1, _selectedIndex == 1),
              _buildNavItem(
                Icons.description,
                'Reports',
                2,
                _selectedIndex == 2,
              ),
              _buildNavItem(Icons.person, 'Profile', 3, _selectedIndex == 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, bool isActive) {
    return InkWell(
      onTap: () {
        setState(() => _selectedIndex = index);
        switch (index) {
          case 0:
            // Already on home
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CheckScreen()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HistoryScreen()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.teal600 : AppColors.gray400,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.teal600 : AppColors.gray400,
            ),
          ),
        ],
      ),
    );
  }
}
