// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isar)
const isarProvider = IsarProvider._();

final class IsarProvider extends $FunctionalProvider<Isar, Isar, Isar>
    with $Provider<Isar> {
  const IsarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isarHash();

  @$internal
  @override
  $ProviderElement<Isar> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Isar create(Ref ref) {
    return isar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Isar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Isar>(value),
    );
  }
}

String _$isarHash() => r'd4b68488fdc45d47b27274e022944042abfa9385';

@ProviderFor(deckRepository)
const deckRepositoryProvider = DeckRepositoryProvider._();

final class DeckRepositoryProvider
    extends
        $FunctionalProvider<IDeckRepository, IDeckRepository, IDeckRepository>
    with $Provider<IDeckRepository> {
  const DeckRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deckRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deckRepositoryHash();

  @$internal
  @override
  $ProviderElement<IDeckRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IDeckRepository create(Ref ref) {
    return deckRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IDeckRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IDeckRepository>(value),
    );
  }
}

String _$deckRepositoryHash() => r'f254b71afd9cfc2c8511e399406f70248c4fb0f2';
