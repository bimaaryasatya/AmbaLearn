import 'package:flutter_test/flutter_test.dart';
import 'package:capstone_layout/utils/validators.dart';

void main() {
  group('Validators -', () {
    group('Email Validation', () {
      test('should return error if email is empty', () {
        expect(Validators.validateEmail(''), 'Email is required');
        expect(Validators.validateEmail(null), 'Email is required');
      });

      test('should return error if email is invalid', () {
        expect(
          Validators.validateEmail('not-an-email'),
          'Enter a valid email address',
        );
        expect(
          Validators.validateEmail('test@'),
          'Enter a valid email address',
        );
        expect(
          Validators.validateEmail('@test.com'),
          'Enter a valid email address',
        );
      });

      test('should return null if email is valid', () {
        expect(Validators.validateEmail('test@example.com'), null);
        expect(Validators.validateEmail('user.name@domain.co.id'), null);
      });
    });

    group('Password Validation', () {
      test('should return error if password is empty', () {
        expect(Validators.validatePassword(''), 'Password is required');
        expect(Validators.validatePassword(null), 'Password is required');
      });

      test('should return error if password is too short', () {
        expect(
          Validators.validatePassword('12345'),
          'Password must be at least 6 characters',
        );
      });

      test('should return null if password is valid', () {
        expect(Validators.validatePassword('123456'), null);
        expect(Validators.validatePassword('password123'), null);
      });
    });
  });
}
