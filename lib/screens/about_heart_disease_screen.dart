import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../config/app_colors.dart';

class AboutHeartDiseaseScreen extends StatelessWidget {
  const AboutHeartDiseaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Heart Disease'),
        backgroundColor: AppColors.teal600,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: HtmlWidget(aboutHeartDiseaseHtml),
      ),
    );
  }
}

final String aboutHeartDiseaseHtml =
    '  <div style="padding:16px;">\n'
    '  \n'
    '  <p style="font-size:14px; color:#555555; text-align:center; margin-bottom:20px;">\n'
    '    Understanding heart health, risks, and prevention\n'
    '  </p>\n'
    '  \n'
    '  <div style="background-color:#fbe9e7; padding:12px; margin-bottom:12px; border-radius:8px;">\n'
    '    <b><span style="color:#d32f2f;">❤️</span> What Is Heart Disease?</b>\n'
    '    <p style="font-size:14px; margin-top:6px;">\n'
    '      Heart disease refers to conditions that affect the heart and blood vessels.\n'
    '      It often develops due to blocked arteries, high blood pressure, or damage\n'
    '      to the heart muscles.\n'
    '    </p>\n'
    '  </div>\n'
    '  \n'
    '  <div style="background-color:#e3f2fd; padding:12px; margin-bottom:12px; border-radius:8px;">\n'
    '    <b><span style="color:#f57c00;">⚠️</span> Common Risk Factors</b>\n'
    '    <p style="font-size:14px; margin-top:6px;">\n'
    '      Major risk factors include smoking, unhealthy diet, lack of physical activity,\n'
    '      obesity, high cholesterol, high blood pressure, diabetes, and stress.\n'
    '    </p>\n'
    '  </div>\n'
    '  \n'
    '  <div style="background-color:#e8f5e9; padding:12px; margin-bottom:12px; border-radius:8px;">\n'
    '    <b>🩺 Common Symptoms</b>\n'
    '    <p style="font-size:14px; margin-top:6px;">\n'
    '      Symptoms may include chest pain, shortness of breath, fatigue, dizziness,\n'
    '      irregular heartbeat, or swelling in legs and feet. Some people may have\n'
    '      no symptoms at early stages.\n'
    '    </p>\n'
    '  </div>\n'
    '  \n'
    '  <div style="background-color:#fffde7; padding:12px; margin-bottom:12px; border-radius:8px;">\n'
    '    <b>🛡️ Prevention & Care</b>\n'
    '    <p style="font-size:14px; margin-top:6px;">\n'
    '      Heart disease can often be prevented by eating healthy food, exercising\n'
    '      regularly, avoiding smoking, managing stress, and checking blood pressure\n'
    '      and cholesterol levels regularly.\n'
    '    </p>\n'
    '  </div>\n'
    '  \n'
    '  <div style="background-color:#f3e5f5; padding:12px; border-radius:8px;">\n'
    '    <b>📌 When to See a Doctor</b>\n'
    '    <p style="font-size:14px; margin-top:6px;">\n'
    '      If you experience chest pain, severe shortness of breath, or unusual fatigue,\n'
    '      seek medical attention immediately. Early diagnosis can save lives.\n'
    '    </p>\n'
    '  </div>\n'
    '  \n'
    '  </div>';
