class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://api.nibaron.gov.bd/v1';
  static const String weatherBaseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String geocodingBaseUrl = 'https://api.openweathermap.org/geo/1.0';

  // API Endpoints
  static const String auth = '/auth';
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String verifyOtp = '$auth/verify-otp';
  static const String refreshToken = '$auth/refresh-token';
  static const String logout = '$auth/logout';

  // User endpoints
  static const String user = '/user';
  static const String profile = '$user/profile';
  static const String updateProfile = '$user/update';
  static const String deleteAccount = '$user/delete';

  // Farm endpoints
  static const String farm = '/farm';
  static const String farmProfile = '$farm/profile';
  static const String updateFarm = '$farm/update';
  static const String crops = '$farm/crops';
  static const String addCrop = '$farm/crops/add';
  static const String updateCrop = '$farm/crops/update';
  static const String deleteCrop = '$farm/crops/delete';

  // Weather endpoints
  static const String weather = '/weather';
  static const String currentWeather = '$weather/current';
  static const String forecast = '$weather/forecast';
  static const String weatherHistory = '$weather/history';

  // Hazard endpoints
  static const String hazards = '/hazards';
  static const String activeHazards = '$hazards/active';
  static const String hazardHistory = '$hazards/history';
  static const String hazardDetails = '$hazards/details';

  // Recommendation endpoints
  static const String recommendations = '/recommendations';
  static const String dailyRecommendations = '$recommendations/daily';
  static const String taskRecommendations = '$recommendations/tasks';
  static const String updateTaskStatus = '$recommendations/tasks/status';

  // Calendar endpoints
  static const String calendar = '/calendar';
  static const String events = '$calendar/events';
  static const String createEvent = '$calendar/events/create';
  static const String updateEvent = '$calendar/events/update';
  static const String deleteEvent = '$calendar/events/delete';

  // Action log endpoints
  static const String actionLog = '/action-log';
  static const String logHistory = '$actionLog/history';
  static const String createLog = '$actionLog/create';
  static const String updateLog = '$actionLog/update';

  // Notification endpoints
  static const String notifications = '/notifications';
  static const String notificationHistory = '$notifications/history';
  static const String markAsRead = '$notifications/read';
  static const String notificationSettings = '$notifications/settings';

  // Support endpoints
  static const String support = '/support';
  static const String faq = '$support/faq';
  static const String contactInfo = '$support/contact';
  static const String feedback = '$support/feedback';

  // File upload endpoints
  static const String upload = '/upload';
  static const String uploadImage = '$upload/image';
  static const String uploadDocument = '$upload/document';

  // External API endpoints (OpenWeatherMap)
  static const String owmCurrent = '/weather';
  static const String owmForecast = '/forecast';
  static const String owmOneCall = '/onecall';
  static const String owmGeocode = '/direct';

  // API Keys (These should be stored securely in environment variables)
  static const String owmApiKey = 'YOUR_OPENWEATHER_API_KEY';
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';

  // Request headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> authHeaders(String token) => {
    ...defaultHeaders,
    'Authorization': 'Bearer $token',
  };
}
