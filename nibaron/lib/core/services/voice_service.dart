import 'package:speech_to_text/speech_to_text.dart';

abstract class VoiceService {
  Future<void> initialize();
  Future<void> startListening({
    required Function(String) onResult,
    Function(String)? onError,
    String? language,
  });
  Future<void> stopListening();
  Future<bool> get isListening;
  Future<bool> get isAvailable;
  Future<List<String>> getAvailableLanguages();
}

class VoiceServiceImpl implements VoiceService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _isInitialized = await _speechToText.initialize(
        onError: (error) => print('Speech recognition error: $error'),
        onStatus: (status) => print('Speech recognition status: $status'),
      );

      if (_isInitialized) {
        print('Voice Service initialized successfully');
      } else {
        print('Voice Service initialization failed');
      }
    } catch (e) {
      print('Error initializing voice service: $e');
    }
  }

  @override
  Future<void> startListening({
    required Function(String) onResult,
    Function(String)? onError,
    String? language,
  }) async {
    if (!_isInitialized) await initialize();

    if (!_isInitialized || !await isAvailable) {
      onError?.call('Voice recognition not available');
      return;
    }

    try {
      await _speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            onResult(result.recognizedWords);
          }
        },
        localeId: language ?? 'bn-BD',
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: false,
      );
    } catch (e) {
      onError?.call('Error starting voice recognition: $e');
    }
  }

  @override
  Future<void> stopListening() async {
    try {
      await _speechToText.stop();
    } catch (e) {
      print('Error stopping voice recognition: $e');
    }
  }

  @override
  Future<bool> get isListening async {
    return _speechToText.isListening;
  }

  @override
  Future<bool> get isAvailable async {
    return _speechToText.isAvailable;
  }

  @override
  Future<List<String>> getAvailableLanguages() async {
    if (!_isInitialized) await initialize();

    try {
      final locales = await _speechToText.locales();
      return locales.map((locale) => locale.localeId).toList();
    } catch (e) {
      print('Error getting available languages: $e');
      return ['bn-BD', 'en-US'];
    }
  }
}
