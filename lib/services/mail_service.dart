import 'package:mail/main.dart';
import 'package:mail/models/mail/mail.dart';

class MailService {
  MailService();

  Future<List<Mail>> getAllMails({int page = 1, int size = 10}) async {
    final result = await globalApiClient?.get('/mails/?page=$page&size=$size');
    if (result != null && result.statusCode == 200) {
      final List<Mail> mails = [];

      for (var mail in (result.data ?? [])) {
        final decryptedMail = await Mail.decrypt(
            mail as Map<String, dynamic>, encryptionService!);
        mails.add(decryptedMail);
      }

      return mails;
    } else {
      throw Exception('Failed to load mails');
    }
  }
}
