// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magic_scan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MagicScan)
const magicScanProvider = MagicScanProvider._();

final class MagicScanProvider
    extends $NotifierProvider<MagicScan, MagicScanState> {
  const MagicScanProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'magicScanProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$magicScanHash();

  @$internal
  @override
  MagicScan create() => MagicScan();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MagicScanState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MagicScanState>(value),
    );
  }
}

String _$magicScanHash() => r'1e8e5a4ea4f70108621f8ea241d6b4f7d64a8f8d';

abstract class _$MagicScan extends $Notifier<MagicScanState> {
  MagicScanState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MagicScanState, MagicScanState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MagicScanState, MagicScanState>,
              MagicScanState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
