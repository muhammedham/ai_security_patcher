import 'package:flutter/material.dart';
import 'package:ai_security_patcher/core/services/gemini_service.dart';

class PatcherViewModel extends ChangeNotifier {
  final GeminiService _geminiService;

  bool _isAnalyzing = false;
  String? _report;
  String? _error;

  PatcherViewModel(this._geminiService);

 
  bool get isAnalyzing => _isAnalyzing;
  String? get report => _report;
  String? get error => _error;

 
  // إرسال المحتوى للفحص
  Future<bool> analyzeContent(String content) async {
    if (content.trim().isEmpty) {
      _error = "Please paste some code or security logs first.";
      notifyListeners();
      return false;
    }

    _isAnalyzing = true;
    _error = null;
    _report = null;
    notifyListeners();

    try {
      final result = await _geminiService.analyzeVulnerabilities(content);
      _isAnalyzing = false;
      
      // إذا جوجل رجعت خطأ، رح نعرضه للمستخدم فوراً
      if (result.startsWith("Error")) {
        _error = result; 
        notifyListeners();
        return false;
      }
      
      _report = result;
      notifyListeners();
      return true;
    } catch (e) {
      _error = "Analysis failed: ${e.toString()}";
      _isAnalyzing = false;
      notifyListeners();
      return false;
    }
  }

  
  void clearReport() {
    _report = null;
    _error = null;
    notifyListeners();
  }
}