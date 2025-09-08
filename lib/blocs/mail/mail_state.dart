part of 'mail_bloc.dart';

sealed class MailState extends Equatable {
  final List<Mail>? mails;
  final SyncResult? latestSync;
  const MailState(this.mails, {this.latestSync  });

  @override
  List<Object?> get props => [mails, latestSync];
}

class MailInitial extends MailState {
  const MailInitial() : super(null);
}

class MailLoading extends MailState {
  const MailLoading() : super(null    );
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
