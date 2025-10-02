import 'package:flutter/material.dart';

class NotificationDetailScreen extends StatelessWidget {
  final String notificationId;

  const NotificationDetailScreen({super.key, required this.notificationId});

  @override
  Widget build(BuildContext context) {
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
              'আবহাওয়া সতর্কতা',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'আগামীকাল ভারী বৃষ্টির সম্ভাবনা রয়েছে। আপনার ফসলের যত্ন নিন এবং প্রয়োজনীয় ব্যবস্থা গ্রহণ করুন।',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'প্রয়োজনীয় পদক্ষেপ:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '• জমিতে জল নিষ্কাশনের ব্যবস্থা করুন\n• ফসল কাটার কাজ এগিয়ে আনুন\n• কীটনাশক স্প্রে করা থেকে বিরত থাকুন',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
