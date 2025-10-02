import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme/text_styles.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    final l10n = AppLocalizations.of(context)!;

    String greeting;
    if (hour < 12) {
      greeting = l10n.goodMorning;
    } else if (hour < 17) {
      greeting = l10n.goodAfternoon;
    } else if (hour < 21) {
      greeting = l10n.goodEvening;
    } else {
      greeting = l10n.goodNight;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              greeting,
              style: TextStyles.bodySmall.copyWith(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
            Text(
              l10n.farmer, // Now using localized text instead of hardcoded 'কৃষক'
              style: TextStyles.bodyMedium.copyWith(
                color: Theme.of(context).textTheme.displaySmall?.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
