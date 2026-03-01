import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFFF26522); // Vibrant Orange from Figma
  static const Color primaryLight = Color(0xFFF26522);
  static const Color secondary = Color(0xFF2B2B2B); // Darker tone
  static const Color accentSoft = Color(0xFFFDD3B6); // Soft peach background blobs from Figma
  static const Color applyNow = Color(0xFFF16023); // Apply Now accent color from Figma
  
  // Light Theme Colors
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFF8F8F8);
  static const Color textMainLight = Color(0xFF1A1A1A);
  static const Color textGreyLight = Color(0xFF757575);
  static const Color surfaceLight = Color(0xFFF0F0F0);

  // Dark Theme Colors
  static const Color backgroundDark = Color(0xFF0F0F0F);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color textMainDark = Color(0xFFFFFFFF);
  static const Color textGreyDark = Color(0xFFA0A0A0);
  
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // Legacy Aliases to fix compilation errors
  static const Color textMain = textMainLight;
  static const Color textGrey = textGreyLight;
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.backgroundLight,
      onSurface: AppColors.textMainLight,
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardLight,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    textTheme: GoogleFonts.outfitTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.textMainLight, letterSpacing: -1),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textMainLight, letterSpacing: -0.5),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textMainLight),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.textMainLight, height: 1.5),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.textGreyLight, height: 1.4),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // More rounded per Figma
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundLight,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textGreyLight,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.cardDark,
      onSurface: AppColors.textMainDark,
    ),
    // ... rest of dark theme following same pattern
  );
}

