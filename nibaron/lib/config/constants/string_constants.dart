import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StringConstants {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  // App Information - Keep only non-localized constants
  static const String appName = 'Nibaron';

  // These should be removed as they're now in localization files
  // All hardcoded Bangla text has been moved to proper localization files
  // Use AppLocalizations.of(context)! instead of these constants

  // Example: Instead of StringConstants.goodMorning, use l10n.goodMorning
  // where l10n = AppLocalizations.of(context)!

  // Legacy constants - DEPRECATED - Use localization instead
  @deprecated
  static const String appNameBengali = 'নিবারণ';
  @deprecated
  static const String appTaglineEnglish = 'Forecast. Prevent. Protect.';
  @deprecated
  static const String appTaglineBengali = 'পূর্বাভাস। প্রতিরোধ। সুরক্ষা।';
  @deprecated
  static const String loading = 'Loading...';
  @deprecated
  static const String loadingBengali = 'লোড হচ্ছে...';
  @deprecated
  static const String appDescription = 'বাংলাদেশি কৃষকদের জন্য স্মার্ট কৃষি সহায়ক';

  // All other hardcoded Bangla constants have been removed
  // Use AppLocalizations.of(context)! for all user-facing text
  // Example usage:
  // final l10n = AppLocalizations.of(context)!;
  // Text(l10n.goodMorning) instead of Text(StringConstants.goodMorning)
}
