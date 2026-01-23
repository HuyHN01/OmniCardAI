import 'package:flutter/material.dart';
import 'package:omni_card_ai/presentation/create_card/widgets/card_form_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/data/models/card_model.dart';
import 'package:omni_card_ai/presentation/providers/repository_provider.dart';

part 'batch_card_provider.g.dart';

@riverpod
class BatchCardNotifier extends _$BatchCardNotifier {
  @override
  void build() {}

  Future<void> saveAll({
    required int deckId,
    required List<CardFormModel> forms,
  }) async {
    // 1. Chuyển đổi dữ liệu (Mapping)
    final newCards = forms.map((f) => CardModel()
      ..term = f.frontController.text.trim()
      ..definition = f.backController.text.trim()
      ..stability = 0
      ..difficulty = 0
      ..isDirty = true
      ..updatedAt = DateTime.now()
    ).toList();

    // 2. Gọi Repository để lưu hàng loạt
    await ref.read(deckRepositoryProvider).addCardsToDeck(deckId, newCards);
  }
}