import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/models/weather/weather_model.dart';
import '../../../config/constants/asset_constants.dart';
import '../../../config/constants/string_constants.dart';
import '../../../config/theme/text_styles.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel? weather;

  const WeatherCard({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    if (weather == null) {
      return _buildLoadingCard(context);
    }

    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location and main weather info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          weather!.location,
                          style: TextStyles.bodySmall.copyWith(
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      weather!.temperatureText,
                      style: TextStyles.weatherTemperature.copyWith(
                        color: Theme.of(context).textTheme.displayLarge?.color,
                      ),
                    ),
                    Text(
                      weather!.description,
                      style: TextStyles.bodyMedium.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                // Weather icon
                SvgPicture.asset(
                  AssetConstants.getWeatherIcon(weather!.condition),
                  width: 80,
                  height: 80,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Weather stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherStat(
                  context,
                  Icons.water_drop_outlined,
                  StringConstants.humidity,
                  weather!.humidityText,
                ),
                _buildWeatherStat(
                  context,
                  Icons.air_outlined,
                  StringConstants.windSpeed,
                  weather!.windSpeedText,
                ),
                _buildWeatherStat(
                  context,
                  Icons.wb_sunny_outlined,
                  StringConstants.uvIndex,
                  weather!.uvIndex.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 180,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                StringConstants.loading,
                style: TextStyles.bodyMedium.copyWith(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherStat(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        Text(
          label,
          style: TextStyles.caption.copyWith(
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
