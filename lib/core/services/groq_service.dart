import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GroqService {
  static final String _apiKey = dotenv.env['GROQ_API_KEY'] ?? '';
  static const String _baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';

  static const systemPrompt = '''
    Role: You are an expert EdTech AI specializing in Flashcard creation.
    Goal: Extract atomic learning concepts from USER_INPUT into a STRICT JSON OBJECT.

    ### CRITICAL OUTPUT RULES:
    1. You MUST return a valid JSON Object.
    2. The root object MUST have exactly one key: "flashcards".
    3. The value of "flashcards" must be an Array of objects.
    4. DO NOT write any text, markdown, or explanations outside the JSON.
    5. DO NOT add tags like [flashcard]. Just the raw JSON string.

    ### DATA STRUCTURE:
    {
      "flashcards": [
        {
          "front": "Term (keep original language)",
          "back": "Definition (translate ONLY if it is a vocab list)",
          "front_lang": "Language Code (e.g., en-US or vi-VN)",
          "back_lang": "Language Code (e.g., en-US or vi-VN)"
        }
      ]
    }

    ### EXAMPLES (Study these patterns carefully):

    Example 1 (Vocabulary List - English Term / Vietnamese Def):
    Input: "Quantum Superposition: Trạng thái hệ lượng tử tồn tại đồng thời..."
    Output:
    { "flashcards": [ { "front": "Quantum Superposition", "back": "Trạng thái hệ lượng tử tồn tại đồng thời trong nhiều cấu hình.", "front_lang": "en-US", "back_lang": "vi-VN" } ] }

    Example 2 (Pure Vietnamese - Context/History):
    Input: "Chiến tranh lạnh là giai đoạn căng thẳng địa chính trị..."
    Output:
    { "flashcards": [ { "front": "Chiến tranh lạnh là gì?", "back": "Giai đoạn căng thẳng địa chính trị giữa Liên Xô và Mỹ sau CTTG 2.", "front_lang": "vi-VN", "back_lang": "vi-VN" } ] }

    Example 3 (Technical English - Keep English/English):
    Input: "Widget - The basic building block of Flutter UI."
    Output:
    { "flashcards": [ { "front": "Widget", "back": "The basic building block of Flutter UI.", "front_lang": "en-US", "back_lang": "en-US" } ] }

    ### LOGIC & ALGORITHM:
    1. Detect Structure:
      - IF input is a list (Term: Definition): Split by separator. KEEP "front" CLEAN (Do NOT add "What is?" or "là gì?").
      - IF input is a paragraph: Extract key concept -> Explanation. Add question phrasing if necessary.
    2. Detect Language Context:
      - English Technical Term -> Keep "front" & "back" in English (en-US).
      - English Vocabulary Learning -> "front" in English, "back" in Vietnamese.
      - Vietnamese Content -> Keep both in Vietnamese (vi-VN).

    Now, process the USER_INPUT.
    ''';
  

  Future<List<Map<String, String>>> generateFlashcards(String userText) async {
    if (_apiKey.isEmpty) {
      throw Exception('Missing GROQ_API_KEY');
    }

    try {
      final response = await http
          .post(
            Uri.parse(_baseUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_apiKey',
            },
            body: jsonEncode({
              "model": "llama-3.3-70b-versatile", 
              "messages": [
                {"role": "system", "content": systemPrompt},
                {"role": "user", "content": userText},
              ],
              "response_format": {"type": "json_object"}, 
              "temperature": 0.1, 
              "top_p": 0.9,
              "max_tokens": 1500,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Decode UTF-8
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        String content = data['choices'][0]['message']['content'];

        debugPrint('RAW MODEL OUTPUT:\n$content');

        // Parse với logic mới (Safety Net cho JSON Object)
        final List<Map<String, dynamic>> rawList = _parseGroqJsonObject(content);

        return rawList.map((item) {
          return {
            'term': item['front'].toString(),
            'definition': item['back'].toString(),
            'frontLanguage': item['front_lang'].toString(),
            'backLanguage': item['back_lang'].toString(),
          };
        }).toList();

      } else {
        throw Exception('Failed to load from Groq: ${response.body}');
      }
    } catch (e, stackTrace) {
      debugPrint("Error details: $stackTrace");
      throw Exception('Error calling Groq API: $e');
    }
  }

  List<Map<String, dynamic>> _parseGroqJsonObject(String rawContent) {
    try {
      // 1. Vệ sinh sơ bộ (dù JSON Mode đã khá sạch, nhưng cẩn tắc vô áy náy)
      String cleaned = rawContent.replaceAll(RegExp(r'```(?:json)?'), '').trim();
      
      // 2. Decode thẳng JSON (Vì JSON Mode đảm bảo trả về valid JSON)
      final decoded = jsonDecode(cleaned);

      // 3. Trích xuất mảng "flashcards"
      if (decoded is Map<String, dynamic> && decoded.containsKey('flashcards')) {
        final list = decoded['flashcards'];
        if (list is List) {
           // Validate từng item trong list
           final List<Map<String, dynamic>> result = [];
           for (var item in list) {
             if (item is Map<String, dynamic> && 
                 item.containsKey('front') && 
                 item.containsKey('back')) {
               result.add(item);
             }
           }
           return result;
        }
      }
      
      throw const FormatException('JSON does not contain "flashcards" array');

    } catch (e) {
      debugPrint('JSON Parse Logic Error: $e');
      // Fallback: Nếu model lỡ quên wrapper object (hiếm), thử parse như array cũ
      try {
         final match = RegExp(r'\[.*\]', dotAll: true).firstMatch(rawContent);
         if (match != null) {
           final list = jsonDecode(match.group(0)!);
           return List<Map<String, dynamic>>.from(list);
         }
      } catch (_) {}
      
      throw FormatException('Critical JSON parsing failure: $e');
    }
  }
}
