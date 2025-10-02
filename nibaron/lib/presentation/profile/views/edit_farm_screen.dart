import 'package:flutter/material.dart';
import '../../../config/constants/string_constants.dart';

class EditFarmScreen extends StatelessWidget {
  const EditFarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.editFarm),
        actions: [
          TextButton(
            onPressed: () {
              // Save farm changes
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
                hintText: '৫ একর',
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
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: StringConstants.location,
                hintText: 'খামারের অবস্থান',
                suffixIcon: Icon(Icons.location_on),
              ),
              readOnly: true,
              onTap: () {
                // Open location picker
              },
            ),
          ],
        ),
      ),
    );
  }
}
