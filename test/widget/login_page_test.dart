import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_layout/pages/loginpage.dart';
import 'test_helper.dart';

void main() {
  testWidgets('LoginPage displays email and password fields', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(createWidgetUnderTests(child: const LoginPage()));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign In'), findsAtLeastNWidgets(1));
  });

  testWidgets('LoginPage navigates to register page when tapped', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(createWidgetUnderTests(child: const LoginPage()));
    await tester.pumpAndSettle();

    final signUpFinder = find.widgetWithText(TextButton, 'Sign Up');

    await tester.ensureVisible(signUpFinder);
    expect(signUpFinder, findsOneWidget);

    await tester.tap(signUpFinder);
    await tester.pumpAndSettle();

    expect(find.text('Create Account'), findsAtLeastNWidgets(1));
  });
}
