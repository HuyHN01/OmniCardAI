import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omni_card_ai/core/services/unified_tts_service.dart';

// Singleton cho Unified Service
final ttsServiceProvider = Provider<UnifiedTtsService>((ref) {
  return UnifiedTtsService();
});