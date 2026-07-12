// Force GitHub Language Update
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ai_security_patcher/core/services/gemini_service.dart';
import 'package:ai_security_patcher/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:ai_security_patcher/features/auth/views/auth_view.dart';
import 'package:ai_security_patcher/features/patcher/viewmodel/patcher_viewmodel.dart';
import 'package:ai_security_patcher/features/patcher/views/patcher_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final geminiService = GeminiService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(geminiService),
        ),
        ChangeNotifierProvider(
          create: (_) => PatcherViewModel(geminiService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Security Patcher',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      home: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          if (authViewModel.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Colors.cyanAccent),
              ),
            );
          }

          if (authViewModel.isAuthenticated) {
            return const PatcherView(); 
          }

          return const AuthView();
        },
      ),
    );
  }
}