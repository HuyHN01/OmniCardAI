import 'package:isar_community/isar.dart';
import 'package:omni_card_ai/domain/repositories/deck_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:omni_card_ai/domain/repositories/deck_repository.dart';

part 'repository_provider.g.dart';

// 1. Provider cho Isar instance (sẽ được khởi tạo ở main)
@riverpod
Isar isar(Ref ref) {
  throw UnimplementedError('Phải override isarProvider trong ProviderScope ở main.dart');
}

// 2. Provider cho DeckRepository
@riverpod
IDeckRepository deckRepository(Ref ref) {
  final isar = ref.watch(isarProvider);
  return DeckRepositoryImpl(isar);
}