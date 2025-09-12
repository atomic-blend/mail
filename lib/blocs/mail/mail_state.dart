part of 'mail_bloc.dart';

sealed class MailState extends Equatable {
  final List<Mail>? mails;
  final List<send_mail.SendMail>? drafts;
  final List<String> readMails;
  final List<String> unreadMails;
  final List<String> archivedMails;
  final List<String> unarchivedMails;
  final DateTime? latestSync;
  MailState(this.mails,
      {this.latestSync, List<String>? readMails, List<String>? unreadMails, List<send_mail.SendMail>? drafts, List<String>? archivedMails, List<String>? unarchivedMails})
      : readMails = readMails ?? [],
        unreadMails = unreadMails ?? [],
        drafts = drafts ?? [],
        archivedMails = archivedMails ?? [],
        unarchivedMails = unarchivedMails ?? [];

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailInitial extends MailState {
  MailInitial() : super(null, readMails: [], unreadMails: [], drafts: [], archivedMails: [], unarchivedMails: []);
}

class MailLoading extends MailState {
  MailLoading(List<Mail> super.mails,
      {super.readMails, super.unreadMails, super.latestSync, super.drafts, super.archivedMails, super.unarchivedMails});
}

class MailLoaded extends MailState {
  MailLoaded(List<Mail> super.mails,
      {super.readMails, super.unreadMails, super.latestSync, super.drafts, super.archivedMails, super.unarchivedMails});

  @override
  List<Object?> get props => [mails, latestSync, drafts, archivedMails, unarchivedMails];
}

class MailLoadingError extends MailState {
  MailLoadingError(super.mails, this.message,
      {super.readMails, super.unreadMails, super.latestSync, super.drafts, super.archivedMails, super.unarchivedMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, drafts, archivedMails, unarchivedMails];
}

class MailMarkAsReadSuccess extends MailState {
  MailMarkAsReadSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailMarkAsReadError extends MailState {
  MailMarkAsReadError(super.mails, this.message,
      {super.latestSync, super.readMails, super.drafts, super.archivedMails, super.unarchivedMails  });
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, drafts, archivedMails, unarchivedMails];
}

class MailMarkAsUnreadSuccess extends MailState {
  MailMarkAsUnreadSuccess(super.mails,
      {super.latestSync, super.unreadMails, super.readMails, super.drafts, super.archivedMails, super.unarchivedMails});

  @override
  List<Object?> get props => [mails, latestSync, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailMarkAsUnreadError extends MailState {
  MailMarkAsUnreadError(super.mails, this.message,
      {super.latestSync, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailSendSuccess extends MailState {
  MailSendSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailSendError extends MailState { 
  MailSendError(super.mails, this.message,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailSaveDraftSuccess extends MailState {
  MailSaveDraftSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailSaveDraftError extends MailState {
  MailSaveDraftError(super.mails, this.message,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails });
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailDeleteDraftSuccess extends MailState {
  MailDeleteDraftSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailDeleteDraftError extends MailState {  
  MailDeleteDraftError(super.mails, this.message,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailUpdateDraftSuccess extends MailState {
  MailUpdateDraftSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailUpdateDraftError extends MailState {
  MailUpdateDraftError(super.mails, this.message,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailArchiveSuccess extends MailState {
  MailArchiveSuccess(super.mails,
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailArchiveError extends MailState {  
  MailArchiveError(super.mails, this.message, 
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailUnarchiveSuccess extends MailState {
  MailUnarchiveSuccess(super.mails, 
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});

  @override
  List<Object?> get props => [mails, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailUnarchiveError extends MailState {  
  MailUnarchiveError(super.mails, this.message, 
      {super.latestSync, super.readMails, super.unreadMails, super.drafts, super.archivedMails, super.unarchivedMails});
  final String message;

  @override
  List<Object?> get props => [message, latestSync, readMails, unreadMails, drafts, archivedMails, unarchivedMails];
}