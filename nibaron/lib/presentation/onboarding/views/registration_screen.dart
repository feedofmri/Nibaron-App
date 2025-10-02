import 'package:flutter/material.dart';
import '../../../config/constants/string_constants.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.phoneNumber),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text(
              StringConstants.enterPhoneNumber,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: StringConstants.phoneNumber,
                hintText: '01XXXXXXXXX',
                prefixText: '+880 ',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/otp-verification',
                  arguments: {'phoneNumber': '01712345678'},
                );
              },
              child: Text(StringConstants.next),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
