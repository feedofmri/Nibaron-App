import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/weather/weather_model.dart';
import '../../../data/models/recommendation/recommendation_model.dart';
import '../../../core/services/location_service.dart';
import '../../../core/dependency_injection/service_locator.dart';

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(),
);

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(const HomeState());

  final LocationService _locationService = sl<LocationService>();

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
      // Get current location
      final position = await _locationService.getCurrentLocation();
      if (position == null) return;

      // Create mock weather data for demo
      final weather = WeatherModel(
        location: 'Sirajganj',
        latitude: position.latitude,
        longitude: position.longitude,
        temperature: 32.0,
        feelsLike: 35.0,
        condition: 'partly_cloudy',
        description: 'Partly Cloudy',
        humidity: 75,
        windSpeed: 12.0,
        windDirection: 180.0,
        pressure: 1013.25,
        visibility: 10.0,
        uvIndex: 7,
        precipitation: 0.0,
        timestamp: DateTime.now(),
        sunrise: DateTime.now().subtract(const Duration(hours: 2)),
        sunset: DateTime.now().add(const Duration(hours: 6)),
      );

      state = state.copyWith(currentWeather: weather);
    } catch (e) {
      print('Error loading weather data: $e');
    }
  }

  Future<void> _loadRecommendations() async {
    try {
      // Create mock recommendation for demo
      final recommendation = RecommendationModel(
        id: '1',
        farmId: 'farm1',
        cropId: 'crop1',
        title: 'Time for Irrigation',
        description: '20mm water needed. Irrigate in the evening.',
        category: 'irrigation',
        priority: 'high',
        recommendedDate: DateTime.now(),
        expiryDate: DateTime.now().add(const Duration(hours: 12)),
        audioUrl: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      state = state.copyWith(todayRecommendation: recommendation);
    } catch (e) {
      print('Error loading recommendations: $e');
    }
  }

  Future<void> _loadHazards() async {
    try {
      // Mock hazard data - in real app, this would come from API
      state = state.copyWith(activeHazards: []);
    } catch (e) {
      print('Error loading hazards: $e');
    }
  }

  Future<void> _checkNotifications() async {
    try {
      // Mock notification check
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
