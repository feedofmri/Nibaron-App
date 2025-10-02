import 'package:flutter/material.dart';

class AlertDetailScreen extends StatelessWidget {
  final String alertId;

  const AlertDetailScreen({super.key, required this.alertId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Details'),
      ),
      body: Center(
        child: Text('Alert Detail Screen - ID: $alertId'),
      ),
    );
  }
}
