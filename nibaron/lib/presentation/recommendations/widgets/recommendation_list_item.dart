import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../data/models/recommendation/recommendation_model.dart';
import '../../../config/constants/string_constants.dart';
import '../../../config/theme/text_styles.dart';

class RecommendationListItem extends StatefulWidget {
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
  State<RecommendationListItem> createState() => _RecommendationListItemState();
}

class _RecommendationListItemState extends State<RecommendationListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (widget.recommendation.isCompleted) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _getPriorityColor().withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with priority and category
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _getPriorityColor().withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
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
                                _buildCategoryChip(),
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
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.recommendation.description,
                        style: TextStyles.bodyMedium.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Date and expiry info
                      Wrap(
                        spacing: 12,
                        runSpacing: 4,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  _formatDate(widget.recommendation.recommendedDate),
                                  style: TextStyles.bodySmall.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (widget.recommendation.expiryDate != null)
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.warning,
                                  size: 16,
                                  color: Colors.orange[600],
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    'মেয়াদ: ${_formatDate(widget.recommendation.expiryDate!)}',
                                    style: TextStyles.bodySmall.copyWith(
                                      color: Colors.orange[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),

                      // Completion info
                      if (widget.recommendation.isCompleted && widget.recommendation.completedAt != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 16,
                              color: Colors.green[600],
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                'সম্পন্ন: ${_formatDate(widget.recommendation.completedAt!)}',
                                style: TextStyles.bodySmall.copyWith(
                                  color: Colors.green[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],

                      // Rating display
                      if (widget.recommendation.rating != null) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < widget.recommendation.rating!
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 16,
                                  color: Colors.amber[600],
                                );
                              }),
                            ),
                            if (widget.recommendation.userFeedback?.isNotEmpty == true)
                              Flexible(
                                child: Text(
                                  widget.recommendation.userFeedback!,
                                  style: TextStyles.bodySmall.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                    fontStyle: FontStyle.italic,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                // Action buttons
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Audio button
                      if (widget.recommendation.audioUrl != null)
                        IconButton(
                          onPressed: _toggleAudio,
                          icon: Icon(
                            _isPlaying ? Icons.pause_circle : Icons.play_circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          tooltip: StringConstants.listen,
                        ),

                      const Spacer(),

                      // Rate button (for completed tasks)
                      if (widget.recommendation.isCompleted && widget.recommendation.rating == null)
                        TextButton.icon(
                          onPressed: _showRatingDialog,
                          icon: const Icon(Icons.star_rate, size: 18),
                          label: const Text('রেটিং দিন'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.amber[600],
                          ),
                        ),

                      // Complete button
                      if (!widget.recommendation.isCompleted) ...[
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            _animationController.forward();
                            widget.onCompleted();
                          },
                          icon: const Icon(Icons.check, size: 18),
                          label: Text(StringConstants.markAsDone),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
    String label;
    Color color;

    switch (widget.recommendation.priority) {
      case 'critical':
        label = 'জরুরি';
        color = Colors.red[600]!;
        break;
      case 'high':
        label = 'উচ্চ';
        color = Colors.orange[600]!;
        break;
      case 'medium':
        label = 'মাঝারি';
        color = Colors.blue[600]!;
        break;
      case 'low':
        label = 'কম';
        color = Colors.green[600]!;
        break;
      default:
        label = 'সাধারণ';
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

  Widget _buildCategoryChip() {
    String label;

    switch (widget.recommendation.category) {
      case 'irrigation':
        label = StringConstants.irrigation;
        break;
      case 'fertilizer':
        label = StringConstants.fertilizer;
        break;
      case 'pestControl':
        label = StringConstants.pesticide;
        break;
      case 'harvest':
        label = 'ফসল কাটা';
        break;
      case 'planting':
        label = 'রোপণ';
        break;
      default:
        label = 'সাধারণ';
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

  Color _getPriorityColor() {
    switch (widget.recommendation.priority) {
      case 'critical':
        return Colors.red[600]!;
      case 'high':
        return Colors.orange[600]!;
      case 'medium':
        return Colors.blue[600]!;
      case 'low':
        return Colors.green[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck == today) {
      return 'আজ ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (dateToCheck == today.subtract(const Duration(days: 1))) {
      return 'গতকাল ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (dateToCheck == today.add(const Duration(days: 1))) {
      return 'আগামীকাল ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
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
    return AlertDialog(
      title: const Text('পরামর্শের মূল্যায়ন করুন'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('এই পরামর্শটি কতটা কার্যকর ছিল?'),
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
            decoration: const InputDecoration(
              labelText: 'মতামত (ঐচ্ছিক)',
              hintText: 'আপনার অভিজ্ঞতা শেয়ার করুন...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(StringConstants.cancel),
        ),
        ElevatedButton(
          onPressed: _rating > 0
              ? () {
                  widget.onSubmit(_rating, _feedbackController.text.trim().isEmpty
                      ? null : _feedbackController.text.trim());
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text('জমা দিন'),
        ),
      ],
    );
  }
}
