import 'package:flutter/material.dart';

class AppColors {
  // Primary Teal Colors
  static const Color primaryTeal = Color(0xFF0d9488);
  static const Color tealLight = Color(0xFF14b8a6);
  static const Color tealDark = Color(0xFF0f766e);
  static const Color teal50 = Color(0xFFF0FDFA);
  static const Color teal100 = Color(0xFFCCFBF1);
  static const Color teal200 = Color(0xFF99F6E4);
  static const Color teal600 = Color(0xFF0d9488);

  // Status Colors - Green (Low Risk)
  static const Color greenLight = Color(0xFFDCFCE7);
  static const Color greenMedium = Color(0xFF86EFAC);
  static const Color greenDark = Color(0xFF15803D);

  // Status Colors - Yellow (Medium Risk)
  static const Color yellowLight = Color(0xFFFEF9C3);
  static const Color yellowMedium = Color(0xFFFDE047);
  static const Color yellowDark = Color(0xFFA16207);

  // Status Colors - Red (High Risk)
  static const Color redLight = Color(0xFFFEE2E2);
  static const Color redMedium = Color(0xFFFCA5A5);
  static const Color redDark = Color(0xFFB91C1C);

  // Gray Scale
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // Utility Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Get risk color based on level
  static Color getRiskBackgroundColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'low':
        return greenLight;
      case 'medium':
        return yellowLight;
      case 'high':
        return redLight;
      default:
        return gray100;
    }
  }

  static Color getRiskTextColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'low':
        return greenDark;
      case 'medium':
        return yellowDark;
      case 'high':
        return redDark;
      default:
        return gray600;
    }
  }

  static Color getRiskProgressColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'low':
        return greenMedium;
      case 'medium':
        return yellowMedium;
      case 'high':
        return redMedium;
      default:
        return gray400;
    }
  }
}
