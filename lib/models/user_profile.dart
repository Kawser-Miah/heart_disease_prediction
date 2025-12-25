import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String emergencyContact;
  final String bloodType;
  final DateTime dateOfBirth;
  final String avatarUrl;

  const UserProfile({
    required this.name,
    required this.email,
    this.phone = '',
    this.emergencyContact = '',
    this.bloodType = '',
    required this.dateOfBirth,
    this.avatarUrl = '',
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? emergencyContact,
    String? bloodType,
    DateTime? dateOfBirth,
    String? avatarUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      bloodType: bloodType ?? this.bloodType,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        emergencyContact,
        bloodType,
        dateOfBirth,
        avatarUrl,
      ];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'emergencyContact': emergencyContact,
      'bloodType': bloodType,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'avatarUrl': avatarUrl,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String? ?? '',
      emergencyContact: json['emergencyContact'] as String? ?? '',
      bloodType: json['bloodType'] as String? ?? '',
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      avatarUrl: json['avatarUrl'] as String? ?? '',
    );
  }
}
