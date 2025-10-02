import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingSlide {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;
  final String illustration;

  OnboardingSlide({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.illustration,
  });
}

class Language {
  final String code;
  final String name;
  final String nativeName;
  final String flag;

  Language({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
  });
}

class OnboardingService {
  static const String _firstLaunchKey = 'is_first_launch';
  static const String _languageSelectedKey = 'is_language_selected';
  static const String _onboardingCompleteKey = 'onboarding_complete';

  static List<Language> getSupportedLanguages() {
    return [
      Language(
        code: 'en',
        name: 'English',
        nativeName: 'English',
        flag: '🇺🇸',
      ),
      Language(
        code: 'bn',
        name: 'Bengali',
        nativeName: 'বাংলা',
        flag: '🇧🇩',
      ),
    ];
  }

  /// Check if this is the first launch of the app
  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstLaunchKey) ?? true;
  }

  /// Check if language has been selected
  static Future<bool> isLanguageSelected() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_languageSelectedKey) ?? false;
  }

  /// Check if onboarding is complete
  static Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompleteKey) ?? false;
  }

  /// Mark first launch as complete
  static Future<void> setFirstLaunchComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, false);
  }

  /// Mark language as selected
  static Future<void> setLanguageSelected() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_languageSelectedKey, true);
  }

  /// Mark onboarding as complete
  static Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, true);
  }

  /// Reset all onboarding preferences
  static Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, true);
    await prefs.setBool(_languageSelectedKey, false);
    await prefs.setBool(_onboardingCompleteKey, false);
  }
}
