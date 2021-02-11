part of '../stream_provider.dart';

/// {@macro riverpod.streamprovider}
@sealed
class AutoDisposeStreamProvider<T>
    extends AutoDisposeProviderBase<Stream<T>, AsyncValue<T>>
    with _StreamProviderMixin<T> {
  /// {@macro riverpod.streamprovider}
  AutoDisposeStreamProvider(
    Create<Stream<T>, AsyncValue<T>,
            AutoDisposeProviderReference<AsyncValue<T>>>
        create, {
    String? name,
  }) : super(create, name);

  /// {@macro riverpod.family}
  static const family = AutoDisposeStreamProviderFamilyBuilder();

  AutoDisposeProviderBase<Stream<T>, Stream<T>>? _stream;
  @override
  AutoDisposeProviderBase<Stream<T>, Stream<T>> get stream {
    return _stream ??= _AutoDisposeCreatedStreamProvider(
      this,
      name: name == null ? null : '$name.stream',
    );
  }

  AutoDisposeProviderBase<Object?, Future<T>>? _last;
  @override
  AutoDisposeProviderBase<Object?, Future<T>> get last {
    return _last ??= Provider.autoDispose(
      (ref) => _readLast(ref as ProviderElement, this),
      name: name == null ? null : '$name.last',
    );
  }

  @override
  _AutoDisposeStreamProviderState<T> createState() =>
      _AutoDisposeStreamProviderState();
}

@sealed
class _AutoDisposeStreamProviderState<T> = ProviderStateBase<Stream<T>,
    AsyncValue<T>> with _StreamProviderStateMixin<T>;

/// {@macro riverpod.streamprovider.family}
@sealed
class AutoDisposeStreamProviderFamily<T, A> extends Family<
    Stream<T>,
    AsyncValue<T>,
    A,
    AutoDisposeProviderReference<AsyncValue<T>>,
    AutoDisposeStreamProvider<T>> {
  /// {@macro riverpod.streamprovider.family}
  AutoDisposeStreamProviderFamily(
    Stream<T> Function(AutoDisposeProviderReference<AsyncValue<T>> ref, A a)
        create, {
    String? name,
  }) : super(create, name);

  @override
  AutoDisposeStreamProvider<T> create(
    A value,
    Stream<T> Function(AutoDisposeProviderReference<AsyncValue<T>> ref, A param)
        builder,
    String? name,
  ) {
    return AutoDisposeStreamProvider((ref) => builder(ref, value), name: name);
  }
}
