// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'introduction_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$IntroductionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int pageState) setPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int pageState)? setPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int pageState)? setPage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_IntroductionState value) initial,
    required TResult Function(PageState value) setPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_IntroductionState value)? initial,
    TResult? Function(PageState value)? setPage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_IntroductionState value)? initial,
    TResult Function(PageState value)? setPage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntroductionStateCopyWith<$Res> {
  factory $IntroductionStateCopyWith(
          IntroductionState value, $Res Function(IntroductionState) then) =
      _$IntroductionStateCopyWithImpl<$Res, IntroductionState>;
}

/// @nodoc
class _$IntroductionStateCopyWithImpl<$Res, $Val extends IntroductionState>
    implements $IntroductionStateCopyWith<$Res> {
  _$IntroductionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$IntroductionStateImplCopyWith<$Res> {
  factory _$$IntroductionStateImplCopyWith(_$IntroductionStateImpl value,
          $Res Function(_$IntroductionStateImpl) then) =
      __$$IntroductionStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IntroductionStateImplCopyWithImpl<$Res>
    extends _$IntroductionStateCopyWithImpl<$Res, _$IntroductionStateImpl>
    implements _$$IntroductionStateImplCopyWith<$Res> {
  __$$IntroductionStateImplCopyWithImpl(_$IntroductionStateImpl _value,
      $Res Function(_$IntroductionStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$IntroductionStateImpl implements _IntroductionState {
  const _$IntroductionStateImpl();

  @override
  String toString() {
    return 'IntroductionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$IntroductionStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int pageState) setPage,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int pageState)? setPage,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int pageState)? setPage,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_IntroductionState value) initial,
    required TResult Function(PageState value) setPage,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_IntroductionState value)? initial,
    TResult? Function(PageState value)? setPage,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_IntroductionState value)? initial,
    TResult Function(PageState value)? setPage,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _IntroductionState implements IntroductionState {
  const factory _IntroductionState() = _$IntroductionStateImpl;
}

/// @nodoc
abstract class _$$PageStateImplCopyWith<$Res> {
  factory _$$PageStateImplCopyWith(
          _$PageStateImpl value, $Res Function(_$PageStateImpl) then) =
      __$$PageStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int pageState});
}

/// @nodoc
class __$$PageStateImplCopyWithImpl<$Res>
    extends _$IntroductionStateCopyWithImpl<$Res, _$PageStateImpl>
    implements _$$PageStateImplCopyWith<$Res> {
  __$$PageStateImplCopyWithImpl(
      _$PageStateImpl _value, $Res Function(_$PageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageState = null,
  }) {
    return _then(_$PageStateImpl(
      null == pageState
          ? _value.pageState
          : pageState // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PageStateImpl implements PageState {
  const _$PageStateImpl(this.pageState);

  @override
  final int pageState;

  @override
  String toString() {
    return 'IntroductionState.setPage(pageState: $pageState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageStateImpl &&
            (identical(other.pageState, pageState) ||
                other.pageState == pageState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PageStateImplCopyWith<_$PageStateImpl> get copyWith =>
      __$$PageStateImplCopyWithImpl<_$PageStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(int pageState) setPage,
  }) {
    return setPage(pageState);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(int pageState)? setPage,
  }) {
    return setPage?.call(pageState);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(int pageState)? setPage,
    required TResult orElse(),
  }) {
    if (setPage != null) {
      return setPage(pageState);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_IntroductionState value) initial,
    required TResult Function(PageState value) setPage,
  }) {
    return setPage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_IntroductionState value)? initial,
    TResult? Function(PageState value)? setPage,
  }) {
    return setPage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_IntroductionState value)? initial,
    TResult Function(PageState value)? setPage,
    required TResult orElse(),
  }) {
    if (setPage != null) {
      return setPage(this);
    }
    return orElse();
  }
}

abstract class PageState implements IntroductionState {
  const factory PageState(final int pageState) = _$PageStateImpl;

  int get pageState;
  @JsonKey(ignore: true)
  _$$PageStateImplCopyWith<_$PageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
