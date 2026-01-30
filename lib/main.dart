import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'l10n/app_localizations.dart';
import 'config/theme_config.dart';

import 'app_entry.dart';

// PROVIDERS
import 'providers/auth_provider.dart';
import 'providers/chat_provider.dart';
import 'providers/course_provider.dart';
import 'providers/exam_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/language_provider.dart';
import 'providers/user_provider.dart';
// PAGES
import 'pages/loginpage.dart';
import 'pages/registerpage.dart';
import 'pages/user_settings_page.dart';
import 'pages/courses.dart';
import 'pages/lessons.dart';

import 'services/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService().init();

  final themeProvider = ThemeProvider();
  await themeProvider.init();

  final languageProvider = LanguageProvider();
  await languageProvider.init();

  runApp(
    AmbaLearn(themeProvider: themeProvider, languageProvider: languageProvider),
  );
}

class AmbaLearn extends StatelessWidget {
  final ThemeProvider themeProvider;
  final LanguageProvider languageProvider;
  final AuthProvider? authProvider;
  final UserProvider? userProvider;
  final ChatProvider? chatProvider;
  final CourseProvider? courseProvider;
  final ExamProvider? examProvider;

  const AmbaLearn({
    super.key,
    required this.themeProvider,
    required this.languageProvider,
    this.authProvider,
    this.userProvider,
    this.chatProvider,
    this.courseProvider,
    this.examProvider,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
        ChangeNotifierProvider.value(value: languageProvider),

        ChangeNotifierProvider(create: (_) => authProvider ?? AuthProvider()),
        ChangeNotifierProvider(create: (_) => userProvider ?? UserProvider()),
        ChangeNotifierProvider(create: (_) => chatProvider ?? ChatProvider()),
        ChangeNotifierProvider(
          create: (_) => courseProvider ?? CourseProvider(),
        ),
        ChangeNotifierProvider(create: (_) => examProvider ?? ExamProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "AmbaLearn",

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.materialThemeMode,

            // Localization
            locale: Provider.of<LanguageProvider>(context).locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('id')],

            /// GERBANG APLIKASI
            home: const AppEntry(),

            /// routes
            routes: {
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/user_settings': (context) => const UserSettingPage(),
              '/courses': (context) => const CoursesPage(),
              '/lessons': (context) => const LessonsPage(),
            },
          );
        },
      ),
    );
  }
}
