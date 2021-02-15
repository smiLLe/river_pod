// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of framework;

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SubscriptionTypeTearOff {
  const _$SubscriptionTypeTearOff();

  _Watch watch(ProviderElement<dynamic, dynamic> element) {
    return _Watch(
      element,
    );
  }

  _Listen listen(ProviderElement<dynamic, dynamic> element) {
    return _Listen(
      element,
    );
  }
}

/// @nodoc
const $SubscriptionType = _$SubscriptionTypeTearOff();

/// @nodoc
mixin _$SubscriptionType {
  ProviderElement<dynamic, dynamic> get element;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProviderElement<dynamic, dynamic> element) watch,
    required TResult Function(ProviderElement<dynamic, dynamic> element) listen,
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProviderElement<dynamic, dynamic> element)? watch,
    TResult Function(ProviderElement<dynamic, dynamic> element)? listen,
    required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Watch value) watch,
    required TResult Function(_Listen value) listen,
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Watch value)? watch,
    TResult Function(_Listen value)? listen,
    required TResult orElse(),
  });

  @JsonKey(ignore: true)
  $SubscriptionTypeCopyWith<SubscriptionType> get copyWith;
}

/// @nodoc
abstract class $SubscriptionTypeCopyWith<$Res> {
  factory $SubscriptionTypeCopyWith(
          SubscriptionType value, $Res Function(SubscriptionType) then) =
      _$SubscriptionTypeCopyWithImpl<$Res>;
  $Res call({ProviderElement<dynamic, dynamic> element});
}

/// @nodoc
class _$SubscriptionTypeCopyWithImpl<$Res>
    implements $SubscriptionTypeCopyWith<$Res> {
  _$SubscriptionTypeCopyWithImpl(this._value, this._then);

  final SubscriptionType _value;
  // ignore: unused_field
  final $Res Function(SubscriptionType) _then;

  @override
  $Res call({
    Object? element = freezed,
  }) {
    return _then(_value.copyWith(
      element: element == freezed
          ? _value.element
          : element as ProviderElement<dynamic, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$WatchCopyWith<$Res>
    implements $SubscriptionTypeCopyWith<$Res> {
  factory _$WatchCopyWith(_Watch value, $Res Function(_Watch) then) =
      __$WatchCopyWithImpl<$Res>;
  @override
  $Res call({ProviderElement<dynamic, dynamic> element});
}

/// @nodoc
class __$WatchCopyWithImpl<$Res> extends _$SubscriptionTypeCopyWithImpl<$Res>
    implements _$WatchCopyWith<$Res> {
  __$WatchCopyWithImpl(_Watch _value, $Res Function(_Watch) _then)
      : super(_value, (v) => _then(v as _Watch));

  @override
  _Watch get _value => super._value as _Watch;

  @override
  $Res call({
    Object? element = freezed,
  }) {
    return _then(_Watch(
      element == freezed
          ? _value.element
          : element as ProviderElement<dynamic, dynamic>,
    ));
  }
}

/// @nodoc
class _$_Watch implements _Watch {
  _$_Watch(this.element);

  @override
  final ProviderElement<dynamic, dynamic> element;

  @override
  String toString() {
    return 'SubscriptionType.watch(element: $element)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Watch &&
            (identical(other.element, element) ||
                const DeepCollectionEquality().equals(other.element, element)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(element);

  @JsonKey(ignore: true)
  @override
  _$WatchCopyWith<_Watch> get copyWith =>
      __$WatchCopyWithImpl<_Watch>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProviderElement<dynamic, dynamic> element) watch,
    required TResult Function(ProviderElement<dynamic, dynamic> element) listen,
  }) {
    return watch(element);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProviderElement<dynamic, dynamic> element)? watch,
    TResult Function(ProviderElement<dynamic, dynamic> element)? listen,
    required TResult orElse(),
  }) {
    if (watch != null) {
      return watch(element);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Watch value) watch,
    required TResult Function(_Listen value) listen,
  }) {
    return watch(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Watch value)? watch,
    TResult Function(_Listen value)? listen,
    required TResult orElse(),
  }) {
    if (watch != null) {
      return watch(this);
    }
    return orElse();
  }
}

abstract class _Watch implements SubscriptionType {
  factory _Watch(ProviderElement<dynamic, dynamic> element) = _$_Watch;

  @override
  ProviderElement<dynamic, dynamic> get element;
  @override
  @JsonKey(ignore: true)
  _$WatchCopyWith<_Watch> get copyWith;
}

/// @nodoc
abstract class _$ListenCopyWith<$Res>
    implements $SubscriptionTypeCopyWith<$Res> {
  factory _$ListenCopyWith(_Listen value, $Res Function(_Listen) then) =
      __$ListenCopyWithImpl<$Res>;
  @override
  $Res call({ProviderElement<dynamic, dynamic> element});
}

/// @nodoc
class __$ListenCopyWithImpl<$Res> extends _$SubscriptionTypeCopyWithImpl<$Res>
    implements _$ListenCopyWith<$Res> {
  __$ListenCopyWithImpl(_Listen _value, $Res Function(_Listen) _then)
      : super(_value, (v) => _then(v as _Listen));

  @override
  _Listen get _value => super._value as _Listen;

  @override
  $Res call({
    Object? element = freezed,
  }) {
    return _then(_Listen(
      element == freezed
          ? _value.element
          : element as ProviderElement<dynamic, dynamic>,
    ));
  }
}

/// @nodoc
class _$_Listen implements _Listen {
  _$_Listen(this.element);

  @override
  final ProviderElement<dynamic, dynamic> element;

  @override
  String toString() {
    return 'SubscriptionType.listen(element: $element)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Listen &&
            (identical(other.element, element) ||
                const DeepCollectionEquality().equals(other.element, element)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(element);

  @JsonKey(ignore: true)
  @override
  _$ListenCopyWith<_Listen> get copyWith =>
      __$ListenCopyWithImpl<_Listen>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProviderElement<dynamic, dynamic> element) watch,
    required TResult Function(ProviderElement<dynamic, dynamic> element) listen,
  }) {
    return listen(element);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProviderElement<dynamic, dynamic> element)? watch,
    TResult Function(ProviderElement<dynamic, dynamic> element)? listen,
    required TResult orElse(),
  }) {
    if (listen != null) {
      return listen(element);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Watch value) watch,
    required TResult Function(_Listen value) listen,
  }) {
    return listen(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Watch value)? watch,
    TResult Function(_Listen value)? listen,
    required TResult orElse(),
  }) {
    if (listen != null) {
      return listen(this);
    }
    return orElse();
  }
}

abstract class _Listen implements SubscriptionType {
  factory _Listen(ProviderElement<dynamic, dynamic> element) = _$_Listen;

  @override
  ProviderElement<dynamic, dynamic> get element;
  @override
  @JsonKey(ignore: true)
  _$ListenCopyWith<_Listen> get copyWith;
}
