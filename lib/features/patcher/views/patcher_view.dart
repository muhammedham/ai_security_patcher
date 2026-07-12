import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ai_security_patcher/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:ai_security_patcher/features/patcher/viewmodel/patcher_viewmodel.dart';
import 'package:ai_security_patcher/features/patcher/views/report_view.dart';

class PatcherView extends StatefulWidget {
  const PatcherView({super.key});

  @override
  State<PatcherView> createState() => _PatcherViewState();
}

class _PatcherViewState extends State<PatcherView> {
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.read<AuthViewModel>();
    final patcherViewModel = context.watch<PatcherViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          'SECURITY WORKBENCH',
          style: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Logout',
            onPressed: () => authViewModel.logout(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Vulnerability Log / Source Code Auditor",
              style: GoogleFonts.orbitron(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            
          
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: GoogleFonts.jetBrainsMono(color: Colors.greenAccent, fontSize: 13),
                decoration: InputDecoration(
                  hintText: "Paste your raw source code or container vulnerability logs here (e.g., Trivy, OWASP output)...",
                  hintStyle: GoogleFonts.roboto(color: Colors.grey[600], fontSize: 13),
                  filled: true,
                  fillColor: const Color(0xFF1E1E1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.cyanAccent, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            if (patcherViewModel.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  patcherViewModel.error!,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),

           
            ElevatedButton(
              onPressed: patcherViewModel.isAnalyzing
                  ? null
                  : () async {
                      final success = await patcherViewModel.analyzeContent(_contentController.text);
                      if (success && mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportView(reportData: patcherViewModel.report!),
                          ),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: patcherViewModel.isAnalyzing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                    )
                  : Text(
                      "EXECUTE SECURITY ANALYSIS",
                      style: GoogleFonts.orbitron(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}