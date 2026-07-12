import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  GenerativeModel? _model;

  void initModel(String apiKey) {
    _model = GenerativeModel(
      model: 'gemini-3.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system('''
You are an expert Senior DevSecOps and Application Security Engineer.
Analyze the provided code or security report and output a structured report containing:
1. Executive Summary.
2. Detected Vulnerabilities (with criticality level).
3. Patching Workflow (step-by-step).
4. Secure Code Snippet.
Use Markdown for formatting.
'''),
    );
  }

  Future<String> analyzeVulnerabilities(String content) async {
    if (_model == null) return "Model not initialized.";
    try {
      final response = await _model!.generateContent([Content.text(content)]);
      return response.text ?? "No analysis generated.";
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}