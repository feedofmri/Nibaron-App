import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../view_models/home_view_model.dart';
import '../widgets/weather_card.dart';
import '../widgets/hazard_alert_banner.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/refresh_indicator_custom.dart';
import '../../../config/theme/text_styles.dart';
import '../../../config/constants/asset_constants.dart';
import '../../common/widgets/custom_app_bar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: false,
        titleWidget: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                AssetConstants.nibaronIcon,
                width: 32,
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.agriculture,
                      color: Colors.white,
                      size: 18,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.appName,
              style: TextStyles.headline3.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicatorCustom(
        onRefresh: () => ref.read(homeViewModelProvider.notifier).refresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Weather Card
              WeatherCard(weather: homeState.currentWeather),

              const SizedBox(height: 16),

              // Hazard Alert Banner (if any active alerts)
              if (homeState.activeHazards.isNotEmpty) ...[
                HazardAlertBanner(hazards: homeState.activeHazards),
                const SizedBox(height: 16),
              ],

              // Today's Recommendation Card
              if (homeState.todayRecommendation != null) ...[
                RecommendationCard(
                  recommendation: homeState.todayRecommendation!,
                  onCompleted: () => ref
                      .read(homeViewModelProvider.notifier)
                      .markRecommendationCompleted(homeState.todayRecommendation!.id),
                ),
                const SizedBox(height: 24),
              ],

              // Quick Actions Grid
              Text(
                l10n.quickActions,
                style: TextStyles.headline3,
              ),
              const SizedBox(height: 12),
              const QuickActionsGrid(),

              const SizedBox(height: 24),

              // Loading indicator
              if (homeState.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),

              // Error message
              if (homeState.error != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          homeState.error!,
                          style: TextStyles.bodyMedium.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
