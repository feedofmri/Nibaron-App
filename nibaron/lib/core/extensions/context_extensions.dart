import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Extension to provide easy access to localized strings throughout the app
extension LocalizedStrings on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
