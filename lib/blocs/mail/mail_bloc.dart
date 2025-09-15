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
    on<DeleteDraft>(_onDeleteDraft);
    on<UpdateDraft>(_onUpdateDraft);
    on<ArchiveMail>(_onArchiveMail);
    on<UnarchiveMail>(_onUnarchiveMail);
    on<TrashMail>(_onTrashMail);
    on<UntrashMail>(_onUntrashMail);
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
    emit(MailState.transform(MailLoading.new, prevState));
    try {
      final mails = await _mailService.getAllMails();
      final drafts = await _mailService.getDrafts();
      final newState = MailState.transform(MailLoaded.new, prevState, mails: mails, drafts: drafts);
      
      emit(newState);
    } catch (e) {
      emit(MailState.transformError(MailLoadingError.new, prevState, e.toString()));
    }
  }

  void _onMarkAsRead(MarkAsRead event, Emitter<MailState> emit) async {
    final prevState = state;
    if (prevState.readMails.contains(event.mailId)) {
      return;
    }
    prevState.unreadMails.remove(event.mailId);
    prevState.readMails.add(event.mailId);
    emit(MailState.transform(MailMarkAsReadSuccess.new, prevState));
    add(SyncMailActions());
  }

  void _onMarkAsUnread(MarkAsUnread event, Emitter<MailState> emit) async {
    final prevState = state;
    if (prevState.unreadMails.contains(event.mailId)) {
      return;
    }
    prevState.readMails.remove(event.mailId);
    prevState.unreadMails.add(event.mailId);
    emit(MailState.transform(MailMarkAsUnreadSuccess.new, prevState));
    add(SyncMailActions());
  }

  void _onSyncMailActions(
      SyncMailActions event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      final MailSyncResult result = await _mailService.syncMailActions(
        readMailIds: state.readMails,
        unreadMailIds: state.unreadMails,
        archivedMailIds: state.archivedMails,
        unarchivedMailIds: state.unarchivedMails,
        trashedMailIds: state.trashedMails,
        untrashedMailIds: state.untrashedMails,
      );
      if (result.success) {
        state.readMails.clear();
        state.unreadMails.clear();
        emit(MailState.transform(MailLoaded.new, prevState));
      } else {
        emit(MailState.transformError(MailLoadingError.new, prevState, result.message ?? "Unknown error"));
      }
    } catch (e) {
      emit(MailState.transformError(MailLoadingError.new, prevState, e.toString()));
    }
    add(const LoadMails());
  }

  void _onSendMail(SendMail event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      await _mailService.sendMail(event.mail);
      emit(MailState.transform(MailSendSuccess.new, prevState));
      add(const LoadMails());
    } catch (e) {
      emit(MailState.transformError(MailSendError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onSaveDraft(SaveDraft event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      await _mailService.saveDraft(event.mail);
      emit(MailState.transform(MailSaveDraftSuccess.new, prevState));
      add(const LoadMails());
    } catch (e) {
      emit(MailState.transformError(MailSaveDraftError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onDeleteDraft(DeleteDraft event, Emitter<MailState> emit) async{
    final prevState = state;
    try {
      await _mailService.deleteDraft(event.draftId);
      emit(MailState.transform(MailDeleteDraftSuccess.new, prevState));
      add(const LoadMails());
    } catch (e) {
      emit(MailState.transformError(MailDeleteDraftError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onUpdateDraft(UpdateDraft event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      await _mailService.updateDraft(event.mail, event.draftId);
      emit(MailState.transform(MailUpdateDraftSuccess.new, prevState));
      add(const LoadMails());
    } catch (e) {
      emit(MailState.transformError(MailUpdateDraftError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onArchiveMail(ArchiveMail event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      if (prevState.archivedMails.contains(event.mailId)) {
        return;
      }
      prevState.unarchivedMails.remove(event.mailId);
      prevState.archivedMails.add(event.mailId);
      emit(MailState.transform(MailArchiveSuccess.new, prevState));
      add(SyncMailActions());
    } catch (e) {
      emit(MailState.transformError(MailArchiveError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onUnarchiveMail(UnarchiveMail event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      if (prevState.unarchivedMails.contains(event.mailId)) {
        return;
      }
      prevState.archivedMails.remove(event.mailId);
      prevState.unarchivedMails.add(event.mailId);
      emit(MailState.transform(MailUnarchiveSuccess.new, prevState));
      add(SyncMailActions());
    } catch (e) {
      emit(MailState.transformError(MailUnarchiveError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onTrashMail(TrashMail event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      if (prevState.trashedMails.contains(event.mailId)) {
        return;
      }
      prevState.untrashedMails.remove(event.mailId);
      prevState.trashedMails.add(event.mailId);
      emit(MailState.transform(MailTrashSuccess.new, prevState));
      add(SyncMailActions());
    } catch (e) {
      emit(MailState.transformError(MailTrashError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onUntrashMail(UntrashMail event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      if (prevState.untrashedMails.contains(event.mailId)) {
        return;
      }
      prevState.trashedMails.remove(event.mailId);
      prevState.untrashedMails.add(event.mailId);
      emit(MailState.transform(MailUntrashSuccess.new, prevState));
      add(SyncMailActions());
    } catch (e) {
      emit(MailState.transformError(MailUntrashError.new, prevState, e.toString()));
    }
  }
}
