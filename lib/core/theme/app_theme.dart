import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF000F22), // Deep Navy
        onPrimary: Colors.white,
        primaryContainer: Color(0xFF0A2540),
        onPrimaryContainer: Colors.white,
        secondary: Color(0xFF006B5C), // Emerald Green
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFE0F2F1),
        onSecondaryContainer: Color(0xFF006B5C),
        tertiary: Color(0xFF44DDC2), // Teal / Secondary Fixed Dim
        onTertiary: Color(0xFF191C1E),
        error: Color(0xFFBA1A1A),
        onError: Colors.white,
        surface: Color(0xFFF7F9FC),
        onSurface: Color(0xFF191C1E), // On Surface
        surfaceContainerLow: Color(0xFFF2F4F7), // Layer 1
        surfaceContainerLowest: Color(0xFFFFFFFF), // Layer 2 Focus
        outlineVariant: Color(0xFFC4C6CE),
      ),
      scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: -1.0,
        ),
        displayMedium: baseTextTheme.displayMedium?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        displaySmall: baseTextTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontSize: 28),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          fontSize: 14,
          height: 1.5,
        ),
        labelMedium: baseTextTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
          letterSpacing: 0.7, // ~5%
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF000F22),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24), // xl (1.5rem / 24px)
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          elevation: 0,
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFFFFFFFF),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // lg (1rem / 16px)
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0x33C4C6CE),
          ), // outline variant @ 20%
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0x33C4C6CE)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF006B5C),
            width: 2,
          ), // Focus transition to secondary
        ),
      ),
    );
  }
}
