import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../common/widgets/custom_app_bar.dart';
import '../view_models/weather_view_model.dart';
import '../widgets/improved_forecast_widget.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';
import '../../../config/constants/asset_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/models/weather/weather_model.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(weatherViewModelProvider.notifier).refreshWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final weatherState = ref.watch(weatherViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.weatherAndAlerts,
        additionalActions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(weatherViewModelProvider.notifier).refreshWeatherData(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(weatherViewModelProvider.notifier).refreshWeatherData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Weather Section
              if (weatherState.isLoading && weatherState.currentWeather == null)
                _buildLoadingCard(context)
              else if (weatherState.error != null && weatherState.currentWeather == null)
                _buildErrorCard(context, weatherState.error!, ref)
              else if (weatherState.currentWeather != null)
                _buildCurrentWeatherCard(context, weatherState.currentWeather!, l10n),

              const SizedBox(height: 24),

              // Weather Details Section
              if (weatherState.currentWeather != null) ...[
                Text(
                  'Weather Details',
                  style: TextStyles.headline3,
                ),
                const SizedBox(height: 12),
                _buildWeatherDetailsCard(context, weatherState.currentWeather!, l10n),
                const SizedBox(height: 24),
              ],

              // 7-Day Forecast Section - IMPROVED
              if (weatherState.forecast.isNotEmpty) ...[
                ImprovedForecastWidget(forecast: weatherState.forecast),
              ] else if (weatherState.currentWeather != null) ...[
                // Show loading for forecast if current weather is loaded but forecast isn't
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(width: 16),
                        Text(
                          'Loading forecast...',
                          style: TextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Last Updated Info
              if (weatherState.lastUpdated != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      'Last updated: ${_formatTime(weatherState.lastUpdated!)}',
                      style: TextStyles.bodySmall.copyWith(
                        color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentWeatherCard(BuildContext context, WeatherModel weather, AppLocalizations l10n) {
    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.lightPrimary.withOpacity(0.15),
              AppColors.lightPrimary.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location and main weather
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 20,
                            color: AppColors.lightPrimary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              weather.location,
                              style: TextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${weather.temperature.round()}°C',
                        style: TextStyles.weatherTemperature.copyWith(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        weather.description,
                        style: TextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Feels like ${weather.feelsLike.round()}°C',
                        style: TextStyles.bodyMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                // Weather icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    AssetConstants.getWeatherIcon(weather.condition),
                    width: 80,
                    height: 80,
                    colorFilter: ColorFilter.mode(
                      AppColors.lightPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Sunrise and Sunset
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSunInfo(context, Icons.wb_sunny, 'Sunrise', _formatTime(weather.sunrise)),
                Container(
                  height: 40,
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ),
                _buildSunInfo(context, Icons.brightness_3, 'Sunset', _formatTime(weather.sunset)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetailsCard(BuildContext context, WeatherModel weather, AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildDetailItem(context, Icons.water_drop, 'Humidity', '${weather.humidity}%')),
                Expanded(child: _buildDetailItem(context, Icons.air, 'Wind Speed', '${weather.windSpeed.round()} km/h')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildDetailItem(context, Icons.compress, 'Pressure', '${weather.pressure.round()} hPa')),
                Expanded(child: _buildDetailItem(context, Icons.visibility, 'Visibility', '${weather.visibility.round()} km')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildDetailItem(context, Icons.wb_sunny_outlined, 'UV Index', weather.uvIndex.toString())),
                Expanded(child: _buildDetailItem(context, Icons.grain, 'Precipitation', '${weather.precipitation} mm')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastList(BuildContext context, List<WeatherModel> forecast, AppLocalizations l10n) {
    return Card(
      child: Column(
        children: forecast.take(7).map((weather) => _buildForecastItem(context, weather)).toList(),
      ),
    );
  }

  Widget _buildForecastItem(BuildContext context, WeatherModel weather) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.5),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Date
          SizedBox(
            width: 80,
            child: Text(
              _formatDate(weather.timestamp),
              style: TextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Weather icon
          SvgPicture.asset(
            AssetConstants.getWeatherIcon(weather.condition),
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(
              AppColors.lightPrimary,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 16),
          // Weather description
          Expanded(
            child: Text(
              weather.description,
              style: TextStyles.bodyMedium,
            ),
          ),
          // Temperature
          Text(
            '${weather.temperature.round()}°C',
            style: TextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.lightPrimary,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyles.bodySmall.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSunInfo(BuildContext context, IconData icon, String label, String time) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.lightAccent,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyles.bodySmall.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: TextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingCard(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(24),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context, String error, WidgetRef ref) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Weather data unavailable',
              style: TextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(weatherViewModelProvider.notifier).refreshWeatherData(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';

    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[dateTime.weekday - 1];
  }
}
