import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Farmer Name', // Default name
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          '+880 1712345678',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/edit-profile'),
                    child: Text(l10n.edit),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Farm Details Card
          Card(
            child: ListTile(
              leading: const Icon(Icons.agriculture),
              title: Text(l10n.farmDetails),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/edit-farm');
              },
            ),
          ),

          const SizedBox(height: 20),

          // Logout Button
          ElevatedButton(
            onPressed: () {
              // Logout logic
              Navigator.pushReplacementNamed(context, '/registration');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: Text(
              l10n.logout,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
