import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportView extends StatelessWidget {
  final String reportData;

  const ReportView({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          'SECURITY AUDIT REPORT',
          style: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.cyanAccent),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[800]!, width: 1),
          ),
          child: Markdown(
            data: reportData,
            selectable: true,
            styleSheet: MarkdownStyleSheet(
              h1: GoogleFonts.orbitron(color: Colors.cyanAccent, fontSize: 20, fontWeight: FontWeight.bold),
              h2: GoogleFonts.orbitron(color: Colors.cyanAccent, fontSize: 16, fontWeight: FontWeight.bold),
              h3: GoogleFonts.roboto(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              p: GoogleFonts.roboto(color: Colors.grey[300], fontSize: 14, height: 1.5),
              code: GoogleFonts.jetBrainsMono(
                backgroundColor: const Color(0xFF2D2D2D),
                color: Colors.greenAccent,
                fontSize: 12,
              ),
              codeblockDecoration: BoxDecoration(
                color: const Color(0xFF151515),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[900]!),
              ),
            ),
          ),
        ),
      ),
    );
  }
}