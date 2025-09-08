import 'package:ab_shared/entities/sync/sync_result/sync_result.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/services/mail_service.dart';

part 'mail_event.dart';
part 'mail_state.dart';

class MailBloc extends HydratedBloc<MailEvent, MailState> {
  final MailService _mailService = MailService();

  MailBloc() : super(const MailInitial()) {
    on<LoadMails>(_onLoadMails);
    on<MarkAsRead>(_onMarkAsRead);
    on<MarkAsUnread>(_onMarkAsUnread);
    on<SyncMailActions>(_onSyncMailActions);
  }

  @override
  MailState? fromJson(Map<String, dynamic> json) {
    if (json["mails"] != null) {
      return MailLoaded(
        (json["mails"] as List).map((e) => Mail.fromJson(e)).toList(),
      );
    }
    return const MailInitial();
  }

  @override
  Map<String, dynamic>? toJson(MailState state) {
    if (state is MailLoaded && state.mails != null) {
      return {"mails": state.mails!.map((e) => e.toJson()).toList()};
    }
    return null;
  }

  void _onLoadMails(LoadMails event, Emitter<MailState> emit) async {
    final prevState = state;
    emit(const MailLoading());
    try {
      final mails = await _mailService.getAllMails();
      emit(MailLoaded(mails));
    } catch (e) {
      emit(MailLoadingError(prevState.mails ?? [], e.toString()));
    }
  }

  void _onMarkAsRead(MarkAsRead event, Emitter<MailState> emit) async {
    final prevState = state;
    if (state.readMails != null && state.readMails!.contains(event.mailId)) {
      return;
    }
    state.readMails?.add(event.mailId);
    emit(MailMarkAsReadSuccess(prevState.mails, latestSync: prevState.latestSync, readMails: state.readMails));
    add(SyncMailActions());
  }

  void _onMarkAsUnread(MarkAsUnread event, Emitter<MailState> emit) async {
    final prevState = state;
    if (state.readMails == null || !state.readMails!.contains(event.mailId)) {
      return;
    }
    state.readMails?.remove(event.mailId);
    state.unreadMails?.add(event.mailId);
    emit(MailMarkAsUnreadSuccess(prevState.mails, latestSync: prevState.latestSync, unreadMails: state.unreadMails));
    add(SyncMailActions());
  }

  void _onSyncMailActions(SyncMailActions event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      final MailSyncResult result = await _mailService.syncMailActions(
        readMailIds: state.readMails ?? [],
        unreadMailIds: state.unreadMails ?? [],
      );
      if (result.success) {
        emit(MailLoaded(prevState.mails ?? [], latestSync: DateTime.now()));
        state.readMails?.clear();
        state.unreadMails?.clear();
      } else {
        emit(MailLoadingError(prevState.mails ?? [], result.message ?? "Unknown error"));
      }
    } catch (e) {
      emit(MailLoadingError(prevState.mails ?? [], e.toString()));
    }
  }
}
