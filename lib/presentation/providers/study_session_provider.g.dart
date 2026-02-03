// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StudySession)
const studySessionProvider = StudySessionFamily._();

final class StudySessionProvider
    extends $NotifierProvider<StudySession, StudySessionState> {
  const StudySessionProvider._({
    required StudySessionFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'studySessionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$studySessionHash();

  @override
  String toString() {
    return r'studySessionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  StudySession create() => StudySession();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StudySessionState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StudySessionState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is StudySessionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$studySessionHash() => r'c6955ef76cae0028edb19bf8e228229427c4fb50';

final class StudySessionFamily extends $Family
    with
        $ClassFamilyOverride<
          StudySession,
          StudySessionState,
          StudySessionState,
          StudySessionState,
          int
        > {
  const StudySessionFamily._()
    : super(
        retry: null,
        name: r'studySessionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StudySessionProvider call(int deckId) =>
      StudySessionProvider._(argument: deckId, from: this);

  @override
  String toString() => r'studySessionProvider';
}

abstract class _$StudySession extends $Notifier<StudySessionState> {
  late final _$args = ref.$arg as int;
  int get deckId => _$args;

  StudySessionState build(int deckId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<StudySessionState, StudySessionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StudySessionState, StudySessionState>,
              StudySessionState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
