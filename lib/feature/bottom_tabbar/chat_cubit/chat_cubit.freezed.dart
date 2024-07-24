// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() endProcess,
    required TResult Function() neutral,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? endProcess,
    TResult? Function()? neutral,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? endProcess,
    TResult Function()? neutral,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChatState value) initial,
    required TResult Function(ProcessingState value) processing,
    required TResult Function(EndProcessingState value) endProcess,
    required TResult Function(NeutralState value) neutral,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChatState value)? initial,
    TResult? Function(ProcessingState value)? processing,
    TResult? Function(EndProcessingState value)? endProcess,
    TResult? Function(NeutralState value)? neutral,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChatState value)? initial,
    TResult Function(ProcessingState value)? processing,
    TResult Function(EndProcessingState value)? endProcess,
    TResult Function(NeutralState value)? neutral,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ChatStateImplCopyWith<$Res> {
  factory _$$ChatStateImplCopyWith(
          _$ChatStateImpl value, $Res Function(_$ChatStateImpl) then) =
      __$$ChatStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateImpl>
    implements _$$ChatStateImplCopyWith<$Res> {
  __$$ChatStateImplCopyWithImpl(
      _$ChatStateImpl _value, $Res Function(_$ChatStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ChatStateImpl implements _ChatState {
  const _$ChatStateImpl();

  @override
  String toString() {
    return 'ChatState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() endProcess,
    required TResult Function() neutral,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? endProcess,
    TResult? Function()? neutral,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? endProcess,
    TResult Function()? neutral,
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
    required TResult Function(_ChatState value) initial,
    required TResult Function(ProcessingState value) processing,
    required TResult Function(EndProcessingState value) endProcess,
    required TResult Function(NeutralState value) neutral,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChatState value)? initial,
    TResult? Function(ProcessingState value)? processing,
    TResult? Function(EndProcessingState value)? endProcess,
    TResult? Function(NeutralState value)? neutral,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChatState value)? initial,
    TResult Function(ProcessingState value)? processing,
    TResult Function(EndProcessingState value)? endProcess,
    TResult Function(NeutralState value)? neutral,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _ChatState implements ChatState {
  const factory _ChatState() = _$ChatStateImpl;
}

/// @nodoc
abstract class _$$ProcessingStateImplCopyWith<$Res> {
  factory _$$ProcessingStateImplCopyWith(_$ProcessingStateImpl value,
          $Res Function(_$ProcessingStateImpl) then) =
      __$$ProcessingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProcessingStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ProcessingStateImpl>
    implements _$$ProcessingStateImplCopyWith<$Res> {
  __$$ProcessingStateImplCopyWithImpl(
      _$ProcessingStateImpl _value, $Res Function(_$ProcessingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ProcessingStateImpl implements ProcessingState {
  const _$ProcessingStateImpl();

  @override
  String toString() {
    return 'ChatState.processing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProcessingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() endProcess,
    required TResult Function() neutral,
  }) {
    return processing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? endProcess,
    TResult? Function()? neutral,
  }) {
    return processing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? endProcess,
    TResult Function()? neutral,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChatState value) initial,
    required TResult Function(ProcessingState value) processing,
    required TResult Function(EndProcessingState value) endProcess,
    required TResult Function(NeutralState value) neutral,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChatState value)? initial,
    TResult? Function(ProcessingState value)? processing,
    TResult? Function(EndProcessingState value)? endProcess,
    TResult? Function(NeutralState value)? neutral,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChatState value)? initial,
    TResult Function(ProcessingState value)? processing,
    TResult Function(EndProcessingState value)? endProcess,
    TResult Function(NeutralState value)? neutral,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class ProcessingState implements ChatState {
  const factory ProcessingState() = _$ProcessingStateImpl;
}

/// @nodoc
abstract class _$$EndProcessingStateImplCopyWith<$Res> {
  factory _$$EndProcessingStateImplCopyWith(_$EndProcessingStateImpl value,
          $Res Function(_$EndProcessingStateImpl) then) =
      __$$EndProcessingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EndProcessingStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$EndProcessingStateImpl>
    implements _$$EndProcessingStateImplCopyWith<$Res> {
  __$$EndProcessingStateImplCopyWithImpl(_$EndProcessingStateImpl _value,
      $Res Function(_$EndProcessingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$EndProcessingStateImpl implements EndProcessingState {
  const _$EndProcessingStateImpl();

  @override
  String toString() {
    return 'ChatState.endProcess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EndProcessingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() endProcess,
    required TResult Function() neutral,
  }) {
    return endProcess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? endProcess,
    TResult? Function()? neutral,
  }) {
    return endProcess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? endProcess,
    TResult Function()? neutral,
    required TResult orElse(),
  }) {
    if (endProcess != null) {
      return endProcess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChatState value) initial,
    required TResult Function(ProcessingState value) processing,
    required TResult Function(EndProcessingState value) endProcess,
    required TResult Function(NeutralState value) neutral,
  }) {
    return endProcess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChatState value)? initial,
    TResult? Function(ProcessingState value)? processing,
    TResult? Function(EndProcessingState value)? endProcess,
    TResult? Function(NeutralState value)? neutral,
  }) {
    return endProcess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChatState value)? initial,
    TResult Function(ProcessingState value)? processing,
    TResult Function(EndProcessingState value)? endProcess,
    TResult Function(NeutralState value)? neutral,
    required TResult orElse(),
  }) {
    if (endProcess != null) {
      return endProcess(this);
    }
    return orElse();
  }
}

abstract class EndProcessingState implements ChatState {
  const factory EndProcessingState() = _$EndProcessingStateImpl;
}

/// @nodoc
abstract class _$$NeutralStateImplCopyWith<$Res> {
  factory _$$NeutralStateImplCopyWith(
          _$NeutralStateImpl value, $Res Function(_$NeutralStateImpl) then) =
      __$$NeutralStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NeutralStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$NeutralStateImpl>
    implements _$$NeutralStateImplCopyWith<$Res> {
  __$$NeutralStateImplCopyWithImpl(
      _$NeutralStateImpl _value, $Res Function(_$NeutralStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NeutralStateImpl implements NeutralState {
  const _$NeutralStateImpl();

  @override
  String toString() {
    return 'ChatState.neutral()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NeutralStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() processing,
    required TResult Function() endProcess,
    required TResult Function() neutral,
  }) {
    return neutral();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? processing,
    TResult? Function()? endProcess,
    TResult? Function()? neutral,
  }) {
    return neutral?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? processing,
    TResult Function()? endProcess,
    TResult Function()? neutral,
    required TResult orElse(),
  }) {
    if (neutral != null) {
      return neutral();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ChatState value) initial,
    required TResult Function(ProcessingState value) processing,
    required TResult Function(EndProcessingState value) endProcess,
    required TResult Function(NeutralState value) neutral,
  }) {
    return neutral(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ChatState value)? initial,
    TResult? Function(ProcessingState value)? processing,
    TResult? Function(EndProcessingState value)? endProcess,
    TResult? Function(NeutralState value)? neutral,
  }) {
    return neutral?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ChatState value)? initial,
    TResult Function(ProcessingState value)? processing,
    TResult Function(EndProcessingState value)? endProcess,
    TResult Function(NeutralState value)? neutral,
    required TResult orElse(),
  }) {
    if (neutral != null) {
      return neutral(this);
    }
    return orElse();
  }
}

abstract class NeutralState implements ChatState {
  const factory NeutralState() = _$NeutralStateImpl;
}
