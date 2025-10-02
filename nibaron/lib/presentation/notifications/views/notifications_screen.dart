import 'package:flutter/material.dart';
import '../../../config/constants/string_constants.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.notifications),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: const Text('সব পড়া হয়েছে'),
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
                index == 0 ? 'আবহাওয়া সতর্কতা' : 'সেচের সময়',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                index == 0
                    ? 'আগামীকাল ভারী বৃষ্টির সম্ভাবনা'
                    : 'আজ সন্ধ্যায় সেচ দেওয়ার সময়',
              ),
              trailing: Text(
                index == 0 ? '১০ মিনিট' : '২ ঘন্টা',
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
