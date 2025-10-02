import 'package:flutter/material.dart';
import '../../../config/constants/string_constants.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.otpVerification),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text(
              StringConstants.enterOtp,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'OTP পাঠানো হয়েছে $phoneNumber নম্বরে',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: 'OTP কোড',
                hintText: '123456',
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/farm-setup');
              },
              child: Text(StringConstants.verify),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Resend OTP logic
              },
              child: Text(StringConstants.resendOtp),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
