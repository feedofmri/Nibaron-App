import 'package:flutter/material.dart';

class LogDetailScreen extends StatelessWidget {
  final String logId;

  const LogDetailScreen({super.key, required this.logId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Details'),
      ),
      body: Center(
        child: Text('Log Detail Screen - ID: $logId'),
      ),
    );
  }
}
