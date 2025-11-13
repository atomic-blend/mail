import 'package:ab_shared/services/encryption.service.dart';
import 'package:ab_shared/utils/api_client.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/models/send_mail/send_mail.dart' as send_mail;
import 'package:mail/utils/get_it.dart';

class MailSyncResult {
  final bool success;
  final String? message;

  MailSyncResult({required this.success, this.message});
}

class MailService {
  final globalApiClient = getIt<ApiClient>();
  final encryptionService = getIt<EncryptionService>();
  MailService();

  Future<List<Mail>> getAllMails({int page = 1, int size = 10}) async {
    final result = await globalApiClient.get('/mail/?page=$page&size=$size');
    if (result != null && result.statusCode == 200) {
      final List<Mail> decryptedMails = [];
      final mails = result.data["mails"];

      for (var mail in (mails ?? [])) {
        final decryptedMail =
            await Mail.decrypt(mail as Map<String, dynamic>, encryptionService);
        decryptedMails.add(decryptedMail);
      }
      return decryptedMails;
    } else {
      throw Exception('Failed to load mails');
    }
  }

  Future<Map<String, dynamic>> getAllMailsWithPagination(
      {int page = 1, int size = 10}) async {
    final result = await globalApiClient.get('/mail/?page=$page&size=$size');
    if (result != null && result.statusCode == 200) {
      final List<Mail> decryptedMails = [];
      final mails = result.data["mails"];

      for (var mail in (mails ?? [])) {
        final decryptedMail =
            await Mail.decrypt(mail as Map<String, dynamic>, encryptionService);
        decryptedMails.add(decryptedMail);
      }

      return {
        'mails': decryptedMails,
        'total_count': result.data['total_count'],
        'page': result.data['page'],
        'size': result.data['size'],
        'total_pages': result.data['total_pages'],
      };
    } else {
      throw Exception('Failed to load mails');
    }
  }

  Future<MailSyncResult> syncMailActions({
    required List<String> readMailIds,
    required List<String> unreadMailIds,
    required List<String> archivedMailIds,
    required List<String> unarchivedMailIds,
    required List<String> trashedMailIds,
    required List<String> untrashedMailIds,
  }) async {
    try {
      await globalApiClient.put('/mail/actions', data: {
        'read': readMailIds,
        'unread': unreadMailIds,
        'archived': archivedMailIds,
        'unarchived': unarchivedMailIds,
        'trashed': trashedMailIds,
        'untrashed': untrashedMailIds,
      });
      return MailSyncResult(success: true);
    } catch (e) {
      return MailSyncResult(success: false, message: e.toString());
    }
  }

  Future<bool> sendMail(Mail mail) async {
    final result =
        await globalApiClient.post('/mail/send', data: mail.toRawMail());
    if (result != null && result.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to send mail');
    }
  }

  Future<bool> saveDraft(Mail mail) async {
    final result =
        await globalApiClient.post('/mail/draft', data: mail.toRawMail());
    if (result != null && result.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to save draft');
    }
  }

  Future<List<send_mail.SendMail>> getDrafts(
      {int page = 1, int size = 10}) async {
    final result =
        await globalApiClient.get('/mail/draft?page=$page&size=$size');
    if (result != null && result.statusCode == 200) {
      final List<send_mail.SendMail> decryptedDrafts = [];
      final drafts = result.data["draft_mails"];

      for (var draft in (drafts ?? [])) {
        final decryptedDraft = await send_mail.SendMail.decrypt(
            draft as Map<String, dynamic>, encryptionService);
        decryptedDraft.mail!.read = true;
        decryptedDrafts.add(decryptedDraft);
      }
      return decryptedDrafts;
    } else {
      throw Exception('Failed to get drafts');
    }
  }

  Future<bool> deleteDraft(String draftId) async {
    final result = await globalApiClient.delete('/mail/draft/$draftId');
    if (result != null && result.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete draft');
    }
  }

  Future<bool> updateDraft(Mail mail, String draftId) async {
    final result = await globalApiClient.put('/mail/draft/$draftId',
        data: mail.toRawMail());
    if (result != null && result.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update draft');
    }
  }

