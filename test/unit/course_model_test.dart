import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_layout/models/course_model.dart';

void main() {
  group('CourseModel -', () {
    test('fromJson should parse correctly', () {
      final json = {
        'uid': 'c1',
        'course_title': 'Flutter Basics',
        'description': 'Learn Flutter',
        'difficulty': 'Beginner',
        'steps': [
          {'step_number': 1, 'title': 'Introduction'},
          {'step_number': 2, 'title': 'Widgets'},
        ],
      };

      final course = Course.fromJson(json);

      expect(course.uid, 'c1');
      expect(course.courseTitle, 'Flutter Basics');
      expect(course.description, 'Learn Flutter');
      expect(course.difficulty, 'Beginner');
      expect(course.steps.length, 2);
      expect(course.steps[0].stepNumber, 1);
      expect(course.steps[0].title, 'Introduction');
    });

    test('fromJson should handle missing optional fields', () {
      final json = <String, dynamic>{};

      final course = Course.fromJson(json);

      expect(course.uid, '');
      expect(course.courseTitle, 'Untitled');
      expect(course.description, '');
      expect(course.difficulty, '');
      expect(course.steps, isEmpty);
    });

    test('ChatMessage.fromJson should parse correctly', () {
      final json = {'role': 'user', 'content': 'Hello'};
      final msg = ChatMessage.fromJson(json);

      expect(msg.content, 'Hello');
      expect(msg.isUser, true);
    });

    test('ChatMessage.fromJson should parse assistant role correctly', () {
      final json = {'role': 'assistant', 'content': 'Hi there'};
      final msg = ChatMessage.fromJson(json);

      expect(msg.content, 'Hi there');
      expect(msg.isUser, false);
    });
  });
}
