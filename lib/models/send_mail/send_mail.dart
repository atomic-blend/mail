import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ab_shared/services/encryption.service.dart';
import 'package:mail/models/mail/mail.dart';

part 'send_mail.g.dart';
part 'send_mail.freezed.dart';

// SendStatus represents the status of a sent mail
enum SendStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('sent')
  sent,
  @JsonValue('failed')
  failed,
  @JsonValue('retry')
  retry,
}

@unfreezed
class SendMail with _$SendMail {
  SendMail._();

  factory SendMail({
    String? id,
    Mail? mail,
    @Default(SendStatus.pending) SendStatus sendStatus,
    int? retryCounter,
    String? failureReason,
    DateTime? failedAt,
    @Default(false) bool trashed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SendMail;

  factory SendMail.fromJson(Map<String, dynamic> json) => _$SendMailFromJson(json);

  static const nonEncryptedFields = [
    'id',
    'userId',
    'send_status',
    'retry_counter',
    'failure_reason',
    'failed_at',
    'trashed',
    'created_at',
    'updated_at',
  ];

  static const manualParseFields = ['mail'];

  @override
  String toString() {
    return 'SendMail { id: $id, mail: $mail, sendStatus: $sendStatus, retryCounter: $retryCounter, failureReason: $failureReason, failedAt: $failedAt, trashed: $trashed, createdAt: $createdAt, updatedAt: $updatedAt }';
  }

  Future<Map<String, dynamic>> encrypt(
      {required EncryptionService encryptionService}) async {
    return {
      'id': id,
      'mail': mail != null
          ? await mail!.encrypt(encryptionService: encryptionService)
          : null,
      'sendStatus': sendStatus.name,
      'retryCounter': retryCounter,
      'failureReason': failureReason,
      'failedAt': failedAt?.toIso8601String(),
      'trashed': trashed,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static Future<SendMail> decrypt(
    Map<String, dynamic> data,
    EncryptionService encryptionService,
  ) async {
    Map<String, dynamic> decryptedData = {};
    Mail decryptedMail = Mail();

    for (var entry in data.entries) {
      if (nonEncryptedFields.contains(entry.key)) {
        decryptedData[entry.key] = entry.value;
      } else if (manualParseFields.contains(entry.key)) {
        // Handle mail decryption separately
        if (entry.key == 'mail' && entry.value != null) {
          decryptedMail = await Mail.decrypt(
            entry.value as Map<String, dynamic>,
            encryptionService,
          );
        }
      } else {
        decryptedData[entry.key] =
            await encryptionService.decryptJson(entry.value);
      }
    }

    // Convert sendStatus string back to enum
    if (decryptedData['send_status'] is String) {
      decryptedData['send_status'] = SendStatus.values.firstWhere(
        (status) => status.name == decryptedData['sendStatus'],
        orElse: () => SendStatus.pending,
      );
    }

    final sendMail = SendMail.fromJson(decryptedData);

    sendMail.mail = decryptedMail;

    return sendMail;
  }
}
