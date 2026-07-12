import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _apiKey = "GEMINI_API_KEY";

  Future<void> saveApiKey(String token) async {
    await _storage.write(key: _apiKey, value: token);
  }

  Future<String?> getApiKey() async {
    return await _storage.read(key: _apiKey);
  }

  Future<void> deleteApiKey() async {
    await _storage.delete(key: _apiKey);
  }
}