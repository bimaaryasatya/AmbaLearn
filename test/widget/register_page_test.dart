import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_layout/pages/registerpage.dart';
import 'test_helper.dart';

void main() {
  testWidgets('RegisterPage displays all input fields', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      createWidgetUnderTests(child: const RegisterPage()),
    );
    await tester.pumpAndSettle();

    expect(
      find.byType(TextField),
      findsNWidgets(3),
    ); // Username, Email, Password
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Create Account'), findsAtLeastNWidgets(1));
  });
}
