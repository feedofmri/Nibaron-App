import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/weather/weather_model.dart';
import '../../../core/services/weather_service.dart';

// Weather state class
class WeatherState {
  final WeatherModel? currentWeather;
  final List<WeatherModel> forecast;
  final bool isLoading;
  final String? error;
  final DateTime? lastUpdated;

  const WeatherState({
    this.currentWeather,
    this.forecast = const [],
    this.isLoading = false,
    this.error,
    this.lastUpdated,
  });

  WeatherState copyWith({
    WeatherModel? currentWeather,
    List<WeatherModel>? forecast,
    bool? isLoading,
    String? error,
    DateTime? lastUpdated,
  }) {
    return WeatherState(
      currentWeather: currentWeather ?? this.currentWeather,
      forecast: forecast ?? this.forecast,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

// Weather view model
class WeatherViewModel extends StateNotifier<WeatherState> {
  final WeatherService _weatherService;

  WeatherViewModel(this._weatherService) : super(const WeatherState());

  Future<void> loadCurrentWeather({String? city, double? lat, double? lon}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final weather = await _weatherService.getCurrentWeather(
        city: city,
        lat: lat,
        lon: lon,
      );

      state = state.copyWith(
        currentWeather: weather,
        isLoading: false,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load weather data: ${e.toString()}',
      );
    }
  }

  Future<void> loadForecast({double? lat, double? lon, int days = 7}) async {
    try {
      final forecast = await _weatherService.getWeatherForecast(
        lat: lat,
        lon: lon,
        days: days,
      );

      state = state.copyWith(forecast: forecast);
    } catch (e) {
      print('Failed to load forecast: $e');
      // Don't update error state for forecast as current weather is more important
    }
  }

  Future<void> refreshWeatherData({String? city, double? lat, double? lon}) async {
    await Future.wait([
      loadCurrentWeather(city: city, lat: lat, lon: lon),
      loadForecast(lat: lat, lon: lon),
    ]);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Providers
final weatherServiceProvider = Provider<WeatherService>((ref) => WeatherService());

final weatherViewModelProvider = StateNotifierProvider<WeatherViewModel, WeatherState>((ref) {
  final weatherService = ref.watch(weatherServiceProvider);
  return WeatherViewModel(weatherService);
});

// Convenience provider for current weather (for home screen)
final currentWeatherProvider = Provider<WeatherModel?>((ref) {
  return ref.watch(weatherViewModelProvider).currentWeather;
});
