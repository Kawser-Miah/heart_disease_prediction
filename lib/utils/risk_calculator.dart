import '../models/health_assessment.dart';

class RiskResult {
  final List<String> recommendations;
  final List<FactorContribution> contributingFactors;

  RiskResult({
    required this.recommendations,
    required this.contributingFactors,
  });
}

class RiskCalculator {
  RiskResult calculateRisk(FormData data, String riskLevel,String foreignKey) {
    // int riskScore = 0;
    final List<FactorContribution> factors = [];

    // Age factor
    final age = int.tryParse(data.age) ?? 0;
    if (age > 60) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'age',
          factorName: 'Age Over 60',
          impact: 'high',
          contribution: 0.25,
          explanation:
              'Age is a significant risk factor. People over 60 have higher cardiovascular risk.',
        ),
      );
    } else if (age > 50) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'age',
          factorName: 'Age 50-60',
          impact: 'medium',
          contribution: 0.15,
          explanation:
              'Age between 50-60 moderately increases cardiovascular risk.',
        ),
      );
    } else if (age > 40) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'age',
          factorName: 'Age 40-50',
          impact: 'low',
          contribution: 0.10,
          explanation: 'Age between 40-50 slightly increases risk.',
        ),
      );
    }

    // Chest pain type
    switch (data.chestPainType) {

      case 'typical':
        factors.add(
          FactorContribution(
            foreignKey: foreignKey,
            type: 'chestPain',
            factorName: 'Typical Angina',
            impact: 'high',
            contribution: 0.30,
            explanation:
                'Typical angina indicates significant coronary artery disease risk.',
          ),
        );
        break;
      case 'atypical':
        factors.add(
          FactorContribution(
            foreignKey: foreignKey,
            type: 'chestPain',
            factorName: 'Atypical Angina',
            impact: 'medium',
            contribution: 0.20,
            explanation:
                'Atypical angina may indicate cardiovascular concerns.',
          ),
        );
        break;
      case 'non-anginal':
        factors.add(
          FactorContribution(
            foreignKey: foreignKey,
            type: 'chestPain',
            factorName: 'Non-Anginal Pain',
            impact: 'low',
            contribution: 0.10,
            explanation: 'Non-anginal chest pain has lower cardiac risk.',
          ),
        );
        break;
    }

    // Blood pressure
    final bp = int.tryParse(data.restingBP) ?? 0;
    if (bp > 140) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'bloodPressure',
          factorName: 'High Blood Pressure',
          impact: 'high',
          contribution: 0.20,
          explanation:
              'Blood pressure over 140 mmHg indicates hypertension, a major risk factor.',
        ),
      );
    } else if (bp > 130) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'bloodPressure',
          factorName: 'Elevated Blood Pressure',
          impact: 'medium',
          contribution: 0.12,
          explanation: 'Blood pressure over 130 mmHg is considered elevated.',
        ),
      );
    }

    // Cholesterol
    final chol = int.tryParse(data.cholesterol) ?? 0;
    if (chol > 240) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'cholesterol',
          factorName: 'High Cholesterol',
          impact: 'high',
          contribution: 0.18,
          explanation:
              'Cholesterol over 240 mg/dL significantly increases heart disease risk.',
        ),
      );
    } else if (chol > 200) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'cholesterol',
          factorName: 'Borderline High Cholesterol',
          impact: 'medium',
          contribution: 0.12,
          explanation: 'Cholesterol over 200 mg/dL is borderline high.',
        ),
      );
    }

    // Max heart rate
    final maxHR = int.tryParse(data.maxHeartRate) ?? 0;
    final expectedMaxHR = 220 - age;
    if (maxHR < expectedMaxHR * 0.7) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'heartRate',
          factorName: 'Low Exercise Capacity',
          impact: 'medium',
          contribution: 0.15,
          explanation:
              'Lower maximum heart rate may indicate reduced cardiac fitness.',
        ),
      );
    }

    // Exercise-induced angina
    if (data.exerciseInducedAngina) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'exerciseAngina',
          factorName: 'Exercise-Induced Angina',
          impact: 'high',
          contribution: 0.22,
          explanation:
              'Chest pain during exercise is a strong indicator of coronary artery disease.',
        ),
      );
    }

    // Fasting blood sugar
    if (data.fastingBloodSugar) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'bloodSugar',
          factorName: 'Elevated Fasting Blood Sugar',
          impact: 'medium',
          contribution: 0.10,
          explanation:
              'High fasting blood sugar increases cardiovascular risk.',
        ),
      );
    }

    // ST Depression
    final stDep = double.tryParse(data.stDepression) ?? 0;
    if (stDep > 2) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'stDepression',
          factorName: 'Significant ST Depression',
          impact: 'high',
          contribution: 0.25,
          explanation:
              'ST depression > 2mm indicates significant cardiac ischemia.',
        ),
      );
    } else if (stDep > 1) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'stDepression',
          factorName: 'Moderate ST Depression',
          impact: 'medium',
          contribution: 0.15,
          explanation: 'ST depression > 1mm may indicate cardiac issues.',
        ),
      );
    }

    // Number of major vessels
    final numVessels = int.tryParse(data.numVessels) ?? 0;
    if (numVessels >= 2) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'vessels',
          factorName: 'Multiple Vessel Disease',
          impact: 'high',
          contribution: 0.30,
          explanation:
              'Blockage in $numVessels or more vessels indicates severe coronary disease.',
        ),
      );
    } else if (numVessels == 1) {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'vessels',
          factorName: 'Single Vessel Disease',
          impact: 'medium',
          contribution: 0.18,
          explanation: 'Blockage in 1 vessel indicates moderate risk.',
        ),
      );
    }

    // Thalassemia
    if (data.thalassemia == 'reversible-defect') {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'thalassemia',
          factorName: 'Reversible Perfusion Defect',
          impact: 'high',
          contribution: 0.20,
          explanation:
              'Reversible defect indicates ischemia and potential for heart attack.',
        ),
      );
    } else if (data.thalassemia == 'fixed-defect') {
      factors.add(
        FactorContribution(
          foreignKey: foreignKey,
          type: 'thalassemia',
          factorName: 'Fixed Perfusion Defect',
          impact: 'medium',
          contribution: 0.15,
          explanation: 'Fixed defect indicates previous heart damage.',
        ),
      );
    }

    // Generate recommendations
    final recommendations = generateRecommendations(riskLevel, factors);

    return RiskResult(
      recommendations: recommendations,
      contributingFactors: factors,
    );
  }

  List<String> generateRecommendations(
    String riskLevel,
    List<FactorContribution> factors,
  ) {
    final recommendations = <String>[];

    // Universal recommendations
    recommendations.add(
      'Schedule regular check-ups with your cardiologist to monitor your heart health.',
    );

    if (riskLevel == 'high') {
      recommendations.add(
        'URGENT: Consult with a cardiologist immediately for a comprehensive evaluation.',
      );
      recommendations.add(
        'Consider advanced cardiac testing such as coronary angiography.',
      );
      recommendations.add(
        'Discuss medication options with your doctor, including statins and blood pressure medications.',
      );
    }

    if (riskLevel == 'medium' || riskLevel == 'high') {
      recommendations.add(
        'Adopt a heart-healthy diet low in saturated fats, trans fats, and sodium.',
      );
      recommendations.add(
        'Aim for at least 150 minutes of moderate aerobic activity per week.',
      );
    }

    // Specific recommendations based on factors
    for (var factor in factors) {
      if (factor.type.contains('cholesterol')) {
        recommendations.add(
          'Work on lowering cholesterol through diet changes and possibly medication.',
        );
      }

      if (factor.type.contains('bloodPressure')) {
        recommendations.add(
          'Monitor blood pressure daily and work to reduce it through lifestyle changes.',
        );
      }

      if (factor.type.contains('bloodSugar')) {
        recommendations.add(
          'Control blood sugar levels through diet, exercise, and medication if needed.',
        );
      }

      if (factor.type.contains('exerciseAngina')) {
        recommendations.add(
          'Avoid strenuous exercise until cleared by your cardiologist.',
        );
      }
    }

    if (riskLevel == 'low') {
      recommendations.add(
        'Maintain a healthy lifestyle with regular exercise and balanced nutrition.',
      );
      recommendations.add(
        'Continue monitoring your cardiovascular health annually.',
      );
    }

    recommendations.add(
      'Manage stress through relaxation techniques, meditation, or yoga.',
    );
    recommendations.add(
      'If you smoke, seek help to quit immediately as smoking significantly increases heart disease risk.',
    );

    return recommendations;
  }
}
