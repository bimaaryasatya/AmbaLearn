import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_layout/widgets/app_drawer.dart';
import 'test_helper.dart';

void main() {
  testWidgets('AppDrawer shows properly', (WidgetTester tester) async {
    // AppDrawer typically needs to be inside a Scaffold to look right,
    // but just checking contents works if wrapped in Material
    await tester.pumpWidget(
      createWidgetUnderTests(
        child: const Scaffold(drawer: AppDrawer(), body: SizedBox()),
      ),
    );

    // Open the drawer
    final ScaffoldState state = tester.firstState(find.byType(Scaffold));
    state.openDrawer();
    await tester.pumpAndSettle();

    expect(find.text('AmbaLearn'), findsOneWidget);
    expect(find.text('Courses'), findsOneWidget);
    expect(find.text('New Chat'), findsOneWidget);
  });

  testWidgets('AppDrawer lists sessions', (WidgetTester tester) async {
    await tester.pumpWidget(
      createWidgetUnderTests(
        child: const Scaffold(drawer: AppDrawer(), body: SizedBox()),
      ),
    );

    final ScaffoldState state = tester.firstState(find.byType(Scaffold));
    state.openDrawer();
    await tester.pumpAndSettle();

    // MockChatProvider provides one session "Test Chat"
    expect(find.text('Test Chat'), findsOneWidget);
  });
}
