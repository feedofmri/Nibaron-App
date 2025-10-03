import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/weather/weather_model.dart';
import '../../../data/models/recommendation/recommendation_model.dart';
import '../../../core/services/location_service.dart';
import '../../../core/services/weather_service.dart';
import '../../../core/dependency_injection/service_locator.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(ref),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final Ref _ref;

  HomeViewModel(this._ref) : super(const HomeState());

  final LocationService _locationService = sl<LocationService>();
  final WeatherService _weatherService = WeatherService();

  Future<void> loadData() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Load data concurrently
      await Future.wait([
        _loadWeatherData(),
        _loadRecommendations(),
        _loadHazards(),
        _checkNotifications(),
      ]);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      print('Home data loading error: $e');
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    await loadData();
  }

  Future<void> _loadWeatherData() async {
    try {
      // Use the weather service to get real weather data with better error handling
      final weather = await _weatherService.getCurrentWeather();

      state = state.copyWith(currentWeather: weather);
      print('Weather data loaded successfully: ${weather.location} - ${weather.temperature}°C');
    } catch (e) {
      print('Weather loading error: $e');
      // No more fallback to mock data - just set error state
      state = state.copyWith(
        error: 'Unable to fetch weather data: ${e.toString()}',
      );
    }
  }

  Future<void> _loadRecommendations() async {
    try {
      // TODO: Replace with actual recommendation service when available
      // For now, only set recommendations if we have real data from API
      // Remove mock data completely
      state = state.copyWith(todayRecommendation: null);
    } catch (e) {
      print('Error loading recommendations: $e');
      state = state.copyWith(todayRecommendation: null);
    }
  }

  Future<void> _loadHazards() async {
    try {
      // TODO: Replace with actual hazard service when available
      // For now, only set hazards if we have real data from API
      // Remove mock data completely
      state = state.copyWith(activeHazards: []);
    } catch (e) {
      print('Error loading hazards: $e');
      state = state.copyWith(activeHazards: []);
    }
  }

  Future<void> _checkNotifications() async {
    try {
      // TODO: Replace with actual notification service when available
      // For now, only set notifications if we have real data from API
      state = state.copyWith(hasUnreadNotifications: false);
    } catch (e) {
      print('Error checking notifications: $e');
    }
  }

  Future<void> markRecommendationCompleted(String recommendationId) async {
    try {
      // Mark recommendation as completed
      final currentRec = state.todayRecommendation;
      if (currentRec != null && currentRec.id == recommendationId) {
        final updatedRec = currentRec.copyWith(
          isCompleted: true,
          completedAt: DateTime.now(),
        );
        state = state.copyWith(todayRecommendation: updatedRec);
      }
    } catch (e) {
      print('Error marking recommendation completed: $e');
    }
  }
}

class HomeState {
  final bool isLoading;
  final String? error;
  final WeatherModel? currentWeather;
  final RecommendationModel? todayRecommendation;
  final List<dynamic> activeHazards;
  final bool hasUnreadNotifications;

  const HomeState({
    this.isLoading = false,
    this.error,
    this.currentWeather,
    this.todayRecommendation,
    this.activeHazards = const [],
    this.hasUnreadNotifications = false,
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    WeatherModel? currentWeather,
    RecommendationModel? todayRecommendation,
    List<dynamic>? activeHazards,
    bool? hasUnreadNotifications,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentWeather: currentWeather ?? this.currentWeather,
      todayRecommendation: todayRecommendation ?? this.todayRecommendation,
      activeHazards: activeHazards ?? this.activeHazards,
      hasUnreadNotifications: hasUnreadNotifications ?? this.hasUnreadNotifications,
    );
  }
}
