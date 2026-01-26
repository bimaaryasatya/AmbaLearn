import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CookieStorage implements Storage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<void> init(bool persistSession, bool ignoreExpires) async {
    // SecureStorage doesn't require explicit init for our usage
  }

  @override
  Future<String?> read(String key) async {
    // Retrieve value from secure storage
    return await _storage.read(key: key);
  }

  @override
  Future<void> write(String key, String value) async {
    // Write value to secure storage
    await _storage.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) async {
    // Delete value from secure storage
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll(List<String> keys) async {
    // Delete multiple keys
    for (var key in keys) {
      await _storage.delete(key: key);
    }
  }
}
