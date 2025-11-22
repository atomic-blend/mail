// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail_thread.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MailThreadImpl _$$MailThreadImplFromJson(Map<String, dynamic> json) =>
    _$MailThreadImpl(
      mails: (json['mails'] as List<dynamic>?)
              ?.map((e) => Mail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Mail>[],
    );

Map<String, dynamic> _$$MailThreadImplToJson(_$MailThreadImpl instance) =>
    <String, dynamic>{
      'mails': instance.mails,
    };
