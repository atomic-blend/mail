// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MailAttachmentImpl _$$MailAttachmentImplFromJson(Map<String, dynamic> json) =>
    _$MailAttachmentImpl(
      filename: json['filename'] as String,
      contentType: json['contentType'] as String,
      storagePath: json['storagePath'] as String,
      storageType: json['storageType'] as String,
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$$MailAttachmentImplToJson(
        _$MailAttachmentImpl instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'contentType': instance.contentType,
      'storagePath': instance.storagePath,
      'storageType': instance.storageType,
      'size': instance.size,
    };
