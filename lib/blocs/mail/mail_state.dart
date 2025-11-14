part of 'mail_bloc.dart';

sealed class MailState extends Equatable {
  final List<Mail>? mails;
  final List<send_mail.SendMail>? drafts;
  final List<send_mail.SendMail>? sentMails;
  final List<String> readMails;
  final List<String> unreadMails;
  final List<String> archivedMails;
  final List<String> unarchivedMails;
  final List<String> trashedMails;
  final List<String> untrashedMails;
  final DateTime? latestSync;
  MailState(this.mails,
      {this.latestSync,
      List<String>? readMails,
      List<String>? unreadMails,
      List<send_mail.SendMail>? drafts,
      List<send_mail.SendMail>? sentMails,
      List<String>? archivedMails,
      List<String>? unarchivedMails,
      List<String>? trashedMails,
      List<String>? untrashedMails})
      : readMails = readMails ?? [],
        unreadMails = unreadMails ?? [],
        drafts = drafts ?? [],
        sentMails = sentMails ?? [],
        archivedMails = archivedMails ?? [],
        unarchivedMails = unarchivedMails ?? [],
        trashedMails = trashedMails ?? [],
        untrashedMails = untrashedMails ?? [];

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        sentMails,
        archivedMails,
        unarchivedMails,
        trashedMails,
        untrashedMails
      ];

  /// Transforms one MailState to another while preserving all properties
  static T transform<T extends MailState>(
    T Function(
      List<Mail>? mails, {
      DateTime? latestSync,
      List<String>? readMails,
      List<String>? unreadMails,
      List<send_mail.SendMail>? drafts,
      List<send_mail.SendMail>? sentMails,
      List<String>? archivedMails,
      List<String>? unarchivedMails,
      List<String>? trashedMails,
      List<String>? untrashedMails,
    }) constructor,
    MailState fromState, {
    List<Mail>? mails,
    DateTime? latestSync,
    List<String>? readMails,
    List<String>? unreadMails,
    List<send_mail.SendMail>? drafts,
    List<send_mail.SendMail>? sentMails,
    List<String>? archivedMails,
    List<String>? unarchivedMails,
    List<String>? trashedMails,
    List<String>? untrashedMails,
  }) {
    return constructor(
      mails ?? fromState.mails,
      latestSync: latestSync ?? fromState.latestSync,
      readMails: readMails ?? fromState.readMails,
      sentMails: sentMails ?? fromState.sentMails,
      unreadMails: unreadMails ?? fromState.unreadMails,
      drafts: drafts ?? fromState.drafts,
      archivedMails: archivedMails ?? fromState.archivedMails,
      unarchivedMails: unarchivedMails ?? fromState.unarchivedMails,
      trashedMails: trashedMails ?? fromState.trashedMails,
      untrashedMails: untrashedMails ?? fromState.untrashedMails,
    );
  }

  /// Transforms one MailState to an error state while preserving all properties
  static T transformError<T extends MailState>(
      T Function(
        List<Mail>? mails,
        String message, {
        DateTime? latestSync,
        List<String>? readMails,
        List<String>? unreadMails,
        List<send_mail.SendMail>? drafts,
        List<send_mail.SendMail>? sentMails,
        List<String>? archivedMails,
        List<String>? unarchivedMails,
        List<String>? trashedMails,
        List<String>? untrashedMails,
      }) constructor,
      MailState fromState,
      String message) {
    return constructor(
      fromState.mails,
      message,
      latestSync: fromState.latestSync,
      sentMails: fromState.sentMails,
      readMails: fromState.readMails,
      unreadMails: fromState.unreadMails,
      drafts: fromState.drafts,
      archivedMails: fromState.archivedMails,
      unarchivedMails: fromState.unarchivedMails,
      trashedMails: fromState.trashedMails,
      untrashedMails: fromState.untrashedMails,
    );
  }
}

class MailInitial extends MailState {
  MailInitial()
      : super(null,
            readMails: [],
            unreadMails: [],
            sentMails: [],
            drafts: [],
            archivedMails: [],
            unarchivedMails: []);
}

