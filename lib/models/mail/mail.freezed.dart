// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Mail _$MailFromJson(Map<String, dynamic> json) {
  return _Mail.fromJson(json);
}

/// @nodoc
mixin _$Mail {
  String? get id => throw _privateConstructorUsedError;
  set id(String? value) => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  set userId(String? value) => throw _privateConstructorUsedError;
  Map<String, dynamic>? get headers => throw _privateConstructorUsedError;
  set headers(Map<String, dynamic>? value) =>
      throw _privateConstructorUsedError;
  String? get textContent => throw _privateConstructorUsedError;
  set textContent(String? value) => throw _privateConstructorUsedError;
  String? get htmlContent => throw _privateConstructorUsedError;
  set htmlContent(String? value) => throw _privateConstructorUsedError;
  String? get inReplyTo => throw _privateConstructorUsedError;
  set inReplyTo(String? value) => throw _privateConstructorUsedError;
  List<MailAttachment>? get attachments => throw _privateConstructorUsedError;
  set attachments(List<MailAttachment>? value) =>
      throw _privateConstructorUsedError;
  bool? get archived => throw _privateConstructorUsedError;
  set archived(bool? value) => throw _privateConstructorUsedError;
  bool? get trashed => throw _privateConstructorUsedError;
  set trashed(bool? value) => throw _privateConstructorUsedError;
  String? get calendarEvent => throw _privateConstructorUsedError;
  set calendarEvent(String? value) => throw _privateConstructorUsedError;
  bool? get greylisted => throw _privateConstructorUsedError;
  set greylisted(bool? value) => throw _privateConstructorUsedError;
  bool? get rejected => throw _privateConstructorUsedError;
  set rejected(bool? value) => throw _privateConstructorUsedError;
  bool? get rewriteSubject => throw _privateConstructorUsedError;
  set rewriteSubject(bool? value) => throw _privateConstructorUsedError;
  bool? get read => throw _privateConstructorUsedError;
  set read(bool? value) => throw _privateConstructorUsedError;
  DateTime? get trashedAt => throw _privateConstructorUsedError;
  set trashedAt(DateTime? value) => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  set createdAt(DateTime? value) => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  set updatedAt(DateTime? value) => throw _privateConstructorUsedError;

  /// Serializes this Mail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Mail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MailCopyWith<Mail> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MailCopyWith<$Res> {
  factory $MailCopyWith(Mail value, $Res Function(Mail) then) =
      _$MailCopyWithImpl<$Res, Mail>;
  @useResult
  $Res call(
      {String? id,
      String? userId,
      Map<String, dynamic>? headers,
      String? textContent,
      String? htmlContent,
      String? inReplyTo,
      List<MailAttachment>? attachments,
      bool? archived,
      bool? trashed,
      String? calendarEvent,
      bool? greylisted,
      bool? rejected,
      bool? rewriteSubject,
      bool? read,
      DateTime? trashedAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$MailCopyWithImpl<$Res, $Val extends Mail>
    implements $MailCopyWith<$Res> {
  _$MailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? headers = freezed,
    Object? textContent = freezed,
    Object? htmlContent = freezed,
    Object? inReplyTo = freezed,
    Object? attachments = freezed,
    Object? archived = freezed,
    Object? trashed = freezed,
    Object? calendarEvent = freezed,
    Object? greylisted = freezed,
    Object? rejected = freezed,
    Object? rewriteSubject = freezed,
    Object? read = freezed,
    Object? trashedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: freezed == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      textContent: freezed == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String?,
      htmlContent: freezed == htmlContent
          ? _value.htmlContent
          : htmlContent // ignore: cast_nullable_to_non_nullable
              as String?,
      inReplyTo: freezed == inReplyTo
          ? _value.inReplyTo
          : inReplyTo // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MailAttachment>?,
      archived: freezed == archived
          ? _value.archived
          : archived // ignore: cast_nullable_to_non_nullable
              as bool?,
      trashed: freezed == trashed
          ? _value.trashed
          : trashed // ignore: cast_nullable_to_non_nullable
              as bool?,
      calendarEvent: freezed == calendarEvent
          ? _value.calendarEvent
          : calendarEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      greylisted: freezed == greylisted
          ? _value.greylisted
          : greylisted // ignore: cast_nullable_to_non_nullable
              as bool?,
      rejected: freezed == rejected
          ? _value.rejected
          : rejected // ignore: cast_nullable_to_non_nullable
              as bool?,
      rewriteSubject: freezed == rewriteSubject
          ? _value.rewriteSubject
          : rewriteSubject // ignore: cast_nullable_to_non_nullable
              as bool?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      trashedAt: freezed == trashedAt
          ? _value.trashedAt
          : trashedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
}

/// @nodoc
abstract class _$$MailImplCopyWith<$Res> implements $MailCopyWith<$Res> {
  factory _$$MailImplCopyWith(
          _$MailImpl value, $Res Function(_$MailImpl) then) =
      __$$MailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? userId,
      Map<String, dynamic>? headers,
      String? textContent,
      String? htmlContent,
      String? inReplyTo,
      List<MailAttachment>? attachments,
      bool? archived,
      bool? trashed,
      String? calendarEvent,
      bool? greylisted,
      bool? rejected,
      bool? rewriteSubject,
      bool? read,
      DateTime? trashedAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$MailImplCopyWithImpl<$Res>
    extends _$MailCopyWithImpl<$Res, _$MailImpl>
    implements _$$MailImplCopyWith<$Res> {
  __$$MailImplCopyWithImpl(_$MailImpl _value, $Res Function(_$MailImpl) _then)
      : super(_value, _then);

  /// Create a copy of Mail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? headers = freezed,
    Object? textContent = freezed,
    Object? htmlContent = freezed,
    Object? inReplyTo = freezed,
    Object? attachments = freezed,
    Object? archived = freezed,
    Object? trashed = freezed,
    Object? calendarEvent = freezed,
    Object? greylisted = freezed,
    Object? rejected = freezed,
    Object? rewriteSubject = freezed,
    Object? read = freezed,
    Object? trashedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$MailImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: freezed == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      textContent: freezed == textContent
          ? _value.textContent
          : textContent // ignore: cast_nullable_to_non_nullable
              as String?,
      htmlContent: freezed == htmlContent
          ? _value.htmlContent
          : htmlContent // ignore: cast_nullable_to_non_nullable
              as String?,
      inReplyTo: freezed == inReplyTo
          ? _value.inReplyTo
          : inReplyTo // ignore: cast_nullable_to_non_nullable
              as String?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<MailAttachment>?,
      archived: freezed == archived
          ? _value.archived
          : archived // ignore: cast_nullable_to_non_nullable
              as bool?,
      trashed: freezed == trashed
          ? _value.trashed
          : trashed // ignore: cast_nullable_to_non_nullable
              as bool?,
      calendarEvent: freezed == calendarEvent
          ? _value.calendarEvent
          : calendarEvent // ignore: cast_nullable_to_non_nullable
              as String?,
      greylisted: freezed == greylisted
          ? _value.greylisted
          : greylisted // ignore: cast_nullable_to_non_nullable
              as bool?,
      rejected: freezed == rejected
          ? _value.rejected
          : rejected // ignore: cast_nullable_to_non_nullable
              as bool?,
      rewriteSubject: freezed == rewriteSubject
          ? _value.rewriteSubject
          : rewriteSubject // ignore: cast_nullable_to_non_nullable
              as bool?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool?,
      trashedAt: freezed == trashedAt
          ? _value.trashedAt
          : trashedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$MailImpl extends _Mail {
  _$MailImpl(
      {this.id,
      this.userId,
      this.headers,
      this.textContent,
      this.htmlContent,
      this.inReplyTo,
      this.attachments,
      this.archived,
      this.trashed,
      this.calendarEvent,
      this.greylisted,
      this.rejected,
      this.rewriteSubject,
      this.read,
      this.trashedAt,
      this.createdAt,
      this.updatedAt})
      : super._();

  factory _$MailImpl.fromJson(Map<String, dynamic> json) =>
      _$$MailImplFromJson(json);

  @override
  String? id;
  @override
  String? userId;
  @override
  Map<String, dynamic>? headers;
  @override
  String? textContent;
  @override
  String? htmlContent;
  @override
  String? inReplyTo;
  @override
  List<MailAttachment>? attachments;
  @override
  bool? archived;
  @override
  bool? trashed;
  @override
  String? calendarEvent;
  @override
  bool? greylisted;
  @override
  bool? rejected;
  @override
  bool? rewriteSubject;
  @override
  bool? read;
  @override
  DateTime? trashedAt;
  @override
  DateTime? createdAt;
  @override
  DateTime? updatedAt;

  /// Create a copy of Mail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MailImplCopyWith<_$MailImpl> get copyWith =>
      __$$MailImplCopyWithImpl<_$MailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MailImplToJson(
      this,
    );
  }
}

abstract class _Mail extends Mail {
  factory _Mail(
      {String? id,
      String? userId,
      Map<String, dynamic>? headers,
      String? textContent,
      String? htmlContent,
      String? inReplyTo,
      List<MailAttachment>? attachments,
      bool? archived,
      bool? trashed,
      String? calendarEvent,
      bool? greylisted,
      bool? rejected,
      bool? rewriteSubject,
      bool? read,
      DateTime? trashedAt,
      DateTime? createdAt,
      DateTime? updatedAt}) = _$MailImpl;
  _Mail._() : super._();

  factory _Mail.fromJson(Map<String, dynamic> json) = _$MailImpl.fromJson;

  @override
  String? get id;
  set id(String? value);
  @override
  String? get userId;
  set userId(String? value);
  @override
  Map<String, dynamic>? get headers;
  set headers(Map<String, dynamic>? value);
  @override
  String? get textContent;
  set textContent(String? value);
  @override
  String? get htmlContent;
  set htmlContent(String? value);
  @override
  String? get inReplyTo;
  set inReplyTo(String? value);
  @override
  List<MailAttachment>? get attachments;
  set attachments(List<MailAttachment>? value);
  @override
  bool? get archived;
  set archived(bool? value);
  @override
  bool? get trashed;
  set trashed(bool? value);
  @override
  String? get calendarEvent;
  set calendarEvent(String? value);
  @override
  bool? get greylisted;
  set greylisted(bool? value);
  @override
  bool? get rejected;
  set rejected(bool? value);
  @override
  bool? get rewriteSubject;
  set rewriteSubject(bool? value);
  @override
  bool? get read;
  set read(bool? value);
  @override
  DateTime? get trashedAt;
  set trashedAt(DateTime? value);
  @override
  DateTime? get createdAt;
  set createdAt(DateTime? value);
  @override
  DateTime? get updatedAt;
  set updatedAt(DateTime? value);

  /// Create a copy of Mail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MailImplCopyWith<_$MailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
