class AppConstants {
  // App Info
  static const String appName = 'CardioCare AI';
  static const String appTagline = 'Early detection. Better heart health.';

  // Storage Keys
  static const String keyAssessments = 'assessments';
  static const String keyUserProfile = 'user_profile';
  static const String keyOnboardingComplete = 'onboarding_complete';

  // Risk Levels
  static const String riskLow = 'low';
  static const String riskMedium = 'medium';
  static const String riskHigh = 'high';

  // Chest Pain Types
  static const Map<String, String> chestPainTypes = {
    '0': 'Typical Angina',
    '1': 'Atypical Angina',
    '2': 'Non-Anginal Pain',
    '3': 'Asymptomatic',
  };

  // Resting ECG Types
  static const Map<String, String> restingECGTypes = {
    '0': 'Normal',
    '1': 'ST-T Wave Abnormality',
    '2': 'Left Ventricular Hypertrophy',
  };

  // ST Slope Types
  static const Map<String, String> stSlopeTypes = {
    '0': 'Upsloping',
    '1': 'Flat',
    '2': 'Downsloping',
  };

  // Thalassemia Types
  static const Map<String, String> thalassemiaTypes = {
    '0': 'Normal',
    '1': 'Fixed Defect',
    '2': 'Reversible Defect',
  };

  // Number of Vessels Options
  static const List<String> numVesselsOptions = ['0', '1', '2', '3', '4'];

  // Sex Options
  static const Map<String, String> sexOptions = {
    '0': 'Male',
    '1': 'Female',
  };

  // Validation
  static const int minAge = 18;
  static const int maxAge = 120;
  static const int minBP = 80;
  static const int maxBP = 250;
  static const int minCholesterol = 100;
  static const int maxCholesterol = 600;
  static const int minHeartRate = 40;
  static const int maxHeartRate = 250;
  static const double minSTDepression = 0.0;
  static const double maxSTDepression = 10.0;
}
