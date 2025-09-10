part of 'mail_bloc.dart';

sealed class MailState extends Equatable {
  final List<Mail>? mails;
  final List<String> readMails;
  final List<String> unreadMails;
  final DateTime? latestSync;
  MailState(this.mails,
      {this.latestSync, List<String>? readMails, List<String>? unreadMails})
      : readMails = readMails ?? [],
        unreadMails = unreadMails ?? [];

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails];
}

class MailInitial extends MailState {
  MailInitial() : super(null, readMails: [], unreadMails: []);
}

class MailLoading extends MailState {
  MailLoading(List<Mail> super.mails,
      {super.readMails, super.unreadMails, super.latestSync});
}

class MailLoaded extends MailState {
  MailLoaded(List<Mail> super.mails,
      {super.readMails, super.unreadMails, super.latestSync});

  @override
  List<Object?> get props => [mails, latestSync];
}

class MailLoadingError extends MailState {
  MailLoadingError(super.mails, this.message,
      {super.readMails, super.unreadMails, super.latestSync});
  final String message;

  @override
  List<Object?> get props => [message, latestSync];
}

class MailMarkAsReadSuccess extends MailState {
  MailMarkAsReadSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails];
}

class MailMarkAsReadError extends MailState {
  MailMarkAsReadError(super.mails, this.message,
      {super.latestSync, super.readMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails];
}

class MailMarkAsUnreadSuccess extends MailState {
  MailMarkAsUnreadSuccess(super.mails,
      {super.latestSync, super.unreadMails, super.readMails});

  @override
  List<Object?> get props => [mails, latestSync, unreadMails];
}

class MailMarkAsUnreadError extends MailState {
  MailMarkAsUnreadError(super.mails, this.message,
      {super.latestSync, super.unreadMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, unreadMails];
}

class MailSendSuccess extends MailState {
  MailSendSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails];
}

class MailSendError extends MailState { 
  MailSendError(super.mails, this.message,
      {super.latestSync, super.readMails, super.unreadMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, unreadMails];
}