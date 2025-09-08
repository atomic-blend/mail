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