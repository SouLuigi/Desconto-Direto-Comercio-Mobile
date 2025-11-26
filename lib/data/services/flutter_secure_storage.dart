import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService {
  final _storage = const FlutterSecureStorage();
  final _tokenKey = 'token';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return '2';
    // return await _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
