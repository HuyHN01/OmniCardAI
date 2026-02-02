import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omni_card_ai/core/services/groq_service.dart';
import 'package:omni_card_ai/core/services/ocr_service.dart';

class MagicScanState {
  final bool isProcessing;
  final String? statusMessage;
  final List<Map<String, String>>? successData; // Thêm biến này để chứa kết quả

  MagicScanState({
    this.isProcessing = false,
    this.statusMessage,
    this.successData,
  });
}

class MagicScanNotifier extends StateNotifier<MagicScanState> {
  final OcrService _ocrService = OcrService();
  final GroqService _groqService = GroqService();

  MagicScanNotifier() : super(MagicScanState());

  // XÓA tham số BuildContext context (Không cần nữa)
  Future<void> startMagicScan(int deckId) async { 
    try {
      // 1. Reset state cũ
      state = MagicScanState();

      final image = await _ocrService.pickImageFromCamera();
      if (image == null) return;

      state = MagicScanState(isProcessing: true, statusMessage: "Đang đọc văn bản...");

      final rawText = await _ocrService.extractTextFromImage(image.path);

      if (rawText.trim().length < 10) {
        throw Exception('Văn bản không đủ rõ ràng. Vui lòng thử lại.');
      }

      state = MagicScanState(isProcessing: true, statusMessage: "AI đang tạo thẻ...");

      final generatedCards = await _groqService.generateFlashcards(rawText);

      if (generatedCards.isEmpty) {
        throw Exception('AI không tìm thấy thuật ngữ nào.');
      }

      // 2. Thay vì push context, ta lưu dữ liệu vào State
      state = MagicScanState(
        isProcessing: false, 
        successData: generatedCards, // UI sẽ lắng nghe biến này để navigation
      );

    } catch (e) {
      state = MagicScanState(
        isProcessing: false,
        statusMessage: 'Error: $e',
      );
    }
  }
  
  // Hàm reset sau khi navigate xong để tránh navigate lặp lại
  void reset() {
    state = MagicScanState();
  }
}

final magicScanProvider = StateNotifierProvider<MagicScanNotifier, MagicScanState>((ref) {
  return MagicScanNotifier();
});