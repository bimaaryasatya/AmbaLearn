import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/homepage.dart';
import 'pages/courses.dart';
import 'pages/lessons.dart';
import 'pages/loginpage.dart';
import 'pages/registerpage.dart';
import 'pages/user_settings_page.dart';
import 'providers/auth_provider.dart';

void main() {
  runApp(const AmbaLearn());
}

class AmbaLearn extends StatelessWidget {
  const AmbaLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "AmbaLearn",
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const Homepage(),
          '/user_settings': (context) => const UserSettingPage(),
          '/courses': (context) => const CoursesPage(),
          '/lessons': (context) => const LessonsPage(),
        },
      ),
    );
  }
}
