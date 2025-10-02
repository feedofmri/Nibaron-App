import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/constants/string_constants.dart';
import '../../../data/providers/theme_provider.dart';
import '../../../data/providers/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language Settings
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: Text(StringConstants.language),
              subtitle: Text(locale.languageCode == 'bn' ? StringConstants.bangla : StringConstants.english),
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
              title: Text(StringConstants.theme),
              subtitle: Text(_getThemeName(themeMode)),
              onTap: () => _showThemeDialog(context, ref, themeMode),
            ),
          ),

          const SizedBox(height: 8),

          // Notification Settings
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: Text(StringConstants.notifications),
              subtitle: Text(StringConstants.enableNotifications),
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
              title: Text(StringConstants.weatherAlerts),
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
              title: Text(StringConstants.taskReminders),
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
              title: Text(StringConstants.privacy),
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
              title: Text(StringConstants.helpAndFeedback),
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
              title: Text(StringConstants.version),
              subtitle: const Text('v1.0.0'),
            ),
          ),
        ],
      ),
    );
  }

  String _getThemeName(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return StringConstants.lightTheme;
      case ThemeMode.dark:
        return StringConstants.darkTheme;
      case ThemeMode.system:
        return StringConstants.systemTheme;
    }
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref, ThemeMode currentTheme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(StringConstants.theme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: Text(StringConstants.lightTheme),
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
              title: Text(StringConstants.darkTheme),
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
              title: Text(StringConstants.systemTheme),
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
