import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lightText = GoogleFonts.notoSansKrTextTheme(AppTheme.lightTheme.textTheme);
    final darkText = GoogleFonts.notoSansKrTextTheme(AppTheme.darkTheme.textTheme);
    return MaterialApp(
      title: '현영우 포트폴리오',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: lightText.copyWith(
          headlineLarge: GoogleFonts.syne(textStyle: lightText.headlineLarge),
          headlineMedium: GoogleFonts.syne(textStyle: lightText.headlineMedium),
        ),
      ),
      darkTheme: AppTheme.darkTheme.copyWith(
        textTheme: darkText.copyWith(
          headlineLarge: GoogleFonts.syne(textStyle: darkText.headlineLarge),
          headlineMedium: GoogleFonts.syne(textStyle: darkText.headlineMedium),
        ),
      ),
      themeMode: _themeMode,
      home: HomeScreen(
        onThemeToggle: _toggleTheme,
      ),
    );
  }
}
