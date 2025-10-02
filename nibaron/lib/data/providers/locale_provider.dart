import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../core/services/storage_service.dart';
import '../../core/services/onboarding_service.dart';
import '../../core/dependency_injection/service_locator.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en', 'US')) { // Default to English
    _loadLocale();
  }

  final StorageService _storageService = sl<StorageService>();

  Future<void> _loadLocale() async {
    final languageCode = await _storageService.getString('language_code');
    if (languageCode != null) {
      switch (languageCode) {
        case 'bn':
          state = const Locale('bn', 'BD');
          break;
        case 'en':
          state = const Locale('en', 'US');
          break;
        default:
          state = const Locale('en', 'US'); // Default to English
          break;
      }
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await _storageService.setString('language_code', locale.languageCode);

    // Mark language as selected when user chooses a language
    await OnboardingService.setLanguageSelected();

    // Also mark first launch as complete when language is selected
    await OnboardingService.setFirstLaunchComplete();
  }

  bool get isBangla => state.languageCode == 'bn';
  bool get isEnglish => state.languageCode == 'en';
}
