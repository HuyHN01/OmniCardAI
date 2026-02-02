import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/core/services/groq_service.dart';
import 'package:omni_card_ai/core/services/ocr_service.dart';

// Dòng này cần thiết để riverpod_generator hoạt động
part 'magic_scan_provider.g.dart';

// --- STATE CLASS (Giữ nguyên) ---
class MagicScanState {
  final bool isProcessing;
  final String? statusMessage;
  final List<Map<String, String>>? successData;

  MagicScanState({
    this.isProcessing = false,
    this.statusMessage,
    this.successData,
  });
}

// --- NOTIFIER (Chuyển sang @riverpod) ---
@riverpod
class MagicScan extends _$MagicScan {
  final OcrService _ocrService = OcrService();
  final GroqService _groqService = GroqService();

  @override
  MagicScanState build() {
    return MagicScanState(); // Khởi tạo state ban đầu
  }

  // Logic giữ nguyên 100%
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
        successData: generatedCards,
      );

    } catch (e) {
      state = MagicScanState(
        isProcessing: false,
        statusMessage: 'Error: $e',
      );
    }
  }

  // Hàm reset sau khi navigate xong
  void reset() {
    state = MagicScanState();
  }
}