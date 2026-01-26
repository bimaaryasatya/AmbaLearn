import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_layout/pages/homepage.dart';
import 'test_helper.dart';

void main() {
  testWidgets('HomePage displays AppBar and body', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTests(child: const HomePage()));
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('AmbaLearn'), findsOneWidget); // App Name in title
  });

  testWidgets('HomePage opens drawer', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTests(child: const HomePage()));
    await tester.pumpAndSettle();

    final drawerIcon = find.byIcon(Icons.menu);
    // AppBar creates a menu icon automatically if drawer is present
    expect(drawerIcon, findsOneWidget);

    await tester.tap(drawerIcon);
    await tester.pumpAndSettle();

    expect(find.text('Learn Smarter'), findsOneWidget); // Text inside AppDrawer
  });
}
