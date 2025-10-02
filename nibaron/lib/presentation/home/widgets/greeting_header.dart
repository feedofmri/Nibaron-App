import 'package:flutter/material.dart';
import '../../../config/constants/string_constants.dart';
import '../../../config/theme/text_styles.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;

    String greeting;
    if (hour < 12) {
      greeting = StringConstants.goodMorning;
    } else if (hour < 17) {
      greeting = StringConstants.goodAfternoon;
    } else if (hour < 21) {
      greeting = StringConstants.goodEvening;
    } else {
      greeting = StringConstants.goodNight;
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
              'কৃষক', // Default name - would come from user data
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
