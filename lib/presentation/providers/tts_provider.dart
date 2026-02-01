import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/core/services/tts_service.dart';

part 'tts_provider.g.dart';

@riverpod
TtsService ttsService(TtsServiceRef ref) {
  final service = TtsService();

  ref.onDispose(() {
    service.dispose();
  });

  return service;
}