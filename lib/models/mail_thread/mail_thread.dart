import 'package:freezed_annotation/freezed_annotation.dart';

import '../mail/mail.dart';
import 'mail_thread_utils.dart';

part 'mail_thread.g.dart';
part 'mail_thread.freezed.dart';

@freezed
class MailThread with _$MailThread {
  MailThread._();
  factory MailThread({
    @Default(<Mail>[]) List<Mail> mails,
  }) = _MailThread;

  factory MailThread.fromJson(Map<String, dynamic> json) =>
      _$MailThreadFromJson(json);

  static MailThread reconstruct(List<Mail> mails, Mail targetMail) {
    return MailThreadUtils.reconstructThread(mails, targetMail);
  }
}
