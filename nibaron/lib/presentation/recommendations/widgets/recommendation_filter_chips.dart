import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../view_models/recommendations_view_model.dart';
import '../../../config/constants/string_constants.dart';
import '../../../config/theme/text_styles.dart';

class RecommendationFilterChips extends ConsumerWidget {
  const RecommendationFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(recommendationsViewModelProvider);
    final notifier = ref.read(recommendationsViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Time Filter Chips
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            l10n.filterByTime,
            style: TextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(
                context,
                l10n.all,
                state.selectedFilter == RecommendationFilter.all,
                () => notifier.setFilter(RecommendationFilter.all),
              ),
              _buildFilterChip(
                context,
                l10n.today,
                state.selectedFilter == RecommendationFilter.today,
                () => notifier.setFilter(RecommendationFilter.today),
              ),
              _buildFilterChip(
                context,
                l10n.thisWeek,
                state.selectedFilter == RecommendationFilter.thisWeek,
                () => notifier.setFilter(RecommendationFilter.thisWeek),
              ),
              _buildFilterChip(
                context,
                l10n.upcomingTasks,
                state.selectedFilter == RecommendationFilter.upcoming,
                () => notifier.setFilter(RecommendationFilter.upcoming),
              ),
              _buildFilterChip(
                context,
                l10n.completed,
                state.selectedFilter == RecommendationFilter.completed,
                () => notifier.setFilter(RecommendationFilter.completed),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Category Filter Chips
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            l10n.filterByCategory,
            style: TextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCategoryChip(
                context,
                l10n.all,
                Icons.category,
                state.selectedCategory == RecommendationCategory.all,
                () => notifier.setCategory(RecommendationCategory.all),
              ),
              _buildCategoryChip(
                context,
                l10n.irrigation,
                Icons.water_drop,
                state.selectedCategory == RecommendationCategory.irrigation,
                () => notifier.setCategory(RecommendationCategory.irrigation),
              ),
              _buildCategoryChip(
                context,
                l10n.fertilizer,
                Icons.scatter_plot,
                state.selectedCategory == RecommendationCategory.fertilizer,
                () => notifier.setCategory(RecommendationCategory.fertilizer),
              ),
              _buildCategoryChip(
                context,
                l10n.pesticide,
                Icons.bug_report,
                state.selectedCategory == RecommendationCategory.pestControl,
                () => notifier.setCategory(RecommendationCategory.pestControl),
              ),
              _buildCategoryChip(
                context,
                l10n.harvestTime,
                Icons.agriculture,
                state.selectedCategory == RecommendationCategory.harvest,
                () => notifier.setCategory(RecommendationCategory.harvest),
              ),
              _buildCategoryChip(
                context,
                l10n.planting,
                Icons.eco,
                state.selectedCategory == RecommendationCategory.planting,
                () => notifier.setCategory(RecommendationCategory.planting),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyles.bodySmall.copyWith(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyles.bodySmall.copyWith(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
