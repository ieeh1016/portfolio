import 'package:flutter/material.dart';

/// Toss 스타일: 화려하고 모던한 UI/GUI
class AppTheme {
  // Light Theme 색상
  static const Color primary = Color(0xFF3182F6);
  static const Color primaryLight = Color(0xFFE8F0FE);
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color accent = Color(0xFF00D9FF);
  
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  
  static const Color textPrimary = Color(0xFF191F28);
  static const Color textSecondary = Color(0xFF6B7684);
  static const Color textTertiary = Color(0xFFB0B8C1);
  
  // Dark Theme 색상
  static const Color darkBackground = Color(0xFF0F1419);
  static const Color darkSurface = Color(0xFF1A1F2E);
  static const Color darkSurfaceElevated = Color(0xFF252B3D);
  
  static const Color darkTextPrimary = Color(0xFFE4E7EB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkTextTertiary = Color(0xFF6B7280);
  
  // 그라데이션
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3182F6), Color(0xFF8B5CF6)],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00D9FF), Color(0xFF3182F6)],
  );
  
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE8F0FE),
      Color(0xFFF0E8FE),
      Color(0xFFFEF0E8),
    ],
  );
  
  static const LinearGradient darkHeroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E293B),
      Color(0xFF2D1B3D),
      Color(0xFF3D2B1B),
    ],
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        surface: surface,
        background: background,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: textPrimary,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: primaryLight,
        selectedColor: primary,
        labelStyle: const TextStyle(
          color: primary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: textPrimary,
          fontSize: 36,
          fontWeight: FontWeight.bold,
          height: 1.2,
          letterSpacing: -1,
        ),
        headlineMedium: TextStyle(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          color: textPrimary,
          fontSize: 16,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 15,
          height: 1.6,
        ),
        bodySmall: TextStyle(
          color: textTertiary,
          fontSize: 14,
          height: 1.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        surface: darkSurface,
        background: darkBackground,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: darkTextPrimary,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: darkSurface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: darkSurfaceElevated,
        selectedColor: primary,
        labelStyle: const TextStyle(
          color: darkTextPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: darkTextPrimary,
          fontSize: 36,
          fontWeight: FontWeight.bold,
          height: 1.2,
          letterSpacing: -1,
        ),
        headlineMedium: TextStyle(
          color: darkTextPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          color: darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
        titleMedium: TextStyle(
          color: darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          color: darkTextPrimary,
          fontSize: 16,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          color: darkTextSecondary,
          fontSize: 15,
          height: 1.6,
        ),
        bodySmall: TextStyle(
          color: darkTextTertiary,
          fontSize: 14,
          height: 1.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
  
  // 그림자
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
  
  static List<BoxShadow> get cardShadowHover => [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 30,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];
  
  static List<BoxShadow> get darkCardShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
}
