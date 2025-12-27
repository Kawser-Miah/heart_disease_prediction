import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../config/app_colors.dart';

class HeartHealthTipsScreen extends StatelessWidget {
  const HeartHealthTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Health Tips'),
        backgroundColor: AppColors.teal600,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(child: HtmlWidget(heartHealthHtml)),
    );
  }
}

final String heartHealthHtml =
    '  <div style="padding:16px;">\n'
    '  \n'
    '  <p style="font-size:14px; color:#555555; text-align:center; margin-bottom:20px;">\n'
    '    Daily lifestyle choices for a healthy heart\n'
    '  </p>\n'
    '  \n'
    '  <div style="background-color:#fff3f3; padding:12px; border-radius:8px; margin-bottom:12px;">\n'
    '    <b>🥗 Eat Smart</b>\n'
    '    <p style="font-size:14px; margin-top:6px;">\n'
    '      Eat fruits, vegetables, whole grains, and reduce salt, sugar, and oily food.\n'
    '    </p>\n'
    '  </div>\n'
    '  \n'
    '  <div style="background-color:#f1f8ff; padding:12px; border-radius:8px; margin-bottom:12px;">\n'
    '    <b>🚶 Stay Active</b>\n'
    '    <p style="font-size:14px; margin-top:6px;">\n'
    '      Walk or exercise at least 30 minutes a day and avoid sitting too long.\n'
    '    </p>\n'
    '  </div>\n'
    '  \n'
    '  <div style="background-color:#fff7e6; padding:12px; border-radius:8px; margin-bottom:12px;">\n'
    '    <b>🚭 Avoid Smoking</b>\n'
    '    <p style="font-size:14px; margin-top:6px;">\n'
    '      Smoking damages your heart and increases the risk of heart disease.\n'
    '    </p>\n'
    '  </div>\n'
    '  \n'
    '  <div style="background-color:#f3f4ff; padding:12px; border-radius:8px; margin-bottom:12px;">\n'
    '    <b>😴 Sleep Well</b>\n'
    '    <p style="font-size:14px; margin-top:6px;">\n'
    '      Get 7–8 hours of quality sleep every night for heart recovery.\n'
    '    </p>\n'
    '  </div>\n'
    '  \n'
    '  <div style="background-color:#f0fff4; padding:12px; border-radius:8px; margin-bottom:12px;">\n'
    '    <b>😌 Manage Stress</b>\n'
    '    <p style="font-size:14px; margin-top:6px;">\n'
    '      Reduce stress through prayer, breathing exercises, or relaxation.\n'
    '    </p>\n'
    '  </div>\n'
    '  \n'
    '  <div style="background-color:#e3f2fd; padding:12px; border-radius:8px;">\n'
    '    <b>🩺 Monitor Your Health</b>\n'
    '    <p style="font-size:14px; margin-top:6px;">\n'
    '      Regularly check blood pressure, sugar, and cholesterol levels.\n'
    '    </p>\n'
    '  </div>\n'
    '  \n'
    '  </div>';
