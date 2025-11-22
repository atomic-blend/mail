// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mail_thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MailThread _$MailThreadFromJson(Map<String, dynamic> json) {
  return _MailThread.fromJson(json);
}

/// @nodoc
mixin _$MailThread {
  List<Mail> get mails => throw _privateConstructorUsedError;

  /// Serializes this MailThread to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MailThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MailThreadCopyWith<MailThread> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MailThreadCopyWith<$Res> {
  factory $MailThreadCopyWith(
          MailThread value, $Res Function(MailThread) then) =
      _$MailThreadCopyWithImpl<$Res, MailThread>;
  @useResult
  $Res call({List<Mail> mails});
}

/// @nodoc
class _$MailThreadCopyWithImpl<$Res, $Val extends MailThread>
    implements $MailThreadCopyWith<$Res> {
  _$MailThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MailThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mails = null,
  }) {
    return _then(_value.copyWith(
      mails: null == mails
          ? _value.mails
          : mails // ignore: cast_nullable_to_non_nullable
              as List<Mail>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MailThreadImplCopyWith<$Res>
    implements $MailThreadCopyWith<$Res> {
  factory _$$MailThreadImplCopyWith(
          _$MailThreadImpl value, $Res Function(_$MailThreadImpl) then) =
      __$$MailThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Mail> mails});
}

/// @nodoc
class __$$MailThreadImplCopyWithImpl<$Res>
    extends _$MailThreadCopyWithImpl<$Res, _$MailThreadImpl>
    implements _$$MailThreadImplCopyWith<$Res> {
  __$$MailThreadImplCopyWithImpl(
      _$MailThreadImpl _value, $Res Function(_$MailThreadImpl) _then)
      : super(_value, _then);

  /// Create a copy of MailThread
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mails = null,
  }) {
    return _then(_$MailThreadImpl(
      mails: null == mails
          ? _value._mails
          : mails // ignore: cast_nullable_to_non_nullable
              as List<Mail>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MailThreadImpl implements _MailThread {
  _$MailThreadImpl({final List<Mail> mails = const <Mail>[]}) : _mails = mails;

  factory _$MailThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$MailThreadImplFromJson(json);

  final List<Mail> _mails;
  @override
  @JsonKey()
  List<Mail> get mails {
    if (_mails is EqualUnmodifiableListView) return _mails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mails);
  }

  @override
  String toString() {
    return 'MailThread(mails: $mails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MailThreadImpl &&
            const DeepCollectionEquality().equals(other._mails, _mails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_mails));

  /// Create a copy of MailThread
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MailThreadImplCopyWith<_$MailThreadImpl> get copyWith =>
      __$$MailThreadImplCopyWithImpl<_$MailThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MailThreadImplToJson(
      this,
    );
  }
}

abstract class _MailThread implements MailThread {
  factory _MailThread({final List<Mail> mails}) = _$MailThreadImpl;

  factory _MailThread.fromJson(Map<String, dynamic> json) =
      _$MailThreadImpl.fromJson;

  @override
  List<Mail> get mails;

  /// Create a copy of MailThread
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MailThreadImplCopyWith<_$MailThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
