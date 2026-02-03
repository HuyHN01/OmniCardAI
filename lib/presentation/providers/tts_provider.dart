import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/core/services/unified_tts_service.dart';

// Dòng này cần thiết để riverpod_generator hoạt động
part 'tts_provider.g.dart';

// Singleton cho Unified Service
// keepAlive: true -> Giống Provider thường (không autoDispose), giúp Service sống suốt vòng đời App.
@Riverpod(keepAlive: true)
UnifiedTtsService ttsService(Ref ref) {
  return UnifiedTtsService();
}