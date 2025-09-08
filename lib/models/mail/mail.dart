import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ab_shared/services/encryption.service.dart';
import 'package:mail/models/mail_attachment/mail_attachment.dart';

part 'mail.g.dart';
part 'mail.freezed.dart';

@unfreezed
class Mail with _$Mail {
  Mail._();

  factory Mail({
    String? id,
    required String userId,
    List<Map<String, dynamic>>? headers,
    String? textContent,
    String? htmlContent,
    List<MailAttachment>? attachments,
    bool? archived,
    bool? trashed,
    bool? greylisted,
    bool? rejected,
    bool? rewriteSubject,
    bool? read,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Mail;

  factory Mail.fromJson(Map<String, dynamic> json) => _$MailFromJson(json);

  static const nonEncryptedFields = [
    'id',
    'userId',
    'attachments',
    'archived',
    'trashed',
    'greylisted',
    'rejected',
    'rewriteSubject',
    'createdAt',
    'updatedAt',
  ];

  static const manualParseFields = [];

  @override
  String toString() {
    return 'Mail { id: $id, userId: $userId, headers: $headers, textContent: $textContent, htmlContent: $htmlContent, attachments: $attachments, archived: $archived, trashed: $trashed, greylisted: $greylisted, rejected: $rejected, rewriteSubject: $rewriteSubject, createdAt: $createdAt, updatedAt: $updatedAt }';
  }

  Future<Map<String, dynamic>> encrypt(
      {required EncryptionService encryptionService}) async {
    return {
      'id': id,
      'userId': userId,
      'headers': await encryptionService.encryptJson(headers),
      'textContent': await encryptionService.encryptJson(textContent),
      'htmlContent': await encryptionService.encryptJson(htmlContent),
      'attachments': attachments != null
          ? await Future.wait(
              attachments!.map((attachment) => attachment.encrypt(
                    encryptionService: encryptionService,
                  )),
            )
          : null,
      'archived': archived,
      'trashed': trashed,
      'greylisted': greylisted,
      'rejected': rejected,
      'rewriteSubject': rewriteSubject,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static Future<Mail> decrypt(
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

    // Handle attachments decryption separately
    if (decryptedData['attachments'] != null) {
      final attachmentsData = decryptedData['attachments'] as List;
      decryptedData['attachments'] = await Future.wait(
        attachmentsData.map((attachmentData) => MailAttachment.decrypt(
              attachmentData,
              encryptionService,
            )),
      );
    }

    final mail = Mail.fromJson(decryptedData);

    return mail;
  }

  String getHeader(String key) {
    if (headers == null) return '';
    try {
      final header = headers!.firstWhere(
        (header) => header['Key'].toString().toLowerCase() == key.toLowerCase(),
        orElse: () => {},
      );
      return header['Value'] ?? '';
    } catch (e) {
      return '';
    }
  }
}
