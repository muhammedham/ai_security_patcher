import 'package:flutter/material.dart';
import 'package:ai_security_patcher/core/services/secure_storage_service.dart';
import 'package:ai_security_patcher/core/services/gemini_service.dart';

class AuthViewModel extends ChangeNotifier {
  final SecureStorageService _storageService = SecureStorageService();
  final GeminiService _geminiService;

  bool _isLoading = false;
  String? _errorMessage;
  bool _isAuthenticated = false;

  AuthViewModel(this._geminiService) {
    checkExistingKey();
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> checkExistingKey() async {
    _setLoading(true);
    final savedKey = await _storageService.getApiKey();
    if (savedKey != null && savedKey.isNotEmpty) {
      _geminiService.initModel(savedKey);
      _isAuthenticated = true;
    }
    _setLoading(false);
  }

  Future<bool> saveAndInitKey(String apiKey) async {
    if (apiKey.trim().isEmpty) {
      _errorMessage = "Please enter an API key first.";
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    try {
      await _storageService.saveApiKey(apiKey.trim());
      _geminiService.initModel(apiKey.trim());
      _isAuthenticated = true;
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = "Failed to save key: ${e.toString()}";
      _setLoading(false);
      return false;
    }
  }

  Future<void> logout() async {
    await _storageService.deleteApiKey();
    _isAuthenticated = false;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}