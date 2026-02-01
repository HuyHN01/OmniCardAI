import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GroqService {
  static final String _apiKey = dotenv.env['GROQ_API_KEY'] ?? '';
  static const String _baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';

  Future<List<Map<String, String>>> generateFlashcards(String userText) async {
    if (_apiKey.isEmpty) {
      throw Exception('Missing GROQ_API_KEY');
    }
    
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          "model": "llama-3.1-8b-instant",
          "messages": [
            {
              "role": "system",
              "content": """
                You are an expert EdTech Content Creator specializing in Spaced Repetition systems (SM-2).

                TASK:
                Analyze the provided text and generate atomic flashcards following the Minimum Information Principle.

                For each flashcard:
                - "front": short term or question.
                - "back": concise explanation or definition.
                - Automatically detect and assign language codes.

                If the text is for English learning, prefer:
                - front = English
                - back = Vietnamese.

                OUTPUT FORMAT (STRICT JSON):
                Return ONLY a valid raw JSON array.
                No Markdown. No explanations. No text before or after JSON.

                Each object must contain exactly:
                "front", "back", "front_lang", "back_lang".

                Language codes must be exactly:
                - "en-US"
                - "vi-VN"

                RULES:
                - Generate 5–15 cards depending on text length.
                - "front" must be short when possible.
                - "back" must be 1 concise sentence or short phrase.
                - For technical topics, keep both sides in the same language unless translation clearly improves learning.
                - If the input is too short, unclear, or nonsensical, return [].
                - Any output that is not valid JSON is strictly forbidden.

                EXAMPLE:
                [
                  {
                    "front": "Photosynthesis",
                    "back": "Quá trình thực vật chuyển đổi ánh sáng mặt trời thành năng lượng hóa học.",
                    "front_lang": "en-US",
                    "back_lang": "vi-VN"
                  }
                ]

              """,
            },
            {"role": "user", "content": userText},
          ],
          "temperature": 0.2, // Giữ nhiệt độ thấp để AI trả về đúng định dạng
          "top_p": 0.9,
          "max_tokens": 1500,
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Xử lý dữ liệu trả về (UTF-8 decode để tránh lỗi font tiếng Việt)
        final data = jsonDecode(utf8.decode(response.bodyBytes));

        String content = data['choices'][0]['message']['content'];

        // Vệ sinh dữ liệu: Đôi khi Llama vẫn trả về markdown ```json ... ```
        content = content.replaceAll(RegExp(r'```(?:json)?'), '').trim();

        // Parse JSON String thành List Map
        final List<dynamic> jsonList = jsonDecode(content);

        if (jsonList.any((e) =>
          e['front'] == null ||
          e['back'] == null ||
          e['front_lang'] == null ||
          e['back_lang'] == null)) {
            throw Exception('Invalid flashcard schema');
          } 

        return jsonList
            .map(
              (item) => {
                'term': item['front'].toString(),
                'definition': item['back'].toString(),
                'frontLanguage': item['front_lang'].toString(),
                'backLanguage': item['back_lang'].toString(),
              },
            )
            .toList();
      } else {
        throw Exception('Failed to load from Groq: ${response.body}');
      }
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      throw Exception('Error calling Groq API: $e');
    }
  }
}
