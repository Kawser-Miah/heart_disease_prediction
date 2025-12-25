import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

class HealthAssessment extends Equatable {
  final String id;
  final DateTime date;
  final bool prediction;
  final String riskLevel;
  final double riskPercentage;
  final List<String> recommendations;
  final List<FactorContribution> contributingFactors;

  const HealthAssessment({
    required this.id,
    required this.date,
    required this.prediction,
    required this.riskLevel,
    required this.riskPercentage,
    required this.recommendations,
    required this.contributingFactors,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    prediction,
    riskLevel,
    riskPercentage,
    recommendations,
    contributingFactors,
  ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'riskLevel': riskLevel,
      'riskPercentage': riskPercentage,
      'recommendations': recommendations,
      'contributingFactors': contributingFactors,
    };
  }

  factory HealthAssessment.fromJson(Map<String, dynamic> json) {
    return HealthAssessment(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      prediction: json['prediction'] as bool,
      riskLevel: json['riskLevel'] as String,
      riskPercentage: (json['riskPercentage'] as num).toDouble(),
      recommendations: List<String>.from(json['recommendations'] as List),
      contributingFactors: List<FactorContribution>.from(
        json['contributingFactors'] as List,
      ),
    );
  }
}

class FormData extends Equatable {
  final String age;
  final String sex;
  final String chestPainType;
  final bool exerciseInducedAngina;
  final String stDepression;
  final String restingBP;
  final String cholesterol;
  final String maxHeartRate;
  final bool fastingBloodSugar;
  final String restingECG;
  final String stSlope;
  final String numVessels;
  final String thalassemia;

  const FormData({
    this.age = '',
    this.sex = '',
    this.chestPainType = '',
    this.exerciseInducedAngina = false,
    this.stDepression = '',
    this.restingBP = '',
    this.cholesterol = '',
    this.maxHeartRate = '',
    this.fastingBloodSugar = false,
    this.restingECG = '',
    this.stSlope = '',
    this.numVessels = '',
    this.thalassemia = '',
  });

  FormData copyWith({
    String? age,
    String? sex,
    String? chestPainType,
    bool? exerciseInducedAngina,
    String? stDepression,
    String? restingBP,
    String? cholesterol,
    String? maxHeartRate,
    bool? fastingBloodSugar,
    String? restingECG,
    String? stSlope,
    String? numVessels,
    String? thalassemia,
  }) {
    return FormData(
      age: age ?? this.age,
      sex: sex ?? this.sex,
      chestPainType: chestPainType ?? this.chestPainType,
      exerciseInducedAngina:
          exerciseInducedAngina ?? this.exerciseInducedAngina,
      stDepression: stDepression ?? this.stDepression,
      restingBP: restingBP ?? this.restingBP,
      cholesterol: cholesterol ?? this.cholesterol,
      maxHeartRate: maxHeartRate ?? this.maxHeartRate,
      fastingBloodSugar: fastingBloodSugar ?? this.fastingBloodSugar,
      restingECG: restingECG ?? this.restingECG,
      stSlope: stSlope ?? this.stSlope,
      numVessels: numVessels ?? this.numVessels,
      thalassemia: thalassemia ?? this.thalassemia,
    );
  }

  bool get isValid {
    return age.isNotEmpty &&
        chestPainType.isNotEmpty &&
        stDepression.isNotEmpty &&
        restingBP.isNotEmpty &&
        cholesterol.isNotEmpty &&
        maxHeartRate.isNotEmpty &&
        restingECG.isNotEmpty &&
        stSlope.isNotEmpty &&
        numVessels.isNotEmpty &&
        thalassemia.isNotEmpty;
  }

  @override
  List<Object?> get props => [
    age,
    sex,
    chestPainType,
    exerciseInducedAngina,
    stDepression,
    restingBP,
    cholesterol,
    maxHeartRate,
    fastingBloodSugar,
    restingECG,
    stSlope,
    numVessels,
    thalassemia,
  ];

  Map<String, dynamic> toJson() {
    return {
      'age': int.tryParse(age) ?? 0,
      'sex': int.tryParse(sex) ?? 0,
      'cp': int.tryParse(chestPainType) ?? 0,
      'exang': exerciseInducedAngina ? 1 : 0,
      'oldpeak': double.tryParse(stDepression) ?? 0.0,
      'trestbps': int.tryParse(restingBP) ?? 0,
      'chol': int.tryParse(cholesterol) ?? 0,
      'thalach': int.tryParse(maxHeartRate) ?? 0,
      'fbs': fastingBloodSugar ? 1 : 0,
      'restecg': int.tryParse(restingECG) ?? 0,
      'slope': int.tryParse(stSlope) ?? 0,
      'ca': int.tryParse(numVessels) ?? 0,
      'thal': int.tryParse(thalassemia) ?? 0,
    };
  }

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      age: json['age'] as String? ?? '',
      sex: json['sex'] as String? ?? '',
      chestPainType: json['chestPainType'] as String? ?? '',
      exerciseInducedAngina: json['exerciseInducedAngina'] as bool? ?? false,
      stDepression: json['stDepression'] as String? ?? '',
      restingBP: json['restingBP'] as String? ?? '',
      cholesterol: json['cholesterol'] as String? ?? '',
      maxHeartRate: json['maxHeartRate'] as String? ?? '',
      fastingBloodSugar: json['fastingBloodSugar'] as bool? ?? false,
      restingECG: json['restingECG'] as String? ?? '',
      stSlope: json['stSlope'] as String? ?? '',
      numVessels: json['numVessels'] as String? ?? '',
      thalassemia: json['thalassemia'] as String? ?? '',
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "FromData(Age: $age, Sex: $sex, Chest Pain Type: $chestPainType, Exercise Induced Angina: $exerciseInducedAngina, ST Depression: $stDepression, Resting BP: $restingBP, Cholesterol: $cholesterol, Max Heart Rate: $maxHeartRate, Fasting Blood Sugar: $fastingBloodSugar, Resting ECG: $restingECG, ST Slope: $stSlope, Num Vessels: $numVessels, Thalassemia: $thalassemia)";
  }
}

@entity
class FactorContribution extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? foreignKey;
  final String type;
  final String factorName;
  final String impact; // 'high', 'medium', 'low'
  final double contribution; // 0.0 to 1.0
  final String explanation;

  const FactorContribution({
    this.id,
    this.foreignKey,
    required this.type,
    required this.factorName,
    required this.impact,
    required this.contribution,
    required this.explanation,
  });

  @override
  List<Object?> get props => [factorName, impact, contribution, explanation];

  Map<String, dynamic> toJson() {
    return {
      'type': type, // 'age', 'chestPain', 'bloodPressure', etc.'
      'factorName': factorName,
      'impact': impact,
      'contribution': contribution,
      'explanation': explanation,
    };
  }

  factory FactorContribution.fromJson(Map<String, dynamic> json) {
    return FactorContribution(
      type: json['type'] as String,
      factorName: json['factorName'] as String,
      impact: json['impact'] as String,
      contribution: (json['contribution'] as num).toDouble(),
      explanation: json['explanation'] as String,
    );
  }
}

@entity
class HealthAssessmentEntity {
  @primaryKey
  final String id;
  final String date;
  final bool prediction;
  final String riskLevel;
  final double riskPercentage;

  const HealthAssessmentEntity({
    required this.id,
    required this.date,
    required this.prediction,
    required this.riskLevel,
    required this.riskPercentage,
  });
}
