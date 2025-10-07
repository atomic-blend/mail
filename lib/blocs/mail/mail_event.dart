part of 'mail_bloc.dart';

sealed class MailEvent {
  const MailEvent();
}

final class LoadMails extends MailEvent {
  const LoadMails();
}

final class MarkAsRead extends MailEvent {
  const MarkAsRead({this.mailId, this.mailIds});
  final String? mailId;
  final List<String>? mailIds;
}

final class MarkAsUnread extends MailEvent {
  const MarkAsUnread({this.mailId, this.mailIds});
  final String? mailId;
  final List<String>? mailIds;
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

final class DeleteDraft extends MailEvent {
  const DeleteDraft(this.draftId,);
  final String draftId;
}

final class UpdateDraft extends MailEvent {
  const UpdateDraft(this.mail, this.draftId);
  final String draftId;
  final Mail mail;
}

final class ArchiveMail extends MailEvent {
  const ArchiveMail({this.mailId, this.mailIds});
  final List<String>? mailIds;
  final String? mailId;
}

final class UnarchiveMail extends MailEvent {
  const UnarchiveMail({this.mailId, this.mailIds});
  final List<String>? mailIds;
  final String? mailId;
}

final class TrashMail extends MailEvent {
  const TrashMail({this.mailId, this.mailIds});
  final List<String>? mailIds;
  final String? mailId;
}

final class UntrashMail extends MailEvent {
  const UntrashMail({this.mailId, this.mailIds});
  final List<String>? mailIds;
  final String? mailId;
}

final class EmptyTrash extends MailEvent {
  const EmptyTrash();
}