part of 'mail_bloc.dart';

sealed class MailState extends Equatable {
  final List<Mail>? mails;
  final List<String>? readMails;
  final List<String>? unreadMails;
  final DateTime? latestSync;
  const MailState(this.mails,
      {this.latestSync, this.readMails, this.unreadMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails];
}

class MailInitial extends MailState {
  const MailInitial() : super(null);
}

class MailLoading extends MailState {
  const MailLoading() : super(null);
}

class MailLoaded extends MailState {
  const MailLoaded(List<Mail> super.mails, {super.latestSync});

  @override
  List<Object?> get props => [mails, latestSync];
}

class MailLoadingError extends MailState {
  const MailLoadingError(super.mails, this.message);
  final String message;

  @override
  List<Object?> get props => [message, latestSync];
}

class MailMarkAsReadSuccess extends MailState {
  const MailMarkAsReadSuccess(List<Mail>? super.mails,
      {super.latestSync, super.readMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails];
}

class MailMarkAsReadError extends MailState {
  const MailMarkAsReadError(List<Mail>? super.mails, this.message,
      {super.latestSync, super.readMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails];
}

class MailMarkAsUnreadSuccess extends MailState {
  const MailMarkAsUnreadSuccess(List<Mail>? super.mails,
      {super.latestSync, super.unreadMails});

  @override
  List<Object?> get props => [mails, latestSync, unreadMails];
} 

class MailMarkAsUnreadError extends MailState {
  const MailMarkAsUnreadError(List<Mail>? super.mails, this.message,
      {super.latestSync, super.unreadMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, unreadMails];
}
