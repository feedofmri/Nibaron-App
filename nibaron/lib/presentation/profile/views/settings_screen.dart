import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../data/providers/theme_provider.dart';
import '../../../data/providers/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Settings
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n.language),
              subtitle: Text(locale.languageCode == 'bn' ? l10n.bengali : l10n.english),
              trailing: Switch(
                value: locale.languageCode == 'en',
                onChanged: (value) {
                  ref.read(localeProvider.notifier).setLocale(
                    value ? const Locale('en', 'US') : const Locale('bn', 'BD'),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Theme Settings
          Card(
            child: ListTile(
              leading: const Icon(Icons.palette),
              title: Text(l10n.theme),
              subtitle: Text(_getThemeName(themeMode, l10n)),
              onTap: () => _showThemeDialog(context, ref, themeMode),
            ),
          ),

          const SizedBox(height: 8),

          // Notification Settings
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: Text(l10n.notifications),
              subtitle: Text(l10n.pushNotifications),
              trailing: Switch(
                value: true, // Default enabled
                onChanged: (value) {
                  // Handle notification toggle
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Weather Alerts
          Card(
            child: ListTile(
              leading: const Icon(Icons.wb_cloudy),
              title: Text(l10n.weatherAlerts),
              trailing: Switch(
                value: true, // Default enabled
                onChanged: (value) {
                  // Handle weather alerts toggle
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Task Reminders
          Card(
            child: ListTile(
              leading: const Icon(Icons.task),
              title: Text(l10n.farmingReminders),
              trailing: Switch(
                value: true, // Default enabled
                onChanged: (value) {
                  // Handle task reminders toggle
                },
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Privacy
          Card(
            child: ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: Text(l10n.privacy),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to privacy screen
              },
            ),
          ),

          const SizedBox(height: 8),

          // Help & Feedback
          Card(
            child: ListTile(
              leading: const Icon(Icons.help),
              title: Text(l10n.helpCenter),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to help screen
              },
            ),
          ),

          const SizedBox(height: 8),

          // Version Info
          Card(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: Text(l10n.version),
              subtitle: const Text('v1.0.0'),
            ),
          ),
        ],
      ),
    );
  }

  String _getThemeName(ThemeMode themeMode, AppLocalizations l10n) {
    switch (themeMode) {
      case ThemeMode.light:
        return l10n.lightMode;
      case ThemeMode.dark:
        return l10n.darkMode;
      case ThemeMode.system:
        return l10n.systemMode;
    }
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref, ThemeMode currentTheme) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.selectTheme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: Text(l10n.lightMode),
              value: ThemeMode.light,
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeModeProvider.notifier).setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(l10n.darkMode),
              value: ThemeMode.dark,
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeModeProvider.notifier).setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(l10n.systemMode),
              value: ThemeMode.system,
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeModeProvider.notifier).setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
