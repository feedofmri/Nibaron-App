import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  // Base text styles for Bengali (Noto Sans Bengali)
  static TextStyle get baseBengaliStyle => GoogleFonts.notoSansBengali();

  // Base text styles for English (Inter)
  static TextStyle get baseEnglishStyle => GoogleFonts.inter();

  // Headlines
  static TextStyle get headline1 => baseBengaliStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static TextStyle get headline2 => baseBengaliStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static TextStyle get headline3 => baseBengaliStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // Body text
  static TextStyle get bodyLarge => baseBengaliStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get bodyMedium => baseBengaliStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get bodySmall => baseBengaliStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );

  // Captions and labels
  static TextStyle get caption => baseBengaliStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.3,
  );

  static TextStyle get label => baseBengaliStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  // Button text
  static TextStyle get buttonLarge => baseBengaliStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static TextStyle get buttonMedium => baseBengaliStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  // English variants (for mixed content)
  static TextStyle get englishBodyMedium => baseEnglishStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get englishCaption => baseEnglishStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.3,
  );

  // Specialized styles
  static TextStyle get weatherTemperature => baseBengaliStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.1,
  );

  static TextStyle get cardTitle => baseBengaliStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static TextStyle get greeting => baseBengaliStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // Legacy getters for backward compatibility
  static TextStyle get body1 => bodyMedium;
  static TextStyle get body2 => bodySmall;
  static TextStyle get subtitle1 => cardTitle;
  static TextStyle get subtitle2 => label;
}
