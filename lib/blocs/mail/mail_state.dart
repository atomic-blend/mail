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
      {List<String>? super.readMails,
      List<String>? super.unreadMails,
      DateTime? super.latestSync});
}

class MailLoaded extends MailState {
  MailLoaded(List<Mail> super.mails,
      {List<String>? super.readMails,
      List<String>? super.unreadMails,
      DateTime? super.latestSync});

  @override
  List<Object?> get props => [mails, latestSync];
}

class MailLoadingError extends MailState {
  MailLoadingError(List<Mail>? super.mails, this.message,
      {List<String>? super.readMails,
      List<String>? super.unreadMails,
      DateTime? super.latestSync});
  final String message;

  @override
  List<Object?> get props => [message, latestSync];
}

class MailMarkAsReadSuccess extends MailState {
  MailMarkAsReadSuccess(List<Mail>? super.mails,
      {DateTime? super.latestSync,
      List<String>? super.readMails,
      List<String>? super.unreadMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails];
}

class MailMarkAsReadError extends MailState {
  MailMarkAsReadError(List<Mail>? super.mails, this.message,
      {DateTime? super.latestSync, List<String>? super.readMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails];
}

class MailMarkAsUnreadSuccess extends MailState {
  MailMarkAsUnreadSuccess(List<Mail>? super.mails,
      {DateTime? super.latestSync,
      List<String>? super.unreadMails,
      List<String>? super.readMails});

  @override
  List<Object?> get props => [mails, latestSync, unreadMails];
}

class MailMarkAsUnreadError extends MailState {
  MailMarkAsUnreadError(List<Mail>? super.mails, this.message,
      {DateTime? super.latestSync, List<String>? super.unreadMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, unreadMails];
}
