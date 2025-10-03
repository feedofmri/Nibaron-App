import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/models/weather/weather_model.dart';
import '../../../config/constants/asset_constants.dart';
import '../../../config/theme/text_styles.dart';
import '../../../config/theme/app_colors.dart';

class ImprovedForecastWidget extends StatelessWidget {
  final List<WeatherModel> forecast;

  const ImprovedForecastWidget({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: AppColors.lightPrimary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '7-Day Forecast',
                style: TextStyles.headline3.copyWith(
                  color: AppColors.lightPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Updated now',
                  style: TextStyles.bodySmall.copyWith(
                    color: AppColors.lightPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Enhanced Forecast Cards
        Card(
          elevation: 4,
          shadowColor: AppColors.lightPrimary.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.lightPrimary.withValues(alpha: 0.05),
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              children: forecast.take(7).map((weather) => _buildEnhancedForecastItem(context, weather)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedForecastItem(BuildContext context, WeatherModel weather) {
    final isToday = _isToday(weather.timestamp);
    final isTomorrow = _isTomorrow(weather.timestamp);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isToday
            ? AppColors.lightAccent.withValues(alpha: 0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isToday
            ? Border.all(color: AppColors.lightAccent.withValues(alpha: 0.2), width: 1.5)
            : Border.all(color: Colors.grey.withValues(alpha: 0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top Row: Date and Temperature
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date Section
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isToday
                            ? 'Today'
                            : isTomorrow
                                ? 'Tomorrow'
                                : _formatWeekday(weather.timestamp),
                        style: TextStyles.bodyLarge.copyWith(
                          fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                          color: isToday
                              ? AppColors.lightAccent
                              : AppColors.lightPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatDate(weather.timestamp),
                        style: TextStyles.bodySmall.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),

                // Temperature Section
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${weather.temperature.round()}°C',
                    style: TextStyles.headline2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightPrimary,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Middle Row: Weather Icon and Description
            Row(
              children: [
                // Weather Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getWeatherColor(weather.condition).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SvgPicture.asset(
                    AssetConstants.getWeatherIcon(weather.condition),
                    width: 40,
                    height: 40,
                    colorFilter: ColorFilter.mode(
                      _getWeatherColor(weather.condition),
                      BlendMode.srcIn,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Weather Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weather.description,
                        style: TextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (!weather.description.toLowerCase().contains(weather.condition.replaceAll('_', ' ').toLowerCase()))
                        Text(
                          weather.condition.replaceAll('_', ' ').toUpperCase(),
                          style: TextStyles.bodySmall.copyWith(
                            color: _getWeatherColor(weather.condition),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Bottom Row: Weather Details
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Precipitation
                  if (weather.precipitation > 0)
                    _buildDetailItem(
                      icon: Icons.water_drop,
                      label: 'Rain',
                      value: '${weather.precipitation.round()}mm',
                      color: Colors.blue[600]!,
                    ),

                  // Wind Speed
                  _buildDetailItem(
                    icon: Icons.air,
                    label: 'Wind',
                    value: '${weather.windSpeed.round()}km/h',
                    color: Colors.grey[600]!,
                  ),

                  // Humidity
                  _buildDetailItem(
                    icon: Icons.water_drop_outlined,
                    label: 'Humidity',
                    value: '${weather.humidity}%',
                    color: Colors.teal[600]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: color,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyles.bodySmall.copyWith(
            color: Colors.grey[600],
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyles.bodySmall.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Color _getWeatherColor(String condition) {
    switch (condition) {
      case 'sunny':
        return Colors.orange;
      case 'cloudy':
        return Colors.grey[600]!;
      case 'rainy':
      case 'drizzle':
      case 'rain_showers':
        return Colors.blue;
      case 'thunderstorm':
      case 'thunderstorm_hail':
        return Colors.purple;
      case 'snowy':
      case 'snow_showers':
        return Colors.lightBlue;
      case 'foggy':
        return Colors.grey[400]!;
      default:
        return AppColors.lightPrimary;
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool _isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day;
  }

  String _formatWeekday(DateTime date) {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[date.weekday - 1];
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
  }
}
