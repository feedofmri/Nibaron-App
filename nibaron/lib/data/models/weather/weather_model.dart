import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final String location;
  final double latitude;
  final double longitude;
  final double temperature;
  final double feelsLike;
  final String condition; // sunny, cloudy, rainy, stormy
  final String description;
  final int humidity;
  final double windSpeed;
  final double windDirection;
  final double pressure;
  final double visibility;
  final int uvIndex;
  final double precipitation;
  final DateTime timestamp;
  final DateTime sunrise;
  final DateTime sunset;

  WeatherModel({
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.pressure,
    required this.visibility,
    required this.uvIndex,
    required this.precipitation,
    required this.timestamp,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  WeatherModel copyWith({
    String? location,
    double? latitude,
    double? longitude,
    double? temperature,
    double? feelsLike,
    String? condition,
    String? description,
    int? humidity,
    double? windSpeed,
    double? windDirection,
    double? pressure,
    double? visibility,
    int? uvIndex,
    double? precipitation,
    DateTime? timestamp,
    DateTime? sunrise,
    DateTime? sunset,
  }) {
    return WeatherModel(
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      temperature: temperature ?? this.temperature,
      feelsLike: feelsLike ?? this.feelsLike,
      condition: condition ?? this.condition,
      description: description ?? this.description,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
      pressure: pressure ?? this.pressure,
      visibility: visibility ?? this.visibility,
      uvIndex: uvIndex ?? this.uvIndex,
      precipitation: precipitation ?? this.precipitation,
      timestamp: timestamp ?? this.timestamp,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  String get temperatureText => '${temperature.round()}°C';
  String get humidityText => '$humidity%';
  String get windSpeedText => '${windSpeed.round()} km/h';

  String getLocalizedTemperatureText(AppLocalizations l10n) =>
      '${temperature.round()}${l10n.celsiusUnit}';
  String getLocalizedWindSpeedText(AppLocalizations l10n) =>
      '${windSpeed.round()} ${l10n.kmPerHourUnit}';
}
