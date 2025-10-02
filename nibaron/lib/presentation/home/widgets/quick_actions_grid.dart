import 'package:flutter/material.dart';
import '../../../config/constants/string_constants.dart';
import '../../../config/routes/app_routes.dart';
import 'quick_action_button.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.2,
      children: [
        QuickActionButton(
          icon: Icons.calendar_today_outlined,
          title: StringConstants.calendar,
          onTap: () => Navigator.pushNamed(context, AppRoutes.calendar),
        ),
        QuickActionButton(
          icon: Icons.lightbulb_outline,
          title: StringConstants.recommendations,
          onTap: () => Navigator.pushNamed(context, AppRoutes.recommendations),
        ),
        QuickActionButton(
          icon: Icons.support_agent_outlined,
          title: StringConstants.support,
          onTap: () => Navigator.pushNamed(context, AppRoutes.support),
        ),
        QuickActionButton(
          icon: Icons.history_outlined,
          title: StringConstants.actionLog,
          onTap: () => Navigator.pushNamed(context, AppRoutes.actionLog),
        ),
      ],
    );
  }
}
