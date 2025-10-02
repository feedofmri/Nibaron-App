import 'package:flutter/material.dart';
import '../../../config/constants/string_constants.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onSearchChanged,
        style: TextStyles.bodyMedium,
        decoration: InputDecoration(
          hintText: 'পরামর্শ খুঁজুন...',
          hintStyle: TextStyles.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
