import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GroqService {
  static final String _apiKey = dotenv.env['GROQ_API_KEY'] ?? '';
  static const String _baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';

  Future<List<Map<String, String>>> generateFlashcards(String userText) async {
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
                You are a strict JSON generator.

                TASK:
                Extract the most important concepts from the user's text and create flashcards.

                RULES:
                - Output ONLY a valid raw JSON array.
                - Do NOT include Markdown, comments, or explanations.
                - Do NOT include any text before or after the JSON.
                - Each item must contain exactly two keys: "term" and "definition".
                - Definitions must be concise (1–2 sentences).
                - Generate 5–15 flashcards depending on text length.
                - Language: Vietnamese unless the input is clearly English.
                - If the input does not contain enough meaningful information, return [].

                EXAMPLE OUTPUT:
                [
                  {"term":"ADN","definition":"Axit deoxyribonucleic"},
                  {"term":"ATP","definition":"Phân tử cung cấp năng lượng cho tế bào"}
                ]

                Any output that is not valid JSON is strictly forbidden.
              """,
            },
            {"role": "user", "content": userText},
          ],
          "temperature": 0.2,// Giữ nhiệt độ thấp để AI trả về đúng định dạng
          "top_p": 0.9, 
          "max_tokens": 1500,
        }),
      );
      

      if (response.statusCode == 200) {
        // Xử lý dữ liệu trả về (UTF-8 decode để tránh lỗi font tiếng Việt)
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        debugPrint(data.toString());
        
        String content = data['choices'][0]['message']['content'];

        // Vệ sinh dữ liệu: Đôi khi Llama vẫn trả về markdown ```json ... ```
        content = content
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();

        // Parse JSON String thành List Map
        final List<dynamic> jsonList = jsonDecode(content);

        return jsonList
            .map(
              (item) => {
                'term': item['term'].toString(),
                'definition': item['definition'].toString(),
              },
            )
            .toList();
      } else {
        throw Exception('Failed to load from Groq: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error calling Groq API: $e');
    }
  }
}
