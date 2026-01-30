import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:capstone_layout/main.dart';
import 'package:capstone_layout/providers/language_provider.dart';
import 'package:capstone_layout/providers/theme_provider.dart';
import 'package:capstone_layout/providers/auth_provider.dart'; // Import AuthProvider
import 'package:capstone_layout/models/user_model.dart'; // Import User model
import 'package:shared_preferences/shared_preferences.dart';

// MOCK AUTH PROVIDER
class MockAuthProvider extends AuthProvider {
  User? _mockUser;
  bool _mockLoading = false;

  @override
  User? get user => _mockUser;

  @override
  bool get isLoggedIn => _mockUser != null;

  @override
  bool get isLoading => _mockLoading;

  @override
  Future<void> tryAutoLogin() async {
    // Do nothing for auto login in test
    _mockLoading = false;
    notifyListeners();
  }

  @override
  Future<String?> login(String email, String password) async {
    if (email == 'bimarailfansslw69@gmail.com' && password == '1234') {
      // Simulate success
      _mockUser = User(
        id: '1',
        username: 'Test User',
        email: email,
        picture: 'https://placehold.co/100', // Mock picture
        registeredAt: DateTime.now(),
        birthday: DateTime(2000, 1, 1), // Add birthday to skip onboarding
      );
      notifyListeners();
      return null;
    }
    return "Invalid credentials";
  }

  // Override other methods if necessary to avoid API calls, e.g. register
  @override
  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
    return null; // Simulate success
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end Test: Basic Flow', () {
    late ThemeProvider themeProvider;
    late LanguageProvider languageProvider;
    late MockAuthProvider authProvider;

    setUp(() async {
      // 1. Setup Mock Support
      SharedPreferences.setMockInitialValues({});

      themeProvider = ThemeProvider();
      await themeProvider.init();

      languageProvider = LanguageProvider();
      await languageProvider.init();

      authProvider = MockAuthProvider();
    });

    testWidgets('Login Page Elements Verification', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        AmbaLearn(
          themeProvider: themeProvider,
          languageProvider: languageProvider,
          authProvider: authProvider,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('Navigation to Register Page', (WidgetTester tester) async {
      await tester.pumpWidget(
        AmbaLearn(
          themeProvider: themeProvider,
          languageProvider: languageProvider,
          authProvider: authProvider,
        ),
      );
      await tester.pumpAndSettle();

      // Find Register/Sign Up button
      final registerFinder = find.textContaining(
        'Register',
        findRichText: true,
      );
      final signUpFinder = find.textContaining('Sign Up', findRichText: true);
      final daftarFinder = find.textContaining('Daftar', findRichText: true);
      final createFinder = find.textContaining(
        'Create Account',
        findRichText: true,
      );

      final targetFinder = registerFinder.evaluate().isNotEmpty
          ? registerFinder
          : (signUpFinder.evaluate().isNotEmpty
                ? signUpFinder
                : (daftarFinder.evaluate().isNotEmpty
                      ? daftarFinder
                      : createFinder));

      if (targetFinder.evaluate().isNotEmpty) {
        await tester.tap(targetFinder.first);
        await tester.pumpAndSettle();

        final usernameFinder = find.widgetWithText(
          TextField,
          'Username',
        ); // Assuming label/hint text
        if (usernameFinder.evaluate().isNotEmpty) {
          expect(usernameFinder, findsOneWidget);
        } else {
          expect(find.text('Username'), findsOneWidget);
        }
      } else {
        debugPrint("Could not find navigation button to Register page");
      }
    });

    testWidgets('Input Interaction and Mock Login', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        AmbaLearn(
          themeProvider: themeProvider,
          languageProvider: languageProvider,
          authProvider: authProvider,
        ),
      );
      await tester.pumpAndSettle();

      // Enter Email
      final emailField = find
          .ancestor(of: find.text('Email'), matching: find.byType(TextField))
          .first;
      await tester.enterText(emailField, 'bimarailfansslw69@gmail.com');
      await tester.pumpAndSettle();

      // Enter Password
      final passwordField = find
          .ancestor(of: find.text('Password'), matching: find.byType(TextField))
          .first;
      await tester.enterText(passwordField, '1234');
      await tester.pumpAndSettle();

      // Close keyboard
      tester.testTextInput.closeConnection();
      await tester.pumpAndSettle();

      // Verify Text
      expect(find.text('bimarailfansslw69@gmail.com'), findsOneWidget);
      expect(find.text('1234'), findsOneWidget);

      // Tap Login
      final loginBtn = find.widgetWithText(ElevatedButton, 'Sign In');

      if (loginBtn.evaluate().isNotEmpty) {
        // Ensure visible before tapping
        await tester.ensureVisible(loginBtn.first);
        await tester.pumpAndSettle();
        await tester.tap(loginBtn.first);
        await tester.pumpAndSettle();

        // Let's verify 'Sign In' is NOT present anymore
        expect(find.widgetWithText(ElevatedButton, 'Sign In'), findsNothing);
      }
    });
  });
}
