import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/storage_service.dart';
import '../../../core/dependency_injection/service_locator.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, SplashState>(
  (ref) => SplashViewModel(),
);

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel() : super(const SplashState());

  final AuthService _authService = sl<AuthService>();
  final StorageService _storageService = sl<StorageService>();

  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);

    // Minimum splash duration
    await Future.delayed(const Duration(seconds: 2));

    try {
      // Check if user is logged in
      final isLoggedIn = await _authService.isLoggedIn();

      // Check if it's first time opening the app
      final isFirstTime = await _storageService.getBool('is_first_time') ?? true;

      String nextRoute;

      if (isFirstTime) {
        nextRoute = AppRoutes.onboarding;
      } else if (isLoggedIn) {
        nextRoute = AppRoutes.home;
      } else {
        nextRoute = AppRoutes.registration;
      }

      state = state.copyWith(
        isLoading: false,
        shouldNavigate: true,
        nextRoute: nextRoute,
      );
    } catch (e) {
      // On error, go to onboarding
      state = state.copyWith(
        isLoading: false,
        shouldNavigate: true,
        nextRoute: AppRoutes.onboarding,
        error: e.toString(),
      );
    }
  }
}

class SplashState {
  final bool isLoading;
  final bool shouldNavigate;
  final String? nextRoute;
  final String? error;

  const SplashState({
    this.isLoading = false,
    this.shouldNavigate = false,
    this.nextRoute,
    this.error,
  });

  SplashState copyWith({
    bool? isLoading,
    bool? shouldNavigate,
    String? nextRoute,
    String? error,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      shouldNavigate: shouldNavigate ?? this.shouldNavigate,
      nextRoute: nextRoute ?? this.nextRoute,
      error: error ?? this.error,
    );
  }
}
