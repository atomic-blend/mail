import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ab_shared/services/encryption.service.dart';
import 'package:mail/models/mail_attachment/mail_attachment.dart';

part 'mail.g.dart';
part 'mail.freezed.dart';

@unfreezed
class Mail with _$Mail {
  Mail._();

  Map<String, dynamic> toRawMail() {
    // convert headers from list of maps to a single map where Key is the key and Value is the value
    return {
      "textContent": textContent,
      "htmlContent": htmlContent,
      "headers": headers,
      "inReplyTo": inReplyTo,
      "createdAt": createdAt?.toIso8601String(),
    };
  }

  factory Mail({
    String? id,
    String? userId,
    Map<String, dynamic>? headers,
    String? textContent,
    String? htmlContent,
    String? inReplyTo,
    List<MailAttachment>? attachments,
    bool? archived,
    bool? trashed,
    bool? greylisted,
    bool? rejected,
    bool? rewriteSubject,
    bool? read,
    DateTime? trashedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Mail;

  factory Mail.fromJson(Map<String, dynamic> json) => _$MailFromJson(json);

  static const nonEncryptedFields = [
    'id',
    'userId',
    'attachments',
    'archived',
    'read',
    'inReplyTo',
    'trashed',
    'greylisted',
    'rejected',
    'rewriteSubject',
    'trashedAt',
    'createdAt',
    'updatedAt',
  ];

  static const manualParseFields = [];

  @override
  String toString() {
    return 'Mail { id: $id, userId: $userId, headers: $headers, inReplyTo: $inReplyTo, textContent: $textContent, htmlContent: $htmlContent, attachments: $attachments, archived: $archived, trashed: $trashed, trashedAt: $trashedAt, greylisted: $greylisted, rejected: $rejected, rewriteSubject: $rewriteSubject, createdAt: $createdAt, updatedAt: $updatedAt }';
  }

  bool search(String query) {
    bool isMatch = false;
    if (textContent?.toLowerCase().contains(query.toLowerCase()) ?? false) {
      isMatch = true;
    }
    if (htmlContent?.toLowerCase().contains(query.toLowerCase()) ?? false) {
      isMatch = true;
    }
    if (headers?.containsKey('Subject') == true &&
        headers!['Subject']?.toLowerCase().contains(query.toLowerCase()) ==
            true) {
      isMatch = true;
    }
    if (headers?.containsKey('From') == true &&
        headers!['From']?.toLowerCase().contains(query.toLowerCase()) == true) {
      isMatch = true;
    }
    if (headers?.containsKey('To') == true &&
        headers!['To']?.toLowerCase().contains(query.toLowerCase()) == true) {
      isMatch = true;
    }
    if (attachments?.any((attachment) =>
            attachment.filename.toLowerCase().contains(query.toLowerCase())) ??
        false) {
      isMatch = true;
    }
    return isMatch;
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
      'trashedAt': trashedAt?.toIso8601String(),
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

  dynamic getHeader(String key) {
    if (headers == null) return '';
    try {
      final header = headers![key];
      if (header != null) {
        return header;
      }
      return '';
    } catch (e) {
      return '';
    }
  }
}
