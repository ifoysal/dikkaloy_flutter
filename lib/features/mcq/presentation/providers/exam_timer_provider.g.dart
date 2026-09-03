// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exam_timer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$examTimerHash() => r'f5c3923adf698a6914359b522089fb45ae6836df';

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

abstract class _$ExamTimer extends BuildlessAutoDisposeNotifier<int> {
  late final int seconds;

  int build(
    int seconds,
  );
}

/// See also [ExamTimer].
@ProviderFor(ExamTimer)
const examTimerProvider = ExamTimerFamily();

/// See also [ExamTimer].
class ExamTimerFamily extends Family<int> {
  /// See also [ExamTimer].
  const ExamTimerFamily();

  /// See also [ExamTimer].
  ExamTimerProvider call(
    int seconds,
  ) {
    return ExamTimerProvider(
      seconds,
    );
  }

  @override
  ExamTimerProvider getProviderOverride(
    covariant ExamTimerProvider provider,
  ) {
    return call(
      provider.seconds,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'examTimerProvider';
}

/// See also [ExamTimer].
class ExamTimerProvider
    extends AutoDisposeNotifierProviderImpl<ExamTimer, int> {
  /// See also [ExamTimer].
  ExamTimerProvider(
    int seconds,
  ) : this._internal(
          () => ExamTimer()..seconds = seconds,
          from: examTimerProvider,
          name: r'examTimerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$examTimerHash,
          dependencies: ExamTimerFamily._dependencies,
          allTransitiveDependencies: ExamTimerFamily._allTransitiveDependencies,
          seconds: seconds,
        );

  ExamTimerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.seconds,
  }) : super.internal();

  final int seconds;

  @override
  int runNotifierBuild(
    covariant ExamTimer notifier,
  ) {
    return notifier.build(
      seconds,
    );
  }

  @override
  Override overrideWith(ExamTimer Function() create) {
    return ProviderOverride(
      origin: this,
      override: ExamTimerProvider._internal(
        () => create()..seconds = seconds,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        seconds: seconds,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ExamTimer, int> createElement() {
    return _ExamTimerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExamTimerProvider && other.seconds == seconds;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, seconds.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExamTimerRef on AutoDisposeNotifierProviderRef<int> {
  /// The parameter `seconds` of this provider.
  int get seconds;
}

class _ExamTimerProviderElement
    extends AutoDisposeNotifierProviderElement<ExamTimer, int>
    with ExamTimerRef {
  _ExamTimerProviderElement(super.provider);

  @override
  int get seconds => (origin as ExamTimerProvider).seconds;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
