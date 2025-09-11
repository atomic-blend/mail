part of 'mail_bloc.dart';

sealed class MailState extends Equatable {
  final List<Mail>? mails;
  final List<Mail>? drafts;
  final List<String> readMails;
  final List<String> unreadMails;
  final DateTime? latestSync;
  MailState(this.mails,
      {this.latestSync, List<String>? readMails, List<String>? unreadMails, List<Mail>? drafts})
      : readMails = readMails ?? [],
        unreadMails = unreadMails ?? [],
        drafts = drafts ?? [];

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts];
}

class MailInitial extends MailState {
  MailInitial() : super(null, readMails: [], unreadMails: [], drafts: []);
}

class MailLoading extends MailState {
  MailLoading(List<Mail> super.mails,
      {super.readMails, super.unreadMails, super.latestSync, super.drafts});
}

class MailLoaded extends MailState {
  MailLoaded(List<Mail> super.mails,
      {super.readMails, super.unreadMails, super.latestSync, super.drafts});

  @override
  List<Object?> get props => [mails, latestSync, drafts];
}

class MailLoadingError extends MailState {
  MailLoadingError(super.mails, this.message,
      {super.readMails, super.unreadMails, super.latestSync, super.drafts});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, drafts];
}

class MailMarkAsReadSuccess extends MailState {
  MailMarkAsReadSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts];
}

class MailMarkAsReadError extends MailState {
  MailMarkAsReadError(super.mails, this.message,
      {super.latestSync, super.readMails, super.drafts});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, drafts];
}

class MailMarkAsUnreadSuccess extends MailState {
  MailMarkAsUnreadSuccess(super.mails,
      {super.latestSync, super.unreadMails, super.readMails, super.drafts});

  @override
  List<Object?> get props => [mails, latestSync, unreadMails, drafts];
}

class MailMarkAsUnreadError extends MailState {
  MailMarkAsUnreadError(super.mails, this.message,
      {super.latestSync, super.unreadMails, super.drafts});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, unreadMails, drafts];
}

class MailSendSuccess extends MailState {
  MailSendSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts];
}

class MailSendError extends MailState { 
  MailSendError(super.mails, this.message,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, unreadMails, drafts];
}

class MailSaveDraftSuccess extends MailState {
  MailSaveDraftSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts ];
}

class MailSaveDraftError extends MailState {
  MailSaveDraftError(super.mails, this.message,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, unreadMails, drafts];
}

class MailDeleteDraftSuccess extends MailState {
  MailDeleteDraftSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts];
}

class MailDeleteDraftError extends MailState {  
  MailDeleteDraftError(super.mails, this.message,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, unreadMails, drafts];
}

class MailUpdateDraftSuccess extends MailState {
  MailUpdateDraftSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts];
}

class MailUpdateDraftError extends MailState {
  MailUpdateDraftError(super.mails, this.message,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, unreadMails, drafts];
}