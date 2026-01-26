import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_layout/widgets/chat_bubble.dart';
import 'test_helper.dart';

void main() {
  testWidgets('ChatBubble displays user message', (WidgetTester tester) async {
    const message = "Hello World";
    const time = "10:00 AM";

    await tester.pumpWidget(
      createWidgetUnderTests(
        child: const Scaffold(
          body: ChatBubble(message: message, isUser: true, time: time),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(message), findsOneWidget);
    expect(find.text(time), findsOneWidget);
  });

  testWidgets('ChatBubble displays assistant message', (
    WidgetTester tester,
  ) async {
    const message = "Hello User";

    await tester.pumpWidget(
      createWidgetUnderTests(
        child: const Scaffold(
          body: ChatBubble(message: message, isUser: false),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(message), findsOneWidget);
  });
}
