import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_layout/models/user_model.dart';

void main() {
  group('UserModel -', () {
    test('fromJson should parse correctly', () {
      final json = {
        'id': '123',
        'username': 'testuser',
        'email': 'test@example.com',
        'picture': 'http://example.com/pic.jpg',
        'birthday': '2000-01-01T00:00:00.000',
        'registered_at': '2023-01-01T00:00:00.000',
        'last_login': '2023-01-02T00:00:00.000',
      };

      final user = User.fromJson(json);

      expect(user.id, '123');
      expect(user.username, 'testuser');
      expect(user.email, 'test@example.com');
      expect(user.picture, 'http://example.com/pic.jpg');
      expect(user.birthday, DateTime(2000, 1, 1));
      expect(user.registeredAt, DateTime(2023, 1, 1));
      expect(user.lastLogin, DateTime(2023, 1, 2));
    });

    test('fromJson should handle null values gracefully', () {
      final json = <String, dynamic>{};

      final user = User.fromJson(json);

      expect(user.id, '');
      expect(user.username, '');
      expect(user.email, '');
      expect(user.picture, '');
      expect(user.birthday, isNull);
      expect(user.registeredAt, isNull);
      expect(user.lastLogin, isNull);
    });
  });
}
