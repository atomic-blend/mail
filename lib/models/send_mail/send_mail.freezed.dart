// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_mail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SendMail _$SendMailFromJson(Map<String, dynamic> json) {
  return _SendMail.fromJson(json);
}

/// @nodoc
mixin _$SendMail {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  Mail? get mail => throw _privateConstructorUsedError;
  set mail(Mail? value) => throw _privateConstructorUsedError;
  SendStatus get sendStatus => throw _privateConstructorUsedError;
  set sendStatus(SendStatus value) => throw _privateConstructorUsedError;
  int? get retryCounter => throw _privateConstructorUsedError;
  set retryCounter(int? value) => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;
  set failureReason(String? value) => throw _privateConstructorUsedError;
  DateTime? get failedAt => throw _privateConstructorUsedError;
  set failedAt(DateTime? value) => throw _privateConstructorUsedError;
  bool get trashed => throw _privateConstructorUsedError;
  set trashed(bool value) => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  set createdAt(DateTime? value) => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  set updatedAt(DateTime? value) => throw _privateConstructorUsedError;

  /// Serializes this SendMail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendMail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendMailCopyWith<SendMail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendMailCopyWith<$Res> {
  factory $SendMailCopyWith(SendMail value, $Res Function(SendMail) then) =
      _$SendMailCopyWithImpl<$Res, SendMail>;
  @useResult
  $Res call(
      {String? id,
      Mail? mail,
      SendStatus sendStatus,
      int? retryCounter,
      String? failureReason,
      DateTime? failedAt,
      bool trashed,
      DateTime? createdAt,
      DateTime? updatedAt});

  $MailCopyWith<$Res>? get mail;
}

/// @nodoc
class _$SendMailCopyWithImpl<$Res, $Val extends SendMail>
    implements $SendMailCopyWith<$Res> {
  _$SendMailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendMail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? mail = freezed,
    Object? sendStatus = null,
    Object? retryCounter = freezed,
    Object? failureReason = freezed,
    Object? failedAt = freezed,
    Object? trashed = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      mail: freezed == mail
          ? _value.mail
          : mail // ignore: cast_nullable_to_non_nullable
              as Mail?,
      sendStatus: null == sendStatus
          ? _value.sendStatus
          : sendStatus // ignore: cast_nullable_to_non_nullable
              as SendStatus,
      retryCounter: freezed == retryCounter
          ? _value.retryCounter
          : retryCounter // ignore: cast_nullable_to_non_nullable
              as int?,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      failedAt: freezed == failedAt
          ? _value.failedAt
          : failedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trashed: null == trashed
          ? _value.trashed
          : trashed // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of SendMail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MailCopyWith<$Res>? get mail {
    if (_value.mail == null) {
      return null;
    }

    return $MailCopyWith<$Res>(_value.mail!, (value) {
      return _then(_value.copyWith(mail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SendMailImplCopyWith<$Res>
    implements $SendMailCopyWith<$Res> {
  factory _$$SendMailImplCopyWith(
          _$SendMailImpl value, $Res Function(_$SendMailImpl) then) =
      __$$SendMailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      Mail? mail,
      SendStatus sendStatus,
      int? retryCounter,
      String? failureReason,
      DateTime? failedAt,
      bool trashed,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $MailCopyWith<$Res>? get mail;
}

/// @nodoc
class __$$SendMailImplCopyWithImpl<$Res>
    extends _$SendMailCopyWithImpl<$Res, _$SendMailImpl>
    implements _$$SendMailImplCopyWith<$Res> {
  __$$SendMailImplCopyWithImpl(
      _$SendMailImpl _value, $Res Function(_$SendMailImpl) _then)
      : super(_value, _then);

  /// Create a copy of SendMail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? mail = freezed,
    Object? sendStatus = null,
    Object? retryCounter = freezed,
    Object? failureReason = freezed,
    Object? failedAt = freezed,
    Object? trashed = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$SendMailImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      mail: freezed == mail
          ? _value.mail
          : mail // ignore: cast_nullable_to_non_nullable
              as Mail?,
      sendStatus: null == sendStatus
          ? _value.sendStatus
          : sendStatus // ignore: cast_nullable_to_non_nullable
              as SendStatus,
      retryCounter: freezed == retryCounter
          ? _value.retryCounter
          : retryCounter // ignore: cast_nullable_to_non_nullable
              as int?,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      failedAt: freezed == failedAt
          ? _value.failedAt
          : failedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trashed: null == trashed
          ? _value.trashed
          : trashed // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SendMailImpl extends _SendMail {
  _$SendMailImpl(
      {this.id,
      this.mail,
      this.sendStatus = SendStatus.pending,
      this.retryCounter,
      this.failureReason,
      this.failedAt,
      this.trashed = false,
      this.createdAt,
      this.updatedAt})
      : super._();

  factory _$SendMailImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendMailImplFromJson(json);

  @override
  String? id;
  @override
  Mail? mail;
  @override
  @JsonKey()
  SendStatus sendStatus;
  @override
  int? retryCounter;
  @override
  String? failureReason;
  @override
  DateTime? failedAt;
  @override
  @JsonKey()
  bool trashed;
  @override
  DateTime? createdAt;
  @override
  DateTime? updatedAt;

  /// Create a copy of SendMail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMailImplCopyWith<_$SendMailImpl> get copyWith =>
      __$$SendMailImplCopyWithImpl<_$SendMailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendMailImplToJson(
      this,
    );
  }
}

abstract class _SendMail extends SendMail {
  factory _SendMail(
      {String? id,
      Mail? mail,
      SendStatus sendStatus,
      int? retryCounter,
      String? failureReason,
      DateTime? failedAt,
      bool trashed,
      DateTime? createdAt,
      DateTime? updatedAt}) = _$SendMailImpl;
  _SendMail._() : super._();

  factory _SendMail.fromJson(Map<String, dynamic> json) =
      _$SendMailImpl.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  Mail? get mail;
  set mail(Mail? value);
  @override
  SendStatus get sendStatus;
  set sendStatus(SendStatus value);
  @override
  int? get retryCounter;
  set retryCounter(int? value);
  @override
  String? get failureReason;
  set failureReason(String? value);
  @override
  DateTime? get failedAt;
  set failedAt(DateTime? value);
  @override
  bool get trashed;
  set trashed(bool value);
  @override
  DateTime? get createdAt;
  set createdAt(DateTime? value);
  @override
  DateTime? get updatedAt;
  set updatedAt(DateTime? value);

  /// Create a copy of SendMail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMailImplCopyWith<_$SendMailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
