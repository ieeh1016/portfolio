import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'screens/home_screen.dart';
import 'widgets/loading_screen.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightText = GoogleFonts.notoSansKrTextTheme(AppTheme.lightTheme.textTheme);
    return MaterialApp(
      title: '현영우 Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: lightText.copyWith(
          headlineLarge: GoogleFonts.syne(textStyle: lightText.headlineLarge),
          headlineMedium: GoogleFonts.syne(textStyle: lightText.headlineMedium),
        ),
      ),
      themeMode: ThemeMode.light,
      home: const LoadingScreen(child: HomeScreen()),
    );
  }
}
