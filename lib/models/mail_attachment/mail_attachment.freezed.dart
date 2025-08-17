// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mail_attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MailAttachment _$MailAttachmentFromJson(Map<String, dynamic> json) {
  return _MailAttachment.fromJson(json);
}

/// @nodoc
mixin _$MailAttachment {
  String get filename => throw _privateConstructorUsedError;
  set filename(String value) => throw _privateConstructorUsedError;
  String get contentType => throw _privateConstructorUsedError;
  set contentType(String value) => throw _privateConstructorUsedError;
  String get storagePath => throw _privateConstructorUsedError;
  set storagePath(String value) => throw _privateConstructorUsedError;
  String get storageType => throw _privateConstructorUsedError;
  set storageType(String value) => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  set size(int value) => throw _privateConstructorUsedError;

  /// Serializes this MailAttachment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MailAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MailAttachmentCopyWith<MailAttachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MailAttachmentCopyWith<$Res> {
  factory $MailAttachmentCopyWith(
          MailAttachment value, $Res Function(MailAttachment) then) =
      _$MailAttachmentCopyWithImpl<$Res, MailAttachment>;
  @useResult
  $Res call(
      {String filename,
      String contentType,
      String storagePath,
      String storageType,
      int size});
}

/// @nodoc
class _$MailAttachmentCopyWithImpl<$Res, $Val extends MailAttachment>
    implements $MailAttachmentCopyWith<$Res> {
  _$MailAttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MailAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? contentType = null,
    Object? storagePath = null,
    Object? storageType = null,
    Object? size = null,
  }) {
    return _then(_value.copyWith(
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      storagePath: null == storagePath
          ? _value.storagePath
          : storagePath // ignore: cast_nullable_to_non_nullable
              as String,
      storageType: null == storageType
          ? _value.storageType
          : storageType // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MailAttachmentImplCopyWith<$Res>
    implements $MailAttachmentCopyWith<$Res> {
  factory _$$MailAttachmentImplCopyWith(_$MailAttachmentImpl value,
          $Res Function(_$MailAttachmentImpl) then) =
      __$$MailAttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String filename,
      String contentType,
      String storagePath,
      String storageType,
      int size});
}

/// @nodoc
class __$$MailAttachmentImplCopyWithImpl<$Res>
    extends _$MailAttachmentCopyWithImpl<$Res, _$MailAttachmentImpl>
    implements _$$MailAttachmentImplCopyWith<$Res> {
  __$$MailAttachmentImplCopyWithImpl(
      _$MailAttachmentImpl _value, $Res Function(_$MailAttachmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of MailAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filename = null,
    Object? contentType = null,
    Object? storagePath = null,
    Object? storageType = null,
    Object? size = null,
  }) {
    return _then(_$MailAttachmentImpl(
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
      storagePath: null == storagePath
          ? _value.storagePath
          : storagePath // ignore: cast_nullable_to_non_nullable
              as String,
      storageType: null == storageType
          ? _value.storageType
          : storageType // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MailAttachmentImpl extends _MailAttachment {
  _$MailAttachmentImpl(
      {required this.filename,
      required this.contentType,
      required this.storagePath,
      required this.storageType,
      required this.size})
      : super._();

  factory _$MailAttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MailAttachmentImplFromJson(json);

  @override
  String filename;
  @override
  String contentType;
  @override
  String storagePath;
  @override
  String storageType;
  @override
  int size;

  /// Create a copy of MailAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MailAttachmentImplCopyWith<_$MailAttachmentImpl> get copyWith =>
      __$$MailAttachmentImplCopyWithImpl<_$MailAttachmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MailAttachmentImplToJson(
      this,
    );
  }
}

abstract class _MailAttachment extends MailAttachment {
  factory _MailAttachment(
      {required String filename,
      required String contentType,
      required String storagePath,
      required String storageType,
      required int size}) = _$MailAttachmentImpl;
  _MailAttachment._() : super._();

  factory _MailAttachment.fromJson(Map<String, dynamic> json) =
      _$MailAttachmentImpl.fromJson;

  @override
  String get filename;
  set filename(String value);
  @override
  String get contentType;
  set contentType(String value);
  @override
  String get storagePath;
  set storagePath(String value);
  @override
  String get storageType;
  set storageType(String value);
  @override
  int get size;
  set size(int value);

  /// Create a copy of MailAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MailAttachmentImplCopyWith<_$MailAttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
