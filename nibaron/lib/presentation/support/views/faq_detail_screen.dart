import 'package:flutter/material.dart';

class FaqDetailScreen extends StatelessWidget {
  final String faqId;

  const FaqDetailScreen({super.key, required this.faqId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ Details'),
      ),
      body: Center(
        child: Text('FAQ Detail Screen - ID: $faqId'),
      ),
    );
  }
}
