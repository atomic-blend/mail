import 'package:mail/main.dart';
import 'package:mail/models/mail/mail.dart';

class MailSyncResult {
  final bool success;
  final String? message;

  MailSyncResult({required this.success, this.message});
}

class MailService {
  MailService();

  Future<List<Mail>> getAllMails({int page = 1, int size = 10}) async {
    final result = await globalApiClient?.get('/mail/?page=$page&size=$size');
    if (result != null && result.statusCode == 200) {
      final List<Mail> decryptedMails = [];
      final mails = result.data["mails"];

      for (var mail in (mails ?? [])) {
        final decryptedMail = await Mail.decrypt(
            mail as Map<String, dynamic>, encryptionService!);
        decryptedMails.add(decryptedMail);
      }
      return decryptedMails;
    } else {
      throw Exception('Failed to load mails');
    }
  }

  Future<MailSyncResult> syncMailActions(
      {required List<String> readMailIds,
      required List<String> unreadMailIds}) async {
    try {
      await globalApiClient?.put('/mail/actions', data: {
        'read': readMailIds,
        'unread': unreadMailIds,
      });
      return MailSyncResult(success: true);
    } catch (e) {
      return MailSyncResult(success: false, message: e.toString());
    }
  }

  Future<bool> sendMail(Mail mail) async {
    final result = await globalApiClient?.post('/mail/send', data: mail.toRawMail());
    if (result != null && result.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to send mail');
    }
  }

  Future<bool> saveDraft(Mail mail) async {
    final result = await globalApiClient?.post('/mail/draft', data: mail.toRawMail());
    if (result != null && result.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to save draft');
    }
  }

  Future<List<Mail>> getDrafts({int page = 1, int size = 10}) async {
    final result = await globalApiClient?.get('/mail/draft?page=$page&size=$size');
    if (result != null && result.statusCode == 200) {
      final List<Mail> decryptedDrafts = [];
      final drafts = result.data["draft_mails"];

      for (var draft in (drafts ?? [])) {
        final decryptedDraft = await Mail.decrypt(
            draft["mail"] as Map<String, dynamic>, encryptionService!);
            decryptedDraft.read = true;
        decryptedDrafts.add(decryptedDraft);
      }
      return decryptedDrafts;
    } else {
      throw Exception('Failed to get drafts');
    }
  }

  Future<bool> deleteDraft(String draftId) async {
    final result = await globalApiClient?.delete('/mail/draft/$draftId');
    if (result != null && result.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete draft');
    }
  }

  Future<bool> updateDraft(Mail mail) async {
    final result = await globalApiClient?.put('/mail/draft/${mail.id}', data: mail.toRawMail());
    if (result != null && result.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update draft');
    }
  }
}
