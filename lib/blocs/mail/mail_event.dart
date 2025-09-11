part of 'mail_bloc.dart';

sealed class MailEvent {
  const MailEvent();
}

final class LoadMails extends MailEvent {
  const LoadMails();
}

final class MarkAsRead extends MailEvent {
  const MarkAsRead(this.mailId);
  final String mailId;
}

final class MarkAsUnread extends MailEvent {
  const MarkAsUnread(this.mailId);
  final String mailId;
}

final class SyncMailActions extends MailEvent {
  const SyncMailActions();
}

final class SendMail extends MailEvent {
  const SendMail(this.mail);
  final Mail mail;
}

final class SaveDraft extends MailEvent {
  const SaveDraft(this.mail);
  final Mail mail;
}

final class GetDrafts extends MailEvent {
  const GetDrafts();
}

final class DeleteDraft extends MailEvent {
  const DeleteDraft(this.draftId);
  final String draftId;
}

final class UpdateDraft extends MailEvent {
  const UpdateDraft(this.mail, this.draftId);
  final String draftId;
  final Mail mail;
}