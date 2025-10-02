import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/text_styles.dart';
import '../../../config/constants/string_constants.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _logoController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoScaleAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logoController.forward();
      Future.delayed(const Duration(milliseconds: 300), () {
        _fadeController.forward();
        _slideController.forward();
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 60),

                // Logo with Scale Animation
                ScaleTransition(
                  scale: _logoScaleAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.agriculture_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Main Content
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Welcome Card
                          Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).shadowColor.withValues(alpha: 0.08),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '🌾 ${l10n.appName}',
                                  style: TextStyles.headline1.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  l10n.smartFarmingAssistant,
                                  style: TextStyles.headline3.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 24),
                                Container(
                                  width: 60,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  l10n.appDescription,
                                  style: TextStyles.bodyLarge.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                                    height: 1.6,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Feature Highlights
                          Row(
                            children: [
                              Expanded(
                                child: _buildFeatureCard(
                                  icon: Icons.wb_sunny_rounded,
                                  title: l10n.weather,
                                  color: AppColors.secondary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildFeatureCard(
                                  icon: Icons.grass_rounded,
                                  title: l10n.crops,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildFeatureCard(
                                  icon: Icons.support_agent_rounded,
                                  title: l10n.support,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Get Started Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: !_isLoading ? AppColors.primary : Theme.of(context).colorScheme.outline,
                      boxShadow: !_isLoading
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ]
                          : null,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: !_isLoading ? _onGetStarted : null,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: _isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      l10n.loading,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      l10n.getStarted,
                                      style: TextStyles.bodyLarge.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.rocket_launch_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  void _onGetStarted() async {
    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/language-selection');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
