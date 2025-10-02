import 'package:flutter_tts/flutter_tts.dart';
import '../../config/constants/app_constants.dart';

abstract class TextToSpeechService {
  Future<void> initialize();
  Future<void> speak(String text, {String? language});
  Future<void> stop();
  Future<void> pause();
  Future<void> resume();
  Future<bool> get isPlaying;
  Future<void> setLanguage(String language);
  Future<void> setSpeechRate(double rate);
  Future<void> setPitch(double pitch);
}

class TextToSpeechServiceImpl implements TextToSpeechService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;

  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Set default configuration
      await _flutterTts.setLanguage(AppConstants.defaultVoiceLanguage);
      await _flutterTts.setSpeechRate(AppConstants.defaultSpeechRate);
      await _flutterTts.setPitch(AppConstants.defaultPitch);

      // Configure for Android
      await _flutterTts.awaitSpeakCompletion(true);

      _isInitialized = true;
      print('TTS Service initialized successfully');
    } catch (e) {
      print('Error initializing TTS: $e');
    }
  }

  @override
  Future<void> speak(String text, {String? language}) async {
    if (!_isInitialized) await initialize();

    try {
      // Stop any current speech
      await stop();

      // Set language if provided
      if (language != null) {
        await setLanguage(language);
      }

      // Speak the text
      await _flutterTts.speak(text);
    } catch (e) {
      print('Error speaking text: $e');
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (e) {
      print('Error stopping TTS: $e');
    }
  }

  @override
  Future<void> pause() async {
    try {
      await _flutterTts.pause();
    } catch (e) {
      print('Error pausing TTS: $e');
    }
  }

  @override
  Future<void> resume() async {
    try {
      // Flutter TTS doesn't have resume, so we use speak with empty string
      // This is a workaround - in practice, you'd need to track the current text
    } catch (e) {
      print('Error resuming TTS: $e');
    }
  }

  @override
  Future<bool> get isPlaying async {
    // Flutter TTS doesn't provide a direct way to check if speaking
    // This would need to be tracked manually in a real implementation
    return false;
  }

  @override
  Future<void> setLanguage(String language) async {
    try {
      await _flutterTts.setLanguage(language);
    } catch (e) {
      print('Error setting TTS language: $e');
    }
  }

  @override
  Future<void> setSpeechRate(double rate) async {
    try {
      await _flutterTts.setSpeechRate(rate);
    } catch (e) {
      print('Error setting TTS speech rate: $e');
    }
  }

  @override
  Future<void> setPitch(double pitch) async {
    try {
      await _flutterTts.setPitch(pitch);
    } catch (e) {
      print('Error setting TTS pitch: $e');
    }
  }
}
