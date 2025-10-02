import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../view_models/recommendations_view_model.dart';
import '../widgets/recommendation_filter_chips.dart';
import '../widgets/recommendation_search_bar.dart';
import '../widgets/recommendation_list_item.dart';
import '../../../config/constants/string_constants.dart';
import '../../../config/theme/text_styles.dart';

class RecommendationsScreen extends ConsumerWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recommendationsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstants.cropCareRecommendations),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(recommendationsViewModelProvider.notifier).refresh(),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(recommendationsViewModelProvider.notifier).refresh(),
          child: CustomScrollView(
            slivers: [
              // Search Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: RecommendationSearchBar(
                    onSearchChanged: (query) =>
                        ref.read(recommendationsViewModelProvider.notifier).setSearchQuery(query),
                  ),
                ),
              ),

              // Filter Chips
              const SliverToBoxAdapter(
                child: RecommendationFilterChips(),
              ),

              // Statistics Row
              if (state.recommendations.isNotEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              context,
                              'মোট',
                              state.recommendations.length.toString(),
                              Icons.list_alt,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              context,
                              'সম্পন্ন',
                              state.recommendations.where((r) => r.isCompleted).length.toString(),
                              Icons.check_circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              context,
                              'বাকি',
                              state.recommendations.where((r) => !r.isCompleted).length.toString(),
                              Icons.pending,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // Recommendations List or Empty/Error States
              if (state.isLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.error != null)
                SliverFillRemaining(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.error!,
                            style: TextStyles.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => ref
                                .read(recommendationsViewModelProvider.notifier)
                                .refresh(),
                            child: Text(StringConstants.retry),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else if (state.filteredRecommendations.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: 64,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'কোনো পরামর্শ পাওয়া যায়নি',
                            style: TextStyles.bodyMedium.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final recommendation = state.filteredRecommendations[index];
                        return RecommendationListItem(
                          recommendation: recommendation,
                          onCompleted: () => ref
                              .read(recommendationsViewModelProvider.notifier)
                              .markAsCompleted(recommendation.id),
                          onRate: (rating, feedback) => ref
                              .read(recommendationsViewModelProvider.notifier)
                              .rateRecommendation(recommendation.id, rating, feedback),
                        );
                      },
                      childCount: state.filteredRecommendations.length,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyles.headline3.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            title,
            style: TextStyles.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
