// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_mail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SendMailImpl _$$SendMailImplFromJson(Map<String, dynamic> json) =>
    _$SendMailImpl(
      id: json['id'] as String?,
      mail: json['mail'] == null
          ? null
          : Mail.fromJson(json['mail'] as Map<String, dynamic>),
      sendStatus:
          $enumDecodeNullable(_$SendStatusEnumMap, json['sendStatus']) ??
              SendStatus.pending,
      retryCounter: (json['retryCounter'] as num?)?.toInt(),
      failureReason: json['failureReason'] as String?,
      failedAt: json['failedAt'] == null
          ? null
          : DateTime.parse(json['failedAt'] as String),
      trashed: json['trashed'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SendMailImplToJson(_$SendMailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mail': instance.mail,
      'sendStatus': _$SendStatusEnumMap[instance.sendStatus]!,
      'retryCounter': instance.retryCounter,
      'failureReason': instance.failureReason,
      'failedAt': instance.failedAt?.toIso8601String(),
      'trashed': instance.trashed,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$SendStatusEnumMap = {
  SendStatus.pending: 'pending',
  SendStatus.sent: 'sent',
  SendStatus.failed: 'failed',
  SendStatus.retry: 'retry',
};
