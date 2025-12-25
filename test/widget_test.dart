// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:heart_disease_prediction/main.dart';
import 'package:heart_disease_prediction/utils/storage_service.dart';
import 'package:heart_disease_prediction/utils/risk_calculator.dart';

void main() {
  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    // Initialize mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Create required dependencies
    final storageService = StorageService(prefs);
    final riskCalculator = RiskCalculator();

    // Build our app and trigger a frame.
    // await tester.pumpWidget(
    //   MyApp(storageService: storageService, riskCalculator: riskCalculator),
    // );

    // Verify that splash screen is displayed
    expect(find.byType(MyApp), findsOneWidget);
  });
}
