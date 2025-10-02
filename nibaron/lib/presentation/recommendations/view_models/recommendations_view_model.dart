import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/recommendation/recommendation_model.dart';

enum RecommendationFilter { all, today, thisWeek, upcoming, completed }
enum RecommendationCategory { all, irrigation, fertilizer, pestControl, harvest, planting }

class RecommendationsState {
  final List<RecommendationModel> recommendations;
  final bool isLoading;
  final String? error;
  final RecommendationFilter selectedFilter;
  final RecommendationCategory selectedCategory;
  final String searchQuery;

  const RecommendationsState({
    this.recommendations = const [],
    this.isLoading = false,
    this.error,
    this.selectedFilter = RecommendationFilter.all,
    this.selectedCategory = RecommendationCategory.all,
    this.searchQuery = '',
  });

  RecommendationsState copyWith({
    List<RecommendationModel>? recommendations,
    bool? isLoading,
    String? error,
    RecommendationFilter? selectedFilter,
    RecommendationCategory? selectedCategory,
    String? searchQuery,
  }) {
    return RecommendationsState(
      recommendations: recommendations ?? this.recommendations,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  List<RecommendationModel> get filteredRecommendations {
    List<RecommendationModel> filtered = recommendations;

    // Filter by category
    if (selectedCategory != RecommendationCategory.all) {
      filtered = filtered.where((rec) => rec.category == selectedCategory.name).toList();
    }

    // Filter by time period
    final now = DateTime.now();
    switch (selectedFilter) {
      case RecommendationFilter.today:
        filtered = filtered.where((rec) {
          final recDate = rec.recommendedDate;
          return recDate.year == now.year &&
              recDate.month == now.month &&
              recDate.day == now.day;
        }).toList();
        break;
      case RecommendationFilter.thisWeek:
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        final weekEnd = weekStart.add(const Duration(days: 6));
        filtered = filtered.where((rec) {
          final recDate = rec.recommendedDate;
          return recDate.isAfter(weekStart) && recDate.isBefore(weekEnd.add(const Duration(days: 1)));
        }).toList();
        break;
      case RecommendationFilter.upcoming:
        filtered = filtered.where((rec) => rec.recommendedDate.isAfter(now)).toList();
        break;
      case RecommendationFilter.completed:
        filtered = filtered.where((rec) => rec.isCompleted).toList();
        break;
      case RecommendationFilter.all:
        break;
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((rec) {
        return rec.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            rec.description.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Sort by priority and date
    filtered.sort((a, b) {
      // First sort by completion status
      if (a.isCompleted != b.isCompleted) {
        return a.isCompleted ? 1 : -1;
      }

      // Then by priority
      const priorityOrder = {'critical': 0, 'high': 1, 'medium': 2, 'low': 3};
      final aPriority = priorityOrder[a.priority] ?? 3;
      final bPriority = priorityOrder[b.priority] ?? 3;
      if (aPriority != bPriority) {
        return aPriority.compareTo(bPriority);
      }

      // Finally by date
      return a.recommendedDate.compareTo(b.recommendedDate);
    });

    return filtered;
  }
}

class RecommendationsViewModel extends StateNotifier<RecommendationsState> {
  RecommendationsViewModel() : super(const RecommendationsState()) {
    loadRecommendations();
  }

  Future<void> loadRecommendations() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 800));

      final mockRecommendations = _generateMockRecommendations();

      state = state.copyWith(
        recommendations: mockRecommendations,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong', // Use English error message for proper localization
      );
    }
  }

  void setFilter(RecommendationFilter filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  void setCategory(RecommendationCategory category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  Future<void> markAsCompleted(String recommendationId) async {
    final recommendations = state.recommendations.map((rec) {
      if (rec.id == recommendationId) {
        return RecommendationModel(
          id: rec.id,
          farmId: rec.farmId,
          cropId: rec.cropId,
          title: rec.title,
          description: rec.description,
          category: rec.category,
          priority: rec.priority,
          recommendedDate: rec.recommendedDate,
          expiryDate: rec.expiryDate,
          audioUrl: rec.audioUrl,
          additionalData: rec.additionalData,
          isCompleted: true,
          completedAt: DateTime.now(),
          userFeedback: rec.userFeedback,
          rating: rec.rating,
          createdAt: rec.createdAt,
          updatedAt: DateTime.now(),
        );
      }
      return rec;
    }).toList();

    state = state.copyWith(recommendations: recommendations);
  }

  Future<void> rateRecommendation(String recommendationId, int rating, String? feedback) async {
    final recommendations = state.recommendations.map((rec) {
      if (rec.id == recommendationId) {
        return RecommendationModel(
          id: rec.id,
          farmId: rec.farmId,
          cropId: rec.cropId,
          title: rec.title,
          description: rec.description,
          category: rec.category,
          priority: rec.priority,
          recommendedDate: rec.recommendedDate,
          expiryDate: rec.expiryDate,
          audioUrl: rec.audioUrl,
          additionalData: rec.additionalData,
          isCompleted: rec.isCompleted,
          completedAt: rec.completedAt,
          userFeedback: feedback,
          rating: rating,
          createdAt: rec.createdAt,
          updatedAt: DateTime.now(),
        );
      }
      return rec;
    }).toList();

    state = state.copyWith(recommendations: recommendations);
  }

  Future<void> refresh() async {
    await loadRecommendations();
  }

  List<RecommendationModel> _generateMockRecommendations() {
    final now = DateTime.now();

    return [
      RecommendationModel(
        id: '1',
        farmId: 'farm1',
        cropId: 'rice1',
        title: 'Time for Irrigation Today',
        description: 'Soil moisture has decreased. Irrigate between 6 AM to 9 AM.',
        category: 'irrigation',
        priority: 'high',
        recommendedDate: now,
        expiryDate: now.add(const Duration(hours: 6)),
        audioUrl: 'audio/irrigation_today.mp3',
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now.subtract(const Duration(hours: 2)),
      ),
      RecommendationModel(
        id: '2',
        farmId: 'farm1',
        cropId: 'rice1',
        title: 'Apply Urea Fertilizer',
        description: 'It\'s time to apply urea fertilizer 21 days after rice seedling transplantation.',
        category: 'fertilizer',
        priority: 'medium',
        recommendedDate: now.add(const Duration(days: 1)),
        audioUrl: 'audio/urea_fertilizer.mp3',
        createdAt: now.subtract(const Duration(hours: 1)),
        updatedAt: now.subtract(const Duration(hours: 1)),
      ),
      RecommendationModel(
        id: '3',
        farmId: 'farm1',
        cropId: 'rice1',
        title: 'Prevent Leaf Burn Disease',
        description: 'Weather conditions pose risk of leaf burn disease. Apply preventive spray.',
        category: 'pestControl',
        priority: 'critical',
        recommendedDate: now.subtract(const Duration(hours: 3)),
        expiryDate: now.add(const Duration(hours: 12)),
        audioUrl: 'audio/leaf_burn_prevention.mp3',
        createdAt: now.subtract(const Duration(hours: 4)),
        updatedAt: now.subtract(const Duration(hours: 4)),
      ),
      RecommendationModel(
        id: '4',
        farmId: 'farm1',
        cropId: 'rice1',
        title: 'Prepare for Early Seed Sowing',
        description: 'Collect improved variety seeds for the next season.',
        category: 'planting',
        priority: 'low',
        recommendedDate: now.add(const Duration(days: 7)),
        audioUrl: 'audio/seed_preparation.mp3',
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
      RecommendationModel(
        id: '5',
        farmId: 'farm1',
        cropId: 'rice1',
        title: 'Clean Irrigation System',
        description: 'Irrigation was done yesterday. Clean the irrigation canal today.',
        category: 'irrigation',
        priority: 'medium',
        recommendedDate: now.subtract(const Duration(days: 1)),
        isCompleted: true,
        completedAt: now.subtract(const Duration(hours: 6)),
        rating: 5,
        userFeedback: 'Very helpful advice',
        audioUrl: 'audio/irrigation_clean.mp3',
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(hours: 6)),
      ),
    ];
  }
}

final recommendationsViewModelProvider = StateNotifierProvider<RecommendationsViewModel, RecommendationsState>(
  (ref) => RecommendationsViewModel(),
);
