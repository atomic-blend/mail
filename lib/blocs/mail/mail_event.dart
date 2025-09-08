part of 'mail_bloc.dart';


sealed class MailEvent {
  const MailEvent();
}

final class LoadMails extends MailEvent {
  const LoadMails();
}
