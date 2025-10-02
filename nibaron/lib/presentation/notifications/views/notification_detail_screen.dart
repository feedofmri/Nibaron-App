import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationDetailScreen extends StatelessWidget {
  final String notificationId;

  const NotificationDetailScreen({super.key, required this.notificationId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.weatherWarning,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.heavyRainExpected,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'Required Steps:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '• Ensure proper drainage in fields\n• Advance crop harvesting if possible\n• Avoid pesticide spraying',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