class MailLoading extends MailState {
  MailLoading(super.mails,
      {super.readMails,
      super.unreadMails,
      super.latestSync,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
}

class MailLoaded extends MailState {
  MailLoaded(super.mails,
      {super.readMails,
      super.unreadMails,
      super.latestSync,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        drafts,
        sentMails,
        archivedMails,
        unarchivedMails,
        trashedMails,
        untrashedMails
      ];
}

class MailLoadingError extends MailState {
  MailLoadingError(super.mails, this.message,
      {super.readMails,
      super.unreadMails,
      super.latestSync,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props =>
      [message, latestSync, drafts, archivedMails, unarchivedMails];
}

class MailMarkAsReadSuccess extends MailState {
  MailMarkAsReadSuccess(super.mails,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailMarkAsReadError extends MailState {
  MailMarkAsReadError(super.mails, this.message,
      {super.latestSync,
      super.readMails,
      super.drafts,
      super.archivedMails,
      super.sentMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props =>
      [message, latestSync, readMails, drafts, archivedMails, unarchivedMails];
}

class MailMarkAsUnreadSuccess extends MailState {
  MailMarkAsUnreadSuccess(super.mails,
      {super.latestSync,
      super.unreadMails,
      super.readMails,
      super.drafts,
      super.archivedMails,
      super.unarchivedMails,
      super.sentMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props =>
      [mails, latestSync, unreadMails, drafts, archivedMails, unarchivedMails];
}

class MailMarkAsUnreadError extends MailState {
  MailMarkAsUnreadError(super.mails, this.message,
      {super.latestSync,
      super.unreadMails,
      super.drafts,
      super.archivedMails,
      super.unarchivedMails,
      super.sentMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props => [
        message,
        latestSync,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailSending extends MailState {
  MailSending(super.mails,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailSendSuccess extends MailState {
  MailSendSuccess(super.mails,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailSendError extends MailState {
  MailSendError(super.mails, this.message,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props => [
        message,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailSaveDraftSuccess extends MailState {
  MailSaveDraftSuccess(super.mails,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailSaveDraftError extends MailState {
  MailSaveDraftError(super.mails, this.message,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props => [
        message,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailDeleteDraftSuccess extends MailState {
  MailDeleteDraftSuccess(super.mails,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailDeleteDraftError extends MailState {
  MailDeleteDraftError(super.mails, this.message,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props => [
        message,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailUpdateDraftSuccess extends MailState {
  MailUpdateDraftSuccess(super.mails,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailUpdateDraftError extends MailState {
  MailUpdateDraftError(super.mails, this.message,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props => [
        message,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailArchiveSuccess extends MailState {
  MailArchiveSuccess(super.mails,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailArchiveError extends MailState {
  MailArchiveError(super.mails, this.message,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props => [
        message,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailUnarchiveSuccess extends MailState {
  MailUnarchiveSuccess(super.mails,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailUnarchiveError extends MailState {
  MailUnarchiveError(super.mails, this.message,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props => [
        message,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailTrashSuccess extends MailState {
  MailTrashSuccess(super.mails,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailTrashError extends MailState {
  MailTrashError(super.mails, this.message,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props => [
        message,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailUntrashSuccess extends MailState {
  MailUntrashSuccess(super.mails,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailUntrashError extends MailState {
  MailUntrashError(super.mails, this.message,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props => [
        message,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailEmptyTrashSuccess extends MailState {
  MailEmptyTrashSuccess(super.mails,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});

  @override
  List<Object?> get props => [
        mails,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}

class MailEmptyTrashError extends MailState {
  MailEmptyTrashError(super.mails, this.message,
      {super.latestSync,
      super.readMails,
      super.unreadMails,
      super.drafts,
      super.sentMails,
      super.archivedMails,
      super.unarchivedMails,
      super.trashedMails,
      super.untrashedMails});
  final String message;

  @override
  List<Object?> get props => [
        message,
        latestSync,
        readMails,
        unreadMails,
        drafts,
        archivedMails,
        unarchivedMails
      ];
}
