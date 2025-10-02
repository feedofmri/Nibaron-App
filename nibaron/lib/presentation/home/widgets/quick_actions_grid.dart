import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/routes/app_routes.dart';
import 'quick_action_button.dart';

class QuickActionsGrid extends ConsumerWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        QuickActionButton(
          icon: Icons.wb_sunny,
          title: l10n.weather,
          onTap: () => Navigator.pushNamed(context, AppRoutes.weather),
        ),
        QuickActionButton(
          icon: Icons.calendar_today,
          title: l10n.calendar,
          onTap: () => Navigator.pushNamed(context, AppRoutes.calendar),
        ),
        QuickActionButton(
          icon: Icons.support_agent,
          title: l10n.support,
          onTap: () => Navigator.pushNamed(context, AppRoutes.support),
        ),
        QuickActionButton(
          icon: Icons.history,
          title: l10n.actionLog,
          onTap: () => Navigator.pushNamed(context, AppRoutes.actionLog),
        ),
      ],
    );
  }
}
