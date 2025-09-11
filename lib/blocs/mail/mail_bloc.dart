import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/services/mail_service.dart';
import 'package:mail/models/send_mail/send_mail.dart' as send_mail;

part 'mail_event.dart';
part 'mail_state.dart';

class MailBloc extends HydratedBloc<MailEvent, MailState> {
  final MailService _mailService = MailService();

  MailBloc() : super(MailInitial()) {
    on<LoadMails>(_onLoadMails);
    on<MarkAsRead>(_onMarkAsRead);
    on<MarkAsUnread>(_onMarkAsUnread);
    on<SyncMailActions>(_onSyncMailActions);
    on<SendMail>(_onSendMail);
    on<SaveDraft>(_onSaveDraft);
    on<GetDrafts>(_onGetDrafts);
    on<DeleteDraft>(_onDeleteDraft);
    on<UpdateDraft>(_onUpdateDraft);
  }

  @override
  MailState? fromJson(Map<String, dynamic> json) {
    if (json["mails"] != null) {
      return MailLoaded(
        (json["mails"] as List).map((e) => Mail.fromJson(e)).toList(),
        drafts: (json["drafts"] as List).map((e) => send_mail.SendMail.fromJson(e)).toList(),
      );
    }
    return MailInitial();
  }

  @override
  Map<String, dynamic>? toJson(MailState state) {
    if (state is MailLoaded && state.mails != null) {
      return {"mails": state.mails!.map((e) => e.toJson()).toList(), "drafts": state.drafts!.map((e) => e.toJson()).toList()};
    }
    return null;
  }

  void _onLoadMails(LoadMails event, Emitter<MailState> emit) async {
    final prevState = state;
    emit(MailLoading(prevState.mails ?? [],
        readMails: prevState.readMails,
        unreadMails: prevState.unreadMails,
        latestSync: prevState.latestSync,
        drafts: prevState.drafts,
        ));
    try {
      final mails = await _mailService.getAllMails();
      emit(MailLoaded(mails, drafts: prevState.drafts, latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails,));
    } catch (e) {
      emit(MailLoadingError(prevState.mails ?? [], e.toString(), latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,));
    }
  }

  void _onMarkAsRead(MarkAsRead event, Emitter<MailState> emit) async {
    final prevState = state;
    if (prevState.readMails.contains(event.mailId)) {
      return;
    }
    prevState.unreadMails.remove(event.mailId);
    prevState.readMails.add(event.mailId);
    emit(MailMarkAsReadSuccess(prevState.mails,
        latestSync: prevState.latestSync,
        readMails: state.readMails,
        unreadMails: state.unreadMails,
        drafts: state.drafts,
        ));
    add(SyncMailActions());
  }

  void _onMarkAsUnread(MarkAsUnread event, Emitter<MailState> emit) async {
    final prevState = state;
    if (prevState.unreadMails.contains(event.mailId)) {
      return;
    }
    prevState.readMails.remove(event.mailId);
    prevState.unreadMails.add(event.mailId);
    emit(MailMarkAsUnreadSuccess(prevState.mails,
        latestSync: prevState.latestSync,
        unreadMails: prevState.unreadMails,
        readMails: prevState.readMails,
        drafts: prevState.drafts,
        ));
    add(SyncMailActions());
  }

  void _onSyncMailActions(
      SyncMailActions event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      final MailSyncResult result = await _mailService.syncMailActions(
        readMailIds: state.readMails,
        unreadMailIds: state.unreadMails,
      );
      if (result.success) {
        state.readMails.clear();
        state.unreadMails.clear();
        emit(MailLoaded(prevState.mails ?? [], latestSync: DateTime.now(), readMails: state.readMails, unreadMails: state.unreadMails, drafts: state.drafts,));
      } else {
        emit(MailLoadingError(
            prevState.mails ?? [], result.message ?? "Unknown error", latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,));
      }
    } catch (e) {
      emit(MailLoadingError(prevState.mails ?? [], e.toString(), latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,));
    }
    add(const LoadMails());
  }

  void _onSendMail(SendMail event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      await _mailService.sendMail(event.mail);
      emit(MailSendSuccess(prevState.mails ?? [], latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,));
      add(const LoadMails());
    } catch (e) {
      emit(MailSendError(prevState.mails ?? [], e.toString(), latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,));
    }
  }

  void _onGetDrafts(GetDrafts event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      final drafts = await _mailService.getDrafts();
      emit(MailLoaded(prevState.mails ?? [], drafts: drafts, latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails,),);
    } catch (e) {
      emit(MailLoadingError(prevState.mails ?? [], e.toString(), latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,));
    }
  }

  FutureOr<void> _onSaveDraft(SaveDraft event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      await _mailService.saveDraft(event.mail);
      emit(MailSaveDraftSuccess(prevState.mails ?? [], latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,),);
    } catch (e) {
      emit(MailSaveDraftError(prevState.mails ?? [], e.toString(), latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,));
    }
  }

  FutureOr<void> _onDeleteDraft(DeleteDraft event, Emitter<MailState> emit) async{
    final prevState = state;
    try {
      await _mailService.deleteDraft(event.draftId);
      emit(MailDeleteDraftSuccess(prevState.mails ?? [], latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,),);
    } catch (e) {
      emit(MailDeleteDraftError(prevState.mails ?? [], e.toString(), latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,));
    }
  }

  FutureOr<void> _onUpdateDraft(UpdateDraft event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      await _mailService.updateDraft(event.mail, event.draftId);
      emit(MailUpdateDraftSuccess(prevState.mails ?? [], latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,),);
    } catch (e) {
      emit(MailUpdateDraftError(prevState.mails ?? [], e.toString(), latestSync: prevState.latestSync, readMails: prevState.readMails, unreadMails: prevState.unreadMails, drafts: prevState.drafts,));
    }
  }
}
