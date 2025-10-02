import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../services/location_service.dart';
import '../services/text_to_speech_service.dart';
import '../services/notification_service.dart';
import '../services/storage_service.dart';
import '../services/auth_service.dart';
import '../services/voice_service.dart';
import '../services/offline_sync_service.dart';
import '../network/api_client.dart';

final GetIt sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    // External dependencies
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);

    final dio = Dio();
    sl.registerLazySingleton(() => dio);

    // Core services
    sl.registerLazySingleton<StorageService>(
      () => StorageServiceImpl(sl()),
    );

    sl.registerLazySingleton<LocationService>(
      () => LocationServiceImpl(),
    );

    sl.registerLazySingleton<TextToSpeechService>(
      () => TextToSpeechServiceImpl(),
    );

    sl.registerLazySingleton<NotificationService>(
      () => NotificationServiceImpl(),
    );

    sl.registerLazySingleton<AuthService>(
      () => AuthServiceImpl(sl()),
    );

    sl.registerLazySingleton<VoiceService>(
      () => VoiceServiceImpl(),
    );

    sl.registerLazySingleton<OfflineSyncService>(
      () => OfflineSyncServiceImpl(sl()),
    );

    // Network
    sl.registerLazySingleton<ApiClient>(
      () => ApiClient(sl()),
    );

    // Initialize services that need initialization
    await _initializeServices();
  }

  static Future<void> _initializeServices() async {
    await sl<LocationService>().initialize();
    await sl<TextToSpeechService>().initialize();
    await sl<NotificationService>().initialize();
    await sl<VoiceService>().initialize();
  }
}
