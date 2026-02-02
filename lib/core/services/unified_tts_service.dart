import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:omni_card_ai/core/services/elevenlabs_tts_service.dart';


class UnifiedTtsService {
  final ElevenlabsTtsService _elevenLabsService;
  final FlutterTts _flutterTts;
  final AudioPlayer _audioPlayer;

  UnifiedTtsService()
      : _elevenLabsService = ElevenlabsTtsService(),
        _flutterTts = FlutterTts(),
        _audioPlayer = AudioPlayer() {
          _initFlutterTts();
  }

  void _initFlutterTts() async {
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    
    await _flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playback,
        [
          IosTextToSpeechAudioCategoryOptions.defaultToSpeaker
        ]
    );
  }

  bool _isSpeaking = false;
  Future<void> speak(String text, String languageCode) async {
    if (text.trim().isEmpty) return;

    if (_isSpeaking) return;
    _isSpeaking = true;

    await stop();

    try {
      final highQualityAudioPath = await _elevenLabsService.createTTS(text, languageCode);

      if(highQualityAudioPath != null) {
        debugPrint('Playing high-quality TTS audio from Eleven Labs.');
        await _audioPlayer.play(DeviceFileSource(highQualityAudioPath));
      }
      else {
        debugPrint('Falling back to Flutter TTS.');
        await _speakOffline(text, languageCode);
      }
    }
    catch (e) {
      debugPrint('Unified TTS Error: $e');
    }
    finally {
      _isSpeaking = false;
    }
  }

  Future<void> stop() async {
    await _flutterTts.stop();
    await _audioPlayer.stop();
  }

  Future<void> _speakOffline(String text, String languageCode) async {
    String language = _normalizeLanguage(languageCode);

    final available = await _flutterTts.isLanguageAvailable(language);

    if (!available) {
      debugPrint('Language $language not available for offline TTS');
      return;
    }

    try {
      await _flutterTts.setLanguage(language);
      await _flutterTts.speak(text);
    } 
    catch (e) {
      debugPrint('TTS Error: $e');
    }
  }

  String _normalizeLanguage(String rawLang) {
    if (rawLang.toLowerCase().startsWith('en')) return 'en-US';
    if (rawLang.toLowerCase().startsWith('vi')) return 'vi-VN';
    return 'vi-VN'; 
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
    await _flutterTts.stop();
  }
}