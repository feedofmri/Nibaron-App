class AssetConstants {
  // Images
  static const String _imagesPath = 'assets/images';

  // Logo
  static const String logo = '$_imagesPath/logo/logo.png';
  static const String logo2x = '$_imagesPath/logo/logo@2x.png';
  static const String logo3x = '$_imagesPath/logo/logo@3x.png';

  // App Icon
  static const String nibaronIcon = '$_imagesPath/nibaron_icon.png';

  // Onboarding
  static const String onboarding1 = '$_imagesPath/onboarding/onboarding_1.png';
  static const String onboarding2 = '$_imagesPath/onboarding/onboarding_2.png';
  static const String onboarding3 = '$_imagesPath/onboarding/onboarding_3.png';

  // Illustrations
  static const String emptyState = '$_imagesPath/illustrations/empty_state.png';
  static const String errorState = '$_imagesPath/illustrations/error_state.png';
  static const String noInternet = '$_imagesPath/illustrations/no_internet.png';
  static const String success = '$_imagesPath/illustrations/success.png';

  // Placeholders
  static const String cropPlaceholder = '$_imagesPath/placeholders/crop_placeholder.png';
  static const String profilePlaceholder = '$_imagesPath/placeholders/profile_placeholder.png';

  // Icons
  static const String _iconsPath = 'assets/icons';

  // Weather Icons
  static const String sunnyIcon = '$_iconsPath/weather/sunny.svg';
  static const String cloudyIcon = '$_iconsPath/weather/cloudy.svg';
  static const String rainyIcon = '$_iconsPath/weather/rainy.svg';
  static const String stormIcon = '$_iconsPath/weather/storm.svg';
  static const String floodIcon = '$_iconsPath/weather/flood.svg';

  // Task Icons
  static const String irrigationIcon = '$_iconsPath/tasks/irrigation.svg';
  static const String fertilizerIcon = '$_iconsPath/tasks/fertilizer.svg';
  static const String pestControlIcon = '$_iconsPath/tasks/pest_control.svg';
  static const String harvestIcon = '$_iconsPath/tasks/harvest.svg';

  // Crop Icons
  static const String riceIcon = '$_iconsPath/crops/rice.svg';
  static const String wheatIcon = '$_iconsPath/crops/wheat.svg';
  static const String cornIcon = '$_iconsPath/crops/corn.svg';
  static const String vegetablesIcon = '$_iconsPath/crops/vegetables.svg';

  // Animations
  static const String _animationsPath = 'assets/animations';

  // Lottie Animations
  static const String loadingAnimation = '$_animationsPath/lottie/loading.json';
  static const String successAnimation = '$_animationsPath/lottie/success.json';
  static const String errorAnimation = '$_animationsPath/lottie/error.json';
  static const String weatherSunnyAnimation = '$_animationsPath/lottie/weather_sunny.json';
  static const String weatherRainAnimation = '$_animationsPath/lottie/weather_rain.json';
  static const String weatherCloudyAnimation = '$_animationsPath/lottie/weather_cloudy.json';
  static const String weatherStormAnimation = '$_animationsPath/lottie/weather_storm.json';
  static const String splashAnimation = '$_animationsPath/lottie/splash.json';

  // Helper method to get weather icon based on condition
  static String getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return sunnyIcon;
      case 'cloudy':
      case 'partly_cloudy':
        return cloudyIcon;
      case 'rainy':
      case 'rain':
        return rainyIcon;
      case 'stormy':
      case 'thunderstorm':
        return stormIcon;
      case 'flood':
        return floodIcon;
      default:
        return sunnyIcon;
    }
  }

  // Helper method to get weather animation based on condition
  static String getWeatherAnimation(String condition) {
    switch (condition.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return weatherSunnyAnimation;
      case 'cloudy':
      case 'partly_cloudy':
        return weatherCloudyAnimation;
      case 'rainy':
      case 'rain':
        return weatherRainAnimation;
      case 'stormy':
      case 'thunderstorm':
        return weatherStormAnimation;
      default:
        return weatherSunnyAnimation;
    }
  }

  // Helper method to get task icon based on type
  static String getTaskIcon(String taskType) {
    switch (taskType.toLowerCase()) {
      case 'irrigation':
        return irrigationIcon;
      case 'fertilizer':
        return fertilizerIcon;
      case 'pest_control':
        return pestControlIcon;
      case 'harvest':
        return harvestIcon;
      default:
        return irrigationIcon;
    }
  }

  // Helper method to get crop icon based on type
  static String getCropIcon(String cropType) {
    switch (cropType.toLowerCase()) {
      case 'rice':
        return riceIcon;
      case 'wheat':
        return wheatIcon;
      case 'corn':
        return cornIcon;
      default:
        return vegetablesIcon;
    }
  }
}
