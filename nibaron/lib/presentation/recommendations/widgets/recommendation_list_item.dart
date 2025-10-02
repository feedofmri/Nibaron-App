import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../data/models/recommendation/recommendation_model.dart';
import '../../../config/theme/text_styles.dart';

class RecommendationListItem extends ConsumerStatefulWidget {
  final RecommendationModel recommendation;
  final VoidCallback onCompleted;
  final Function(int rating, String? feedback) onRate;

  const RecommendationListItem({
    super.key,
    required this.recommendation,
    required this.onCompleted,
    required this.onRate,
  });

  @override
  ConsumerState<RecommendationListItem> createState() => _RecommendationListItemState();
}

class _RecommendationListItemState extends ConsumerState<RecommendationListItem>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with priority and category
            Row(
              children: [
                _buildCategoryIcon(),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.recommendation.title,
                        style: TextStyles.headline3.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildPriorityChip(),
                          const SizedBox(width: 8),
                          _buildCategoryChip(context, l10n),
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.recommendation.isCompleted)
                  Icon(
                    Icons.check_circle,
                    color: Colors.green[600],
                    size: 24,
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              widget.recommendation.description,
              style: TextStyles.bodyMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
            ),

            const SizedBox(height: 12),

            // Action buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Audio button
                if (widget.recommendation.audioUrl != null)
                  IconButton(
                    onPressed: _toggleAudio,
                    icon: Icon(
                      _isPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    tooltip: l10n.listen,
                  ),

                const Spacer(),

                // Complete button
                if (!widget.recommendation.isCompleted) ...[
                  ElevatedButton.icon(
                    onPressed: () {
                      _animationController.forward();
                      widget.onCompleted();
                    },
                    icon: const Icon(Icons.check, size: 16),
                    label: Text(l10n.markAsDone),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon() {
    IconData icon;
    Color color;

    switch (widget.recommendation.category) {
      case 'irrigation':
        icon = Icons.water_drop;
        color = Colors.blue[600]!;
        break;
      case 'fertilizer':
        icon = Icons.scatter_plot;
        color = Colors.green[600]!;
        break;
      case 'pestControl':
        icon = Icons.bug_report;
        color = Colors.red[600]!;
        break;
      case 'harvest':
        icon = Icons.agriculture;
        color = Colors.orange[600]!;
        break;
      case 'planting':
        icon = Icons.eco;
        color = Colors.teal[600]!;
        break;
      default:
        icon = Icons.info;
        color = Colors.grey[600]!;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildPriorityChip() {
    final l10n = AppLocalizations.of(context)!;
    String label;
    Color color;

    switch (widget.recommendation.priority) {
      case 'critical':
        label = l10n.critical;
        color = Colors.red[600]!;
        break;
      case 'high':
        label = l10n.high;
        color = Colors.orange[600]!;
        break;
      case 'medium':
        label = l10n.medium;
        color = Colors.blue[600]!;
        break;
      case 'low':
        label = l10n.low;
        color = Colors.green[600]!;
        break;
      default:
        label = l10n.general;
        color = Colors.grey[600]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyles.bodySmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, AppLocalizations l10n) {
    String label;

    switch (widget.recommendation.category) {
      case 'irrigation':
        label = l10n.irrigation;
        break;
      case 'fertilizer':
        label = l10n.fertilizer;
        break;
      case 'pestControl':
        label = l10n.pesticide;
        break;
      case 'harvest':
        label = l10n.harvestTime;
        break;
      case 'planting':
        label = l10n.planting;
        break;
      default:
        label = 'General';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyles.bodySmall.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        ),
      ),
    );
  }

  Future<void> _toggleAudio() async {
    if (widget.recommendation.audioUrl == null) return;

    try {
      if (_isPlaying) {
        await _audioPlayer.stop();
        setState(() => _isPlaying = false);
      } else {
        // In a real app, you would play from the actual audio URL
        // For now, we'll just simulate the playing state
        setState(() => _isPlaying = true);

        // Simulate audio duration
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() => _isPlaying = false);
          }
        });
      }
    } catch (e) {
      setState(() => _isPlaying = false);
    }
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) => RatingDialog(
        onSubmit: (rating, feedback) {
          widget.onRate(rating, feedback);
        },
      ),
    );
  }
}

class RatingDialog extends StatefulWidget {
  final Function(int rating, String? feedback) onSubmit;

  const RatingDialog({super.key, required this.onSubmit});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(l10n.rateRecommendation),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.howEffectiveWasThis),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => setState(() => _rating = index + 1),
                child: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber[600],
                  size: 32,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _feedbackController,
            decoration: InputDecoration(
              labelText: l10n.feedbackOptional,
              hintText: l10n.shareYourExperience,
              border: const OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _rating > 0
              ? () {
                  widget.onSubmit(_rating, _feedbackController.text.trim().isEmpty
                      ? null : _feedbackController.text.trim());
                  Navigator.of(context).pop();
                }
              : null,
          child: Text(l10n.submit),
        ),
      ],
    );
  }
}
