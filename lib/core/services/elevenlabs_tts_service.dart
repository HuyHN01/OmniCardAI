import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ElevenlabsTtsService {
    static const String _baseUrl = 'https://api.elevenlabs.io/v1/text-to-speech';
    static final _apiKey = dotenv.env['ELEVENS_LAB_API'] ?? '';
    
    // static final RegExp _vietnameseRegex = RegExp(
    //     r'[àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ'
    //     r'ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ]',
    //     unicode: true,
    // );

    static const vietnameseVoiceId = 'EXAVITQu4vr4xnSDxMaL';
    static const englishVoiceId = 'hpp4J3VqNfWAUOO0d1Us';
    static const vietnameseModel = 'eleven_turbo_v2_5';
    static const englishModel = 'eleven_turbo_v2_5';

    Future<String?> createTTS(String text, String languageCode) async {
        if (_apiKey.isEmpty) {
            debugPrint('Eleven Labs API key is not set.');
            return null;
        }

        final config = _getVoiceAndModel(languageCode);

        final audioFile = await _getDocumentFile(text, config['voiceId']!, config['model']!);

        if (await audioFile.exists()) {
          debugPrint('Using cached TTS audio: ${audioFile.path}');
          return audioFile.path;
        }


        final url = '$_baseUrl/${config['voiceId']}';

        try{
            final response = await http.post(
                Uri.parse(url),
                headers: {
                    'xi-api-key': _apiKey,
                    'Content-Type': 'application/json',
                },
                body: jsonEncode({
                    'text': text,
                    'model_id': config['model'],
                    'voice_settings': {
                        'stability': 0.5,
                        'similarity_boost': 0.75,
                    },
                }),
            ).timeout(const Duration(seconds: 30));

            if(response.statusCode == 200) {
                final bytes = response.bodyBytes;
                await audioFile.writeAsBytes(bytes, flush: true);
                return audioFile.path;
            }
            else {
                debugPrint('Eleven Labs TTS Error: ${response.statusCode} - ${response.body}');
                return null;
            }
        }
        catch (e) {
            debugPrint('Eleven Labs TTS Exception: $e');
            return null;
        }
    }

    Map<String, String> _getVoiceAndModel(String languageCode) {
        if (languageCode.toLowerCase().startsWith('en')) {
            return {
                'voiceId': englishVoiceId,
                'model': englishModel,
            };
        } else {
            return {
                'voiceId': vietnameseVoiceId,
                'model': vietnameseModel,
            };
        }
    }

    Future<File> _getDocumentFile(String text, String voiceId, String model) async {
        final documentDir = await getApplicationDocumentsDirectory();
        final bytes = utf8.encode('$text-$voiceId-$model');
        final digest = md5.convert(bytes).toString();

        final dir = Directory('${documentDir.path}/tts_cache');

        if (!await dir.exists()) {
            await dir.create(recursive: true);
        }

        final filePath = '${dir.path}/$digest.mp3';

        return File(filePath);
    }

    
}