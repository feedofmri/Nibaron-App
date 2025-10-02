import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../../presentation/splash/views/splash_screen.dart';
import '../../presentation/onboarding/views/onboarding_screen.dart';
import '../../presentation/onboarding/views/registration_screen.dart';
import '../../presentation/onboarding/views/otp_verification_screen.dart';
import '../../presentation/onboarding/views/farm_setup_screen.dart';
import '../../presentation/common/views/main_navigation_screen.dart';
import '../../presentation/weather/views/weather_screen.dart';
import '../../presentation/weather/views/alert_detail_screen.dart';
import '../../presentation/recommendations/views/recommendations_screen.dart';
import '../../presentation/recommendations/views/task_detail_screen.dart';
import '../../presentation/calendar/views/calendar_screen.dart';
import '../../presentation/calendar/views/event_detail_screen.dart';
import '../../presentation/action_log/views/action_log_screen.dart';
import '../../presentation/action_log/views/log_detail_screen.dart';
import '../../presentation/support/views/support_screen.dart';
import '../../presentation/support/views/faq_detail_screen.dart';
import '../../presentation/profile/views/profile_screen.dart';
import '../../presentation/profile/views/edit_profile_screen.dart';
import '../../presentation/profile/views/edit_farm_screen.dart';
import '../../presentation/profile/views/settings_screen.dart';
import '../../presentation/notifications/views/notifications_screen.dart';
import '../../presentation/notifications/views/notification_detail_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Authentication & Onboarding Routes
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case AppRoutes.registration:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());

      case AppRoutes.otpVerification:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(
            phoneNumber: args?['phoneNumber'] ?? '',
          ),
        );

      case AppRoutes.farmSetup:
        return MaterialPageRoute(builder: (_) => const FarmSetupScreen());

      // Main App Routes - Use MainNavigationScreen as the primary container
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());

      // Individual screens (for direct navigation if needed)
      case AppRoutes.weather:
        return MaterialPageRoute(builder: (_) => const WeatherScreen());

      case AppRoutes.alertDetail:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => AlertDetailScreen(
            alertId: args?.toString() ?? '',
          ),
        );

      case AppRoutes.recommendations:
        return MaterialPageRoute(builder: (_) => const RecommendationsScreen());

      case AppRoutes.taskDetail:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => TaskDetailScreen(
            taskId: args?.toString() ?? '',
          ),
        );

      case AppRoutes.calendar:
        return MaterialPageRoute(builder: (_) => const CalendarScreen());

      case AppRoutes.eventDetail:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => EventDetailScreen(
            eventId: args?.toString() ?? '',
          ),
        );

      case AppRoutes.actionLog:
        return MaterialPageRoute(builder: (_) => const ActionLogScreen());

      case AppRoutes.logDetail:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => LogDetailScreen(
            logId: args?.toString() ?? '',
          ),
        );

      case AppRoutes.support:
        return MaterialPageRoute(builder: (_) => const SupportScreen());

      case AppRoutes.faqDetail:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => FaqDetailScreen(
            faqId: args?.toString() ?? '',
          ),
        );

      // Profile Routes
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());

      case AppRoutes.editFarm:
        return MaterialPageRoute(builder: (_) => const EditFarmScreen());

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      // Notification Routes
      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      case AppRoutes.notificationDetail:
        final args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => NotificationDetailScreen(
            notificationId: args?.toString() ?? '',
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Route not found!'),
        ),
      ),
    );
  }
}
