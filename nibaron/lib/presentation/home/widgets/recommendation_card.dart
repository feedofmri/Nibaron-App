import 'package:flutter/material.dart';
import '../../../data/models/recommendation/recommendation_model.dart';
import '../../../config/constants/string_constants.dart';
import '../../../config/theme/text_styles.dart';
import '../../../config/constants/asset_constants.dart';
import '../../common/widgets/voice_button.dart';

class RecommendationCard extends StatelessWidget {
  final RecommendationModel recommendation;
  final VoidCallback onCompleted;

  const RecommendationCard({
    super.key,
    required this.recommendation,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(recommendation.priority).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCategoryIcon(recommendation.category),
                    color: _getPriorityColor(recommendation.priority),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringConstants.todaysRecommendation,
                        style: TextStyles.caption.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        recommendation.title,
                        style: TextStyles.cardTitle,
                      ),
                    ],
                  ),
                ),
                VoiceButton(
                  text: recommendation.description,
                  size: VoiceButtonSize.small,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              recommendation.description,
              style: TextStyles.bodyMedium.copyWith(
                height: 1.5,
              ),
            ),

            const SizedBox(height: 16),

            // Action buttons
            if (!recommendation.isCompleted) ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onCompleted,
                      icon: const Icon(Icons.check, size: 20),
                      label: Text(StringConstants.completed),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () {
                      // Navigate to task details
                    },
                    child: Text(StringConstants.viewDetails),
                  ),
                ],
              ),
            ] else ...[
              // Completed state
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      StringConstants.completed,
                      style: TextStyles.bodySmall.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'low':
        return Colors.blue;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      case 'critical':
        return Colors.red.shade700;
      default:
        return Colors.orange;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'irrigation':
        return Icons.water_drop;
      case 'fertilizer':
        return Icons.grass;
      case 'pest_control':
        return Icons.bug_report;
      case 'harvest':
        return Icons.agriculture;
      case 'planting':
        return Icons.eco;
      default:
        return Icons.info;
    }
  }
}
