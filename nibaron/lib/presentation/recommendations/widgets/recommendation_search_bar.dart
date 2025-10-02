import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme/text_styles.dart';

class RecommendationSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;

  const RecommendationSearchBar({
    super.key,
    required this.onSearchChanged,
  });

  @override
  State<RecommendationSearchBar> createState() => _RecommendationSearchBarState();
}

class _RecommendationSearchBarState extends State<RecommendationSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onSearchChanged,
        style: TextStyles.bodyMedium,
        decoration: InputDecoration(
          hintText: l10n.searchActivities, // Using existing key as fallback
          hintStyle: TextStyles.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  onPressed: () {
                    _controller.clear();
                    widget.onSearchChanged('');
                    setState(() {});
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
