import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notifications),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: Text(l10n.markAllAsRead),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // Demo notifications
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  index == 0 ? Icons.warning : Icons.info,
                  color: Colors.white,
                ),
              ),
              title: Text(
                index == 0 ? l10n.weatherWarning : l10n.irrigationTime,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                index == 0
                    ? l10n.heavyRainExpected
                    : l10n.irrigationReminder,
              ),
              trailing: Text(
                index == 0 ? '10 ${l10n.minutesAgo}' : '2 ${l10n.hoursAgo}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/notification-detail',
                  arguments: {'notificationId': 'notif_$index'},
                );
              },
            ),
          );
        },
      ),
    );
  }
}
