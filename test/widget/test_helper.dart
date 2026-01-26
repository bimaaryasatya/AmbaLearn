import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_layout/providers/auth_provider.dart';
import 'package:capstone_layout/providers/chat_provider.dart';
import 'package:capstone_layout/providers/theme_provider.dart';
import 'package:capstone_layout/providers/language_provider.dart';
import 'package:capstone_layout/models/user_model.dart';
import 'package:capstone_layout/models/chat_session_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:capstone_layout/l10n/app_localizations.dart';

// Mocks
class MockAuthProvider extends ChangeNotifier implements AuthProvider {
  bool _isLoading = false;

  @override
  bool get isLoading => _isLoading;

  @override
  bool get isLoggedIn => false;

  @override
  User? get user => null;

  @override
  Future<String?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 10)); // simulate network
    _isLoading = false;
    notifyListeners();
    return null; // success
  }

  @override
  Future<String?> loginWithGoogle() async {
    return null;
  }

  @override
  Future<String?> register(
    String username,
    String email,
    String password,
  ) async {
    return null;
  }

  @override
  Future<void> fetchCurrentUser() async {}

  @override
  Future<void> logout() async {}

  @override
  String? validateEmail(String email) => null;
  @override
  String? validatePassword(String password) => null;
  @override
  String? validateUsername(String username) => null;
}

class MockChatProvider extends ChangeNotifier implements ChatProvider {
  @override
  List<ChatSession> get sessions => [
    ChatSession(
      uid: '1',
      title: 'Test Chat',
      lastModified: '2023-01-01T12:00:00',
    ),
  ];

  @override
  bool get isLoadingSessions => false;

  @override
  String? get currentSessionUid => null;

  @override
  List<Map<String, dynamic>> get messages => [];

  @override
  bool get isChatLoading => false;

  @override
  bool get isSending => false;

  @override
  String? get error => null;

  @override
  bool get isDraft => true;

  @override
  Future<void> loadSessions() async {}

  @override
  void startNewChat() {}

  @override
  Future<void> loadSession(String uid) async {}

  @override
  Future<void> sendMessage(String text) async {}

  @override
  void clearError() {}

  @override
  void resetState() {}
}

class MockThemeProvider extends ChangeNotifier implements ThemeProvider {
  @override
  ThemeModeOption get themeMode => ThemeModeOption.light;

  @override
  ThemeMode get materialThemeMode => ThemeMode.light;

  @override
  bool get isDarkMode => false;

  @override
  IconData get themeModeIcon => Icons.light_mode;

  @override
  String get themeModeDisplayName => "Light";

  @override
  Future<void> cycleThemeMode() async {}

  @override
  Future<void> init() async {}

  @override
  Future<void> setThemeMode(ThemeModeOption mode) async {}

  @override
  Future<void> toggleTheme() async {}
}

class MockLanguageProvider extends ChangeNotifier implements LanguageProvider {
  @override
  Locale get locale => const Locale('en');

  @override
  bool get isIndonesian => false;

  @override
  Future<void> setLanguage(String code) async {}

  @override
  Future<void> changeLanguage(Locale newLocale) async {}

  @override
  Future<void> init() async {}
}

// Widget Wrapper
Widget createWidgetUnderTests({
  required Widget child,
  AuthProvider? authProvider,
  ChatProvider? chatProvider,
  ThemeProvider? themeProvider,
  LanguageProvider? languageProvider,
}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (_) => authProvider ?? MockAuthProvider(),
      ),
      ChangeNotifierProvider<ChatProvider>(
        create: (_) => chatProvider ?? MockChatProvider(),
      ),
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => themeProvider ?? MockThemeProvider(),
      ),
      ChangeNotifierProvider<LanguageProvider>(
        create: (_) => languageProvider ?? MockLanguageProvider(),
      ),
    ],
    child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
      // Add routes if needed for navigation tests
      onGenerateRoute: (settings) {
        // Generic mock for all named routes
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            if (settings.name == '/register') {
              return const Material(
                child: Text("Create Account"),
              ); // Mock Register Page content
            }
            return const Material(child: Text("Mock Page"));
          },
        );
      },
    ),
  );
}
