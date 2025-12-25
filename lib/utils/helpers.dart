import 'package:intl/intl.dart';

class DateFormatter {
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning 🌅';
    } else if (hour < 17) {
      return 'Good Afternoon ☀️';
    } else {
      return 'Good Evening 🌙';
    }
  }

  static String formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    }
  }
}

class Validators {
  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }
    final age = int.tryParse(value);
    if (age == null) {
      return 'Please enter a valid number';
    }
    if (age < 18 || age > 120) {
      return 'Age must be between 18 and 120';
    }
    return null;
  }

  static String? validateBloodPressure(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter blood pressure';
    }
    final bp = int.tryParse(value);
    if (bp == null) {
      return 'Please enter a valid number';
    }
    if (bp < 80 || bp > 250) {
      return 'BP must be between 80 and 250 mmHg';
    }
    return null;
  }

  static String? validateCholesterol(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter cholesterol level';
    }
    final chol = int.tryParse(value);
    if (chol == null) {
      return 'Please enter a valid number';
    }
    if (chol < 100 || chol > 600) {
      return 'Cholesterol must be between 100 and 600 mg/dL';
    }
    return null;
  }

  static String? validateHeartRate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter heart rate';
    }
    final hr = int.tryParse(value);
    if (hr == null) {
      return 'Please enter a valid number';
    }
    if (hr < 40 || hr > 250) {
      return 'Heart rate must be between 40 and 250 bpm';
    }
    return null;
  }

  static String? validateSTDepression(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter ST depression value';
    }
    final st = double.tryParse(value);
    if (st == null) {
      return 'Please enter a valid number';
    }
    if (st < 0 || st > 10) {
      return 'ST depression must be between 0 and 10';
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
