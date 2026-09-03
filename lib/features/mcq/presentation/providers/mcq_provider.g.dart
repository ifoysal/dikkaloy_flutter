// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcq_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$questionsHash() => r'3a7498cc0856ece31c49c42e5f25102829f74061';

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

/// See also [questions].
@ProviderFor(questions)
const questionsProvider = QuestionsFamily();

/// See also [questions].
class QuestionsFamily extends Family<AsyncValue<List<Question>>> {
  /// See also [questions].
  const QuestionsFamily();

  /// See also [questions].
  QuestionsProvider call(
    int categoryId,
  ) {
    return QuestionsProvider(
      categoryId,
    );
  }

  @override
  QuestionsProvider getProviderOverride(
    covariant QuestionsProvider provider,
  ) {
    return call(
      provider.categoryId,
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
  String? get name => r'questionsProvider';
}

/// See also [questions].
class QuestionsProvider extends AutoDisposeFutureProvider<List<Question>> {
  /// See also [questions].
  QuestionsProvider(
    int categoryId,
  ) : this._internal(
          (ref) => questions(
            ref as QuestionsRef,
            categoryId,
          ),
          from: questionsProvider,
          name: r'questionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$questionsHash,
          dependencies: QuestionsFamily._dependencies,
          allTransitiveDependencies: QuestionsFamily._allTransitiveDependencies,
          categoryId: categoryId,
        );

  QuestionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  Override overrideWith(
    FutureOr<List<Question>> Function(QuestionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QuestionsProvider._internal(
        (ref) => create(ref as QuestionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Question>> createElement() {
    return _QuestionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuestionsProvider && other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin QuestionsRef on AutoDisposeFutureProviderRef<List<Question>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _QuestionsProviderElement
    extends AutoDisposeFutureProviderElement<List<Question>> with QuestionsRef {
  _QuestionsProviderElement(super.provider);

  @override
  int get categoryId => (origin as QuestionsProvider).categoryId;
}

String _$categoriesHash() => r'5f38bca1c09f33447bc7c3f5fc890496835a8ed4';

/// See also [categories].
@ProviderFor(categories)
final categoriesProvider = AutoDisposeFutureProvider<List<Category>>.internal(
  categories,
  name: r'categoriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$categoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CategoriesRef = AutoDisposeFutureProviderRef<List<Category>>;
String _$weakAreasHash() => r'6758cf26310c0f7d6998fb55e8f6dfe74d18614b';

/// See also [weakAreas].
@ProviderFor(weakAreas)
final weakAreasProvider = AutoDisposeFutureProvider<List<WeakArea>>.internal(
  weakAreas,
  name: r'weakAreasProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$weakAreasHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WeakAreasRef = AutoDisposeFutureProviderRef<List<WeakArea>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
