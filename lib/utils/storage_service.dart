import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/health_assessment.dart';
import '../models/user_profile.dart';
import '../config/app_constants.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Assessment operations
  Future<List<HealthAssessment>> getAssessments() async {
    try {
      final String? assessmentsJson =
          _prefs.getString(AppConstants.keyAssessments);
      if (assessmentsJson == null) return [];

      final List<dynamic> decoded = jsonDecode(assessmentsJson);
      return decoded
          .map(
              (json) => HealthAssessment.fromJson(json as Map<String, dynamic>))
          .toList()
        ..sort(
            (a, b) => b.date.compareTo(a.date)); // Sort by date, newest first
    } catch (e) {
      return [];
    }
  }

  Future<void> saveAssessment(HealthAssessment assessment) async {
    try {
      final assessments = await getAssessments();
      assessments.insert(0, assessment); // Add to beginning

      final encoded = jsonEncode(assessments.map((a) => a.toJson()).toList());
      await _prefs.setString(AppConstants.keyAssessments, encoded);
    } catch (e) {
      throw Exception('Failed to save assessment: $e');
    }
  }

  Future<void> deleteAssessment(String assessmentId) async {
    try {
      final assessments = await getAssessments();
      assessments.removeWhere((a) => a.id == assessmentId);

      final encoded = jsonEncode(assessments.map((a) => a.toJson()).toList());
      await _prefs.setString(AppConstants.keyAssessments, encoded);
    } catch (e) {
      throw Exception('Failed to delete assessment: $e');
    }
  }

  Future<void> clearAllAssessments() async {
    await _prefs.remove(AppConstants.keyAssessments);
  }

  // User profile operations
  Future<UserProfile> getUserProfile() async {
    try {
      final String? profileJson = _prefs.getString(AppConstants.keyUserProfile);
      if (profileJson == null) {
        // Return default profile
        return UserProfile(
          name: 'John Doe',
          email: 'john.doe@example.com',
          phone: '+1 (555) 123-4567',
          emergencyContact: '+1 (555) 987-6543',
          bloodType: 'O+',
          dateOfBirth: DateTime(1985, 1, 1),
        );
      }

      final decoded = jsonDecode(profileJson);
      return UserProfile.fromJson(decoded as Map<String, dynamic>);
    } catch (e) {
      // Return default profile on error
      return UserProfile(
        name: 'John Doe',
        email: 'john.doe@example.com',
        dateOfBirth: DateTime(1985, 1, 1),
      );
    }
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    try {
      final encoded = jsonEncode(profile.toJson());
      await _prefs.setString(AppConstants.keyUserProfile, encoded);
    } catch (e) {
      throw Exception('Failed to save profile: $e');
    }
  }

  // Onboarding status
  Future<bool> isOnboardingComplete() async {
    return _prefs.getBool(AppConstants.keyOnboardingComplete) ?? false;
  }

  Future<void> setOnboardingComplete(bool value) async {
    await _prefs.setBool(AppConstants.keyOnboardingComplete, value);
  }
}
