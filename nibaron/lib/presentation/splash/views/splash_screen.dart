import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/animated_logo.dart';
import '../../../config/constants/string_constants.dart';
import '../../../config/theme/text_styles.dart';
import '../../../config/theme/app_colors.dart';
import '../../../core/services/onboarding_service.dart';
import '../../../config/routes/app_routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fadeController.forward();
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    // Wait for animation to complete
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    try {
      // Check onboarding status
      final isFirstLaunch = await OnboardingService.isFirstLaunch();
      final isLanguageSelected = await OnboardingService.isLanguageSelected();

      if (isFirstLaunch && !isLanguageSelected) {
        // First time user - go to language selection
        Navigator.of(context).pushReplacementNamed(AppRoutes.languageSelection);
      } else if (!isFirstLaunch && isLanguageSelected) {
        // Existing user who has completed onboarding - go to main app
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      } else {
        // Edge case: inconsistent state, reset and go to language selection
        await OnboardingService.resetOnboarding();
        Navigator.of(context).pushReplacementNamed(AppRoutes.languageSelection);
      }
    } catch (e) {
      // If there's any error, default to language selection
      Navigator.of(context).pushReplacementNamed(AppRoutes.languageSelection);
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Theme.of(context).brightness == Brightness.light
                ? AppColors.lightGradient
                : AppColors.darkGradient,
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Custom Logo with theme colors
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white, // White card background
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.25), // Fadeout glow
                              blurRadius: 48,
                              spreadRadius: 8,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            color: Colors.transparent,
                            child: Image.asset(
                              'assets/images/nibaron_icon.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.agriculture_rounded,
                                  size: 60,
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // App Name with theme colors
                      Text(
                        StringConstants.appName,
                        style: TextStyles.headline1.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // App Tagline with theme colors
                      Text(
                        'পূর্বাভাস। প্রতিরোধ। সুরক্ষা।\nForecast. Prevent. Protect.',
                        style: TextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 48),

                      // Loading Indicator with theme colors
                      CircularProgressIndicator(
                        color: AppColors.primary,
                        strokeWidth: 3,
                      ),

                      const SizedBox(height: 24),

                      Text(
                        'লোড হচ্ছে... | Loading...',
                        style: TextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
