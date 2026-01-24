// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deckDetailHash() => r'6999ea3240d8cc3373c97774a4739b9509d3b4b8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [deckDetail].
@ProviderFor(deckDetail)
const deckDetailProvider = DeckDetailFamily();

/// See also [deckDetail].
class DeckDetailFamily extends Family<AsyncValue<DeckModel?>> {
  /// See also [deckDetail].
  const DeckDetailFamily();

  /// See also [deckDetail].
  DeckDetailProvider call(int deckId) {
    return DeckDetailProvider(deckId);
  }

  @override
  DeckDetailProvider getProviderOverride(
    covariant DeckDetailProvider provider,
  ) {
    return call(provider.deckId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deckDetailProvider';
}

/// See also [deckDetail].
class DeckDetailProvider extends AutoDisposeStreamProvider<DeckModel?> {
  /// See also [deckDetail].
  DeckDetailProvider(int deckId)
    : this._internal(
        (ref) => deckDetail(ref as DeckDetailRef, deckId),
        from: deckDetailProvider,
        name: r'deckDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$deckDetailHash,
        dependencies: DeckDetailFamily._dependencies,
        allTransitiveDependencies: DeckDetailFamily._allTransitiveDependencies,
        deckId: deckId,
      );

  DeckDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.deckId,
  }) : super.internal();

  final int deckId;

  @override
  Override overrideWith(
    Stream<DeckModel?> Function(DeckDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeckDetailProvider._internal(
        (ref) => create(ref as DeckDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        deckId: deckId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<DeckModel?> createElement() {
    return _DeckDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeckDetailProvider && other.deckId == deckId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeckDetailRef on AutoDisposeStreamProviderRef<DeckModel?> {
  /// The parameter `deckId` of this provider.
  int get deckId;
}

class _DeckDetailProviderElement
    extends AutoDisposeStreamProviderElement<DeckModel?>
    with DeckDetailRef {
  _DeckDetailProviderElement(super.provider);

  @override
  int get deckId => (origin as DeckDetailProvider).deckId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
