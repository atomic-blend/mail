import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ab_shared/services/encryption.service.dart';

part 'mail_attachment.g.dart';
part 'mail_attachment.freezed.dart';

@unfreezed
class MailAttachment with _$MailAttachment {
  MailAttachment._();

  factory MailAttachment({
    required String filename,
    required String contentType,
    required String storagePath,
    required String storageType,
    required int size,
  }) = _MailAttachment;

  factory MailAttachment.fromJson(Map<String, dynamic> json) =>
      _$MailAttachmentFromJson(json);

  static const nonEncryptedFields = [
    'size',
  ];

  static const manualParseFields = [];

  @override
  String toString() {
    return 'MailAttachment { filename: $filename, contentType: $contentType, storagePath: $storagePath, storageType: $storageType, size: $size }';
  }

  Future<Map<String, dynamic>> encrypt(
      {required EncryptionService encryptionService}) async {
    return {
      'filename': await encryptionService.encryptJson(filename),
      'contentType': await encryptionService.encryptJson(contentType),
      'storagePath': await encryptionService.encryptJson(storagePath),
      'storageType': await encryptionService.encryptJson(storageType),
      'size': size,
    };
  }

  static Future<MailAttachment> decrypt(
    Map<String, dynamic> data,
    EncryptionService encryptionService,
  ) async {
    Map<String, dynamic> decryptedData = {};

    for (var entry in data.entries) {
      if (nonEncryptedFields.contains(entry.key) ||
          manualParseFields.contains(entry.key)) {
        decryptedData[entry.key] = entry.value;
      } else {
        decryptedData[entry.key] =
            await encryptionService.decryptJson(entry.value);
      }
    }

    final attachment = MailAttachment.fromJson(decryptedData);

    return attachment;
  }
}
