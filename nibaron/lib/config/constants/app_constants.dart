class AppConstants {
  // App Information
  static const String appName = 'Nibaron';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Predict. Prevent. Protect.';

  // Database
  static const String dbName = 'nibaron_db';
  static const int dbVersion = 1;

  // Shared Preferences Keys
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserId = 'user_id';
  static const String keyUserToken = 'user_token';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyIsFirstTime = 'is_first_time';
  static const String keyFarmData = 'farm_data';
  static const String keyNotificationSettings = 'notification_settings';

  // API Configuration
  static const int apiTimeout = 30; // seconds
  static const int maxRetries = 3;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Location
  static const double defaultLatitude = 23.6850;
  static const double defaultLongitude = 90.3563; // Dhaka, Bangladesh
  static const double locationAccuracy = 100.0; // meters

  // Voice & Audio
  static const double defaultSpeechRate = 0.5;
  static const double defaultPitch = 1.0;
  static const String defaultVoiceLanguage = 'bn-BD';

  // Animations
  static const int splashDuration = 3000; // milliseconds
  static const int animationDuration = 300; // milliseconds
  static const int longAnimationDuration = 600; // milliseconds

  // UI Constants
  static const double borderRadius = 8.0;
  static const double cardElevation = 2.0;
  static const double buttonHeight = 48.0;
  static const double inputFieldHeight = 56.0;

  // Weather Update Intervals
  static const int weatherUpdateInterval = 30; // minutes
  static const int hazardCheckInterval = 15; // minutes

  // Notification Types
  static const String notificationTypeWeather = 'weather';
  static const String notificationTypeHazard = 'hazard';
  static const String notificationTypeTask = 'task';
  static const String notificationTypeGeneral = 'general';

  // Task Categories
  static const String taskCategoryIrrigation = 'irrigation';
  static const String taskCategoryFertilizer = 'fertilizer';
  static const String taskCategoryPestControl = 'pest_control';
  static const String taskCategoryHarvest = 'harvest';
  static const String taskCategoryPlanting = 'planting';

  // Crop Types
  static const List<String> supportedCrops = [
    'rice',
    'wheat',
    'corn',
    'jute',
    'sugarcane',
    'potato',
    'onion',
    'garlic',
    'tomato',
    'eggplant',
  ];

  // Soil Types
  static const List<String> soilTypes = [
    'clay',
    'loam',
    'sandy',
    'silt',
    'mixed',
  ];

  // Weather Conditions
  static const String weatherSunny = 'sunny';
  static const String weatherCloudy = 'cloudy';
  static const String weatherRainy = 'rainy';
  static const String weatherStormy = 'stormy';
  static const String weatherFoggy = 'foggy';

  // Hazard Severity Levels
  static const String hazardLow = 'low';
  static const String hazardMedium = 'medium';
  static const String hazardHigh = 'high';
  static const String hazardCritical = 'critical';

  // File Upload
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png'];
}