  Future<bool> emptyTrash() async {
    final result = await globalApiClient.post('/mail/trash/empty');
    if (result != null && result.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to empty trash');
    }
  }

  Future<Map<String, dynamic>> getMailsSince({
    required DateTime since,
    int page = 1,
    int size = 10,
  }) async {
    final sinceFormatted =
        since.toUtc().toIso8601String().replaceAll('.000Z', 'Z');
    final result = await globalApiClient
        .get('/mail/since?since=$sinceFormatted&page=$page&size=$size');

    if (result != null && result.statusCode == 200) {
      final List<Mail> decryptedMails = [];
      final mails = result.data["mails"];

      for (var mail in (mails ?? [])) {
        final decryptedMail =
            await Mail.decrypt(mail as Map<String, dynamic>, encryptionService);
        decryptedMails.add(decryptedMail);
      }

      return {
        'mails': decryptedMails,
        'total_count': result.data['total_count'],
        'page': result.data['page'],
        'size': result.data['size'],
        'total_pages': result.data['total_pages'],
      };
    } else {
      throw Exception('Failed to load mails since $sinceFormatted');
    }
  }

  Future<Map<String, dynamic>> getDraftsSince({
    required DateTime since,
    int page = 1,
    int size = 10,
  }) async {
    final sinceFormatted =
        since.toUtc().toIso8601String().replaceAll('.000Z', 'Z');
    final result = await globalApiClient
        .get('/mail/draft/since?since=$sinceFormatted&page=$page&size=$size');

    if (result != null && result.statusCode == 200) {
      final List<send_mail.SendMail> decryptedDrafts = [];
      final drafts = result.data["draft_mails"];

      for (var draft in (drafts ?? [])) {
        final decryptedDraft = await send_mail.SendMail.decrypt(
            draft as Map<String, dynamic>, encryptionService);
        decryptedDraft.mail!.read = true;
        decryptedDrafts.add(decryptedDraft);
      }

      return {
        'drafts': decryptedDrafts,
        'total_count': result.data['total_count'],
        'page': result.data['page'],
        'size': result.data['size'],
        'total_pages': result.data['total_pages'],
      };
    } else {
      throw Exception('Failed to load drafts since $sinceFormatted');
    }
  }

  Future<List<send_mail.SendMail>> getSent(
      {int page = 1, int size = 10}) async {
    final result =
        await globalApiClient.get('/mail/send?page=$page&size=$size');
    if (result != null && result.statusCode == 200) {
      final List<send_mail.SendMail> decryptedSent = [];
      final sentMails = result.data["sent_mails"];

      for (var sent in (sentMails ?? [])) {
        final decryptedSentMail = await send_mail.SendMail.decrypt(
            sent as Map<String, dynamic>, encryptionService);
        decryptedSent.add(decryptedSentMail);
      }
      return decryptedSent;
    } else {
      throw Exception('Failed to get sent mails');
    }
  }

  Future<Map<String, dynamic>> getSentSince({
    required DateTime since,
    int page = 1,
    int size = 10,
  }) async {
    final sinceFormatted =
        since.toUtc().toIso8601String().replaceAll('.000Z', 'Z');
    final result = await globalApiClient
        .get('/mail/send/since?since=$sinceFormatted&page=$page&size=$size');

    if (result != null && result.statusCode == 200) {
      final List<send_mail.SendMail> decryptedSent = [];
      final sentMails = result.data["sent_mails"];

      for (var sent in (sentMails ?? [])) {
        final decryptedSentMail = await send_mail.SendMail.decrypt(
            sent as Map<String, dynamic>, encryptionService);
        decryptedSent.add(decryptedSentMail);
      }

      return {
        'sent_mails': decryptedSent,
        'total_count': result.data['total_count'],
        'page': result.data['page'],
        'size': result.data['size'],
        'total_pages': result.data['total_pages'],
      };
    } else {
      throw Exception('Failed to load sent mails since $sinceFormatted');
    }
  }
}
