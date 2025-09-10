// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MailImpl _$$MailImplFromJson(Map<String, dynamic> json) => _$MailImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      headers: (json['headers'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      textContent: json['textContent'] as String?,
      htmlContent: json['htmlContent'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => MailAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      archived: json['archived'] as bool?,
      trashed: json['trashed'] as bool?,
      greylisted: json['greylisted'] as bool?,
      rejected: json['rejected'] as bool?,
      rewriteSubject: json['rewriteSubject'] as bool?,
      read: json['read'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$MailImplToJson(_$MailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'headers': instance.headers,
      'textContent': instance.textContent,
      'htmlContent': instance.htmlContent,
      'attachments': instance.attachments,
      'archived': instance.archived,
      'trashed': instance.trashed,
      'greylisted': instance.greylisted,
      'rejected': instance.rejected,
      'rewriteSubject': instance.rewriteSubject,
      'read': instance.read,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
