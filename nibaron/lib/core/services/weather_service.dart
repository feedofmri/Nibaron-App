import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../../data/models/weather/weather_model.dart';

class WeatherService {
  // Using OpenWeatherMap API (free alternative to Google Weather API)
  // You can replace this with Google Weather API if you have access
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = 'YOUR_OPENWEATHER_API_KEY'; // Replace with your API key

  // Alternative: Using a free weather service
  static const String _freeWeatherUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherModel> getCurrentWeather({String? city, double? lat, double? lon}) async {
    try {
      // If no coordinates provided, get current location
      if (lat == null || lon == null) {
        if (city == null) {
          final position = await _getCurrentPosition();
          lat = position.latitude;
          lon = position.longitude;
        }
      }

      // Using Open-Meteo (free weather API) - primary source
      final weatherData = await _fetchFromOpenMeteo(lat!, lon!);
      final locationName = city ?? await _getLocationName(lat, lon);

      return WeatherModel(
        location: locationName,
        latitude: lat,
        longitude: lon,
        temperature: weatherData['current']['temperature_2m'].toDouble(),
        feelsLike: weatherData['current']['apparent_temperature'].toDouble(),
        condition: _mapWeatherCode(weatherData['current']['weather_code']),
        description: _getWeatherDescription(weatherData['current']['weather_code']),
        humidity: weatherData['current']['relative_humidity_2m'],
        windSpeed: weatherData['current']['wind_speed_10m'].toDouble(),
        windDirection: weatherData['current']['wind_direction_10m'].toDouble(),
        pressure: weatherData['current']['surface_pressure'].toDouble(),
        visibility: _calculateVisibility(weatherData['current']),
        uvIndex: weatherData['current']['uv_index']?.toInt() ?? 0,
        precipitation: weatherData['current']['precipitation'].toDouble(),
        timestamp: DateTime.now(),
        sunrise: DateTime.parse(weatherData['daily']['sunrise'][0]),
        sunset: DateTime.parse(weatherData['daily']['sunset'][0]),
      );
    } catch (e) {
      print('Error fetching weather data: $e');

      // Try alternative weather source instead of mock data
      try {
        return await _fetchFromAlternativeSource(lat, lon);
      } catch (altError) {
        print('Alternative weather source failed: $altError');

        // Throw error instead of returning mock data
        throw Exception('Unable to fetch weather data from any source. Please check your internet connection.');
      }
    }
  }

  // Calculate visibility based on weather conditions
  double _calculateVisibility(Map<String, dynamic> currentData) {
    final weatherCode = currentData['weather_code'];
    final humidity = currentData['relative_humidity_2m'];

    // Base visibility on weather conditions
    switch (weatherCode) {
      case 45: case 48: return 0.5; // Fog
      case 51: case 53: case 55: return 3.0; // Drizzle
      case 61: case 63: case 65: return 2.0; // Rain
      case 71: case 73: case 75: return 1.0; // Snow
      case 95: case 96: case 99: return 1.5; // Thunderstorm
      default:
        // Clear conditions - visibility based on humidity
        if (humidity > 85) return 8.0;
        if (humidity > 70) return 12.0;
        return 15.0; // Excellent visibility
    }
  }

