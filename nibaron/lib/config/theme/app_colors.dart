import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFAFAF6);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightPrimary = Color(0xFF68911B);
  static const Color lightAccent = Color(0xFFEAB020);
  static const Color lightTextPrimary = Color(0xFF2A2E34);
  static const Color lightTextSecondary = Color(0xFF6E6E6E);
  static const Color lightBorder = Color(0xFFDCDCDC);
  static const Color lightAlertRed = Color(0xFFF04E23);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF2A2E34);
  static const Color darkSurface = Color(0xFF3A3F47);
  static const Color darkPrimary = Color(0xFF68911B);
  static const Color darkAccent = Color(0xFFEAB020);
  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkBorder = Color(0xFF4A4E55);
  static const Color darkAlertRed = Color(0xFFF04E23);

  // Common Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Static getters for easy access (most commonly used)
  static Color get primary => lightPrimary;
  static Color get secondary => lightAccent;
  static Color get background => lightBackground;
  static Color get surface => lightSurface;
  static Color get textPrimary => lightTextPrimary;
  static Color get textSecondary => lightTextSecondary;
  static Color get border => lightBorder;

  // Gradient Colors
  static const List<Color> lightGradient = [
    Color(0xFFFAFAF6),
    Color(0xFFE8F5E0),
  ];

  static const List<Color> darkGradient = [
    Color(0xFF2A2E34),
    Color(0xFF3A3F47),
  ];

  static const List<Color> primaryGradient = [
    Color(0xFF68911B),
    Color(0xFF7FA525),
  ];

  static const List<Color> accentGradient = [
    Color(0xFFEAB020),
    Color(0xFFF5C842),
  ];
}
