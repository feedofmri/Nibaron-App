import 'package:flutter/material.dart';
import '../../../config/constants/string_constants.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.editProfile),
        actions: [
          TextButton(
            onPressed: () {
              // Save profile changes
              Navigator.pop(context);
            },
            child: Text(StringConstants.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'নাম',
                hintText: 'আপনার নাম লিখুন',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'ইমেইল (ঐচ্ছিক)',
                hintText: 'example@email.com',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'ঠিকানা',
                hintText: 'আপনার সম্পূর্ণ ঠিকানা',
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