  // Alternative weather source using a different API
  Future<WeatherModel> _fetchFromAlternativeSource(double? lat, double? lon) async {
    if (lat == null || lon == null) {
      final position = await _getCurrentPosition();
      lat = position.latitude;
      lon = position.longitude;
    }

    // Use WeatherAPI.com as alternative (free tier available)
    final response = await http.get(
      Uri.parse('https://api.weatherapi.com/v1/current.json?key=YOUR_WEATHER_API_KEY&q=$lat,$lon&aqi=no'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final current = data['current'];
      final location = data['location'];

      return WeatherModel(
        location: location['name'] ?? 'Unknown Location',
        latitude: lat,
        longitude: lon,
        temperature: current['temp_c'].toDouble(),
        feelsLike: current['feelslike_c'].toDouble(),
        condition: _mapWeatherAPICondition(current['condition']['text']),
        description: current['condition']['text'],
        humidity: current['humidity'],
        windSpeed: current['wind_kph'].toDouble(),
        windDirection: current['wind_degree'].toDouble(),
        pressure: current['pressure_mb'].toDouble(),
        visibility: current['vis_km'].toDouble(),
        uvIndex: current['uv'].toInt(),
        precipitation: current['precip_mm'].toDouble(),
        timestamp: DateTime.now(),
        sunrise: DateTime.now().copyWith(hour: 6, minute: 0), // Would be provided by API
        sunset: DateTime.now().copyWith(hour: 18, minute: 0), // Would be provided by API
      );
    }

    throw Exception('Alternative weather API failed');
  }

  // Map WeatherAPI conditions to our standard conditions
  String _mapWeatherAPICondition(String condition) {
    final lowerCondition = condition.toLowerCase();
    if (lowerCondition.contains('sunny') || lowerCondition.contains('clear')) return 'sunny';
    if (lowerCondition.contains('cloud')) return 'cloudy';
    if (lowerCondition.contains('rain')) return 'rainy';
    if (lowerCondition.contains('storm')) return 'thunderstorm';
    if (lowerCondition.contains('snow')) return 'snowy';
    if (lowerCondition.contains('fog')) return 'foggy';
    return 'cloudy';
  }

  Future<Map<String, dynamic>> _fetchFromOpenMeteo(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$_freeWeatherUrl?latitude=$lat&longitude=$lon&current=temperature_2m,apparent_temperature,relative_humidity_2m,precipitation,weather_code,surface_pressure,wind_speed_10m,wind_direction_10m,uv_index&daily=sunrise,sunset&timezone=auto'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> _getLocationName(double lat, double lon) async {
    try {
      // Using reverse geocoding service
      final response = await http.get(
        Uri.parse('https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=$lat&longitude=$lon&localityLanguage=en'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['city'] ?? data['locality'] ?? 'Unknown Location';
      }
    } catch (e) {
      print('Error getting location name: $e');
    }
    return 'Current Location';
  }

  String _mapWeatherCode(int code) {
    // WMO Weather interpretation codes
    switch (code) {
      case 0: return 'sunny';
      case 1: case 2: case 3: return 'cloudy';
      case 45: case 48: return 'foggy';
      case 51: case 53: case 55: return 'drizzle';
      case 56: case 57: return 'freezing_drizzle';
      case 61: case 63: case 65: return 'rainy';
      case 66: case 67: return 'freezing_rain';
      case 71: case 73: case 75: return 'snowy';
      case 77: return 'snow_grains';
      case 80: case 81: case 82: return 'rain_showers';
      case 85: case 86: return 'snow_showers';
      case 95: return 'thunderstorm';
      case 96: case 99: return 'thunderstorm_hail';
      default: return 'cloudy';
    }
  }

  String _getWeatherDescription(int code) {
    switch (code) {
      case 0: return 'Clear sky';
      case 1: return 'Mainly clear';
      case 2: return 'Partly cloudy';
      case 3: return 'Overcast';
      case 45: return 'Fog';
      case 48: return 'Depositing rime fog';
      case 51: return 'Light drizzle';
      case 53: return 'Moderate drizzle';
      case 55: return 'Dense drizzle';
      case 56: return 'Light freezing drizzle';
      case 57: return 'Dense freezing drizzle';
      case 61: return 'Light rain';
      case 63: return 'Moderate rain';
      case 65: return 'Heavy rain';
      case 66: return 'Light freezing rain';
      case 67: return 'Heavy freezing rain';
      case 71: return 'Light snow';
      case 73: return 'Moderate snow';
      case 75: return 'Heavy snow';
      case 77: return 'Snow grains';
      case 80: return 'Light rain showers';
      case 81: return 'Moderate rain showers';
      case 82: return 'Violent rain showers';
      case 85: return 'Light snow showers';
      case 86: return 'Heavy snow showers';
      case 95: return 'Thunderstorm';
      case 96: return 'Thunderstorm with light hail';
      case 99: return 'Thunderstorm with heavy hail';
      default: return 'Unknown weather';
    }
  }

  Future<List<WeatherModel>> getWeatherForecast({double? lat, double? lon, int days = 7}) async {
    try {
      if (lat == null || lon == null) {
        final position = await _getCurrentPosition();
        lat = position.latitude;
        lon = position.longitude;
      }

      final response = await http.get(
        Uri.parse('$_freeWeatherUrl?latitude=$lat&longitude=$lon&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum,wind_speed_10m_max&timezone=auto&forecast_days=$days'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<WeatherModel> forecast = [];
        final locationName = await _getLocationName(lat, lon);

        for (int i = 0; i < days; i++) {
          forecast.add(WeatherModel(
            location: locationName,
            latitude: lat,
            longitude: lon,
            temperature: data['daily']['temperature_2m_max'][i].toDouble(),
            feelsLike: data['daily']['temperature_2m_max'][i].toDouble(),
            condition: _mapWeatherCode(data['daily']['weather_code'][i]),
            description: _getWeatherDescription(data['daily']['weather_code'][i]),
            humidity: 60, // API limitation - this would come from enhanced API
            windSpeed: data['daily']['wind_speed_10m_max'][i].toDouble(),
            windDirection: 0.0, // API limitation - this would come from enhanced API
            pressure: 1013.25, // API limitation - this would come from enhanced API
            visibility: 10.0, // API limitation - this would come from enhanced API
            uvIndex: 0, // API limitation - this would come from enhanced API
            precipitation: data['daily']['precipitation_sum'][i].toDouble(),
            timestamp: DateTime.now().add(Duration(days: i)),
            sunrise: DateTime.now().add(Duration(days: i, hours: 6)),
            sunset: DateTime.now().add(Duration(days: i, hours: 18)),
          ));
        }

        return forecast;
      } else {
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      print('Error fetching forecast data: $e');
      throw Exception('Unable to fetch weather forecast. Please try again later.');
    }
  }
}
