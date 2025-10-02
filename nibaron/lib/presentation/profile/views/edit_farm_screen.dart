import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditFarmScreen extends ConsumerWidget {
  const EditFarmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editFarm),
        actions: [
          TextButton(
            onPressed: () {
              // Save farm changes
              Navigator.pop(context);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: l10n.cropType,
              ),
              items: [
                DropdownMenuItem(value: 'rice', child: Text(l10n.rice)),
                DropdownMenuItem(value: 'wheat', child: Text(l10n.wheat)),
                DropdownMenuItem(value: 'corn', child: Text(l10n.corn)),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: l10n.landSize,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: l10n.soilType,
              ),
              items: [
                DropdownMenuItem(value: 'clay', child: Text(l10n.clay)),
                DropdownMenuItem(value: 'loam', child: Text(l10n.loam)),
                DropdownMenuItem(value: 'sandy', child: Text(l10n.sandy)),
              ],
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
