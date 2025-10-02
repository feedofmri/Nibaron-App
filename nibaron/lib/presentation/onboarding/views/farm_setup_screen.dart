import 'package:flutter/material.dart';
import '../../../config/constants/string_constants.dart';

class FarmSetupScreen extends StatelessWidget {
  const FarmSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.farmSetup),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              StringConstants.setupYourFarm,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: StringConstants.cropType,
              ),
              items: [
                DropdownMenuItem(value: 'rice', child: Text(StringConstants.rice)),
                DropdownMenuItem(value: 'wheat', child: Text(StringConstants.wheat)),
                DropdownMenuItem(value: 'corn', child: Text(StringConstants.corn)),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: StringConstants.landSize,
                hintText: '5 একর',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: StringConstants.soilType,
              ),
              items: [
                DropdownMenuItem(value: 'clay', child: Text(StringConstants.clay)),
                DropdownMenuItem(value: 'loam', child: Text(StringConstants.loam)),
                DropdownMenuItem(value: 'sandy', child: Text(StringConstants.sandy)),
              ],
              onChanged: (value) {},
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text(StringConstants.save),
            ),
          ],
        ),
      ),
    );
  }
}
