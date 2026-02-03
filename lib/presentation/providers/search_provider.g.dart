// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchQuery)
const searchQueryProvider = SearchQueryProvider._();

final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  const SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'c20c8b67cdf9a8c8820d422de83c580e88655dcd';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(searchResult)
const searchResultProvider = SearchResultProvider._();

final class SearchResultProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DeckModel>>,
          List<DeckModel>,
          Stream<List<DeckModel>>
        >
    with $FutureModifier<List<DeckModel>>, $StreamProvider<List<DeckModel>> {
  const SearchResultProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchResultProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchResultHash();

  @$internal
  @override
  $StreamProviderElement<List<DeckModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DeckModel>> create(Ref ref) {
    return searchResult(ref);
  }
}

String _$searchResultHash() => r'cb119e3968f0d7f2a4c4fb162fe55912cff59a50';
