import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  TtsService() {
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    // Chờ engine khởi động
    await _flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> speak(String text, String languageCode) async {
    if (text.isEmpty) return;

    String language = _normalizeLanguage(languageCode);

    try {
      //Stop sound cũ nếu đang nói
      await _flutterTts.stop();

      await _flutterTts.setLanguage(language);
      await _flutterTts.speak(text);
    } 
    catch (e) {
      print('TTS Error: $e');
    }
  }

  // Hàm huỷ tài nguyên 
  void dispose() { 
    _flutterTts.stop();
  }

  String _normalizeLanguage(String rawLang) {
    if (rawLang.toLowerCase().startsWith('en')) return 'en-US';
    if (rawLang.toLowerCase().startsWith('vi')) return 'vi-VN';
    // Mặc định fallback
    return 'vi-VN'; 
  }
}