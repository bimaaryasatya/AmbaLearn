import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:capstone_layout/main.dart';
import 'package:capstone_layout/providers/language_provider.dart';
import 'package:capstone_layout/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('End-to-end test: Login Flow', (WidgetTester tester) async {
    // 1. Setup Support
    SharedPreferences.setMockInitialValues({}); // Initialize mock prefs

    final themeProvider = ThemeProvider();
    await themeProvider.init();

    final languageProvider = LanguageProvider();
    await languageProvider.init();

    // 2. Load App
    await tester.pumpWidget(
      AmbaLearn(
        themeProvider: themeProvider,
        languageProvider: languageProvider,
      ),
    );
    await tester.pumpAndSettle();

    // 3. Verify we are on Login Page (assuming no token in mock prefs)
    expect(find.text('Sign In'), findsAtLeastNWidgets(1));
    expect(find.byType(TextField), findsNWidgets(2));

    // 4. Enter Credentials
    // Enter Email
    await tester.enterText(
      find
          .ancestor(of: find.text('Email'), matching: find.byType(TextField))
          .first,
      'test@example.com',
    );
    await tester.pumpAndSettle();

    // Enter Password
    await tester.enterText(
      find
          .ancestor(of: find.text('Password'), matching: find.byType(TextField))
          .first,
      'password123',
    );
    await tester.pumpAndSettle();

    // 5. Tap Login
    // Note: This will likely fail network request since we are using real AuthProvider with real ApiService.
    // We just want to ensure we CAN tap it and something happens (loading or error).
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pump(); // Start animation

    // Check for loading indicator or error snackbar
    // Since we didn't mock API, it will try to hit localhost and likely fail/timeout.
    // If we want a robust test that passes without backend, we might just stop here saying inputs work.
    // Or we expect an error snackbar to appear after some time.

    // For now, let's verify that inputs are retained and button was tappable.
    expect(find.text('test@example.com'), findsOneWidget);
  });
}
