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
    on<SyncAllMailsPaginated>(_onSyncAllMailsPaginated);
    on<SyncSince>(_onSyncSince);
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
    on<EmptyTrash>(_onEmptyTrash);
    on<MailLogout>(_onLogout);
  }

  @override
  MailState? fromJson(Map<String, dynamic> json) {
    if (json["mails"] != null) {
      return MailLoaded(
        (json["mails"] as List).map((e) => Mail.fromJson(e)).toList(),
        drafts: (json["drafts"] as List)
            .map((e) => send_mail.SendMail.fromJson(e))
            .toList(),
        latestSync: json["latestSync"] != null
            ? DateTime.parse(json["latestSync"])
            : null,
      );
    }
    return MailInitial();
  }

  @override
  Map<String, dynamic>? toJson(MailState state) {
    if (state is MailLoaded && state.mails != null) {
      return {
        "mails": state.mails!.map((e) => e.toJson()).toList(),
        "drafts": state.drafts!.map((e) => e.toJson()).toList(),
        "latestSync": state.latestSync?.toIso8601String(),
      };
    }
    return null;
  }

  void _onSyncAllMailsPaginated(
      SyncAllMailsPaginated event, Emitter<MailState> emit) async {
    final prevState = state;
    emit(MailState.transform(MailLoading.new, prevState));
    try {
      // Load all pages of mails
      List<Mail> allMails = [];
      int currentPage = 1;
      int totalPages = 1;
      bool hasMorePages = true;

      while (hasMorePages && currentPage <= totalPages) {
        final paginationResult = await _mailService.getAllMailsWithPagination(
            page: currentPage, size: 10);

        final List<Mail> pageMails = paginationResult['mails'] as List<Mail>;
        totalPages = paginationResult['total_pages'] as int;

        // Add all mails from this page to our collection
        allMails.addAll(pageMails);

        // Check if we have more pages to load
        hasMorePages = currentPage < totalPages;
        currentPage++;

        // Emit intermediate state to show progress
        if (hasMorePages) {
          final intermediateState =
              MailState.transform(MailLoaded.new, prevState, mails: allMails);
          emit(intermediateState);
        }
      }

      // Load drafts
      final drafts = await _mailService.getDrafts();

      // Emit final state with all mails and drafts
      final newState = MailState.transform(MailLoaded.new, prevState,
          mails: allMails, drafts: drafts, latestSync: DateTime.now());

      emit(newState);
    } catch (e) {
      emit(MailState.transformError(
          MailLoadingError.new, prevState, e.toString()));
    }
  }

  void _onSyncSince(SyncSince event, Emitter<MailState> emit) async {
    final prevState = state;
    emit(MailState.transform(MailLoading.new, prevState));

    try {
      // Load mails since the given date
      List<Mail> newMails = [];
      int currentPage = 1;
      int totalPages = 1;
      bool hasMorePages = true;

      while (hasMorePages && currentPage <= totalPages) {
        final paginationResult = await _mailService.getMailsSince(
            since: prevState.latestSync ?? DateTime.now(),
            page: currentPage,
            size: 10);

        final List<Mail> pageMails = paginationResult['mails'] as List<Mail>;
        totalPages = paginationResult['total_pages'] as int;

        // Add all mails from this page to our collection
        newMails.addAll(pageMails);

        // Check if we have more pages to load
        hasMorePages = currentPage < totalPages;
        currentPage++;

        // Emit intermediate state to show progress
        if (hasMorePages) {
          final mergedMails = _mergeMails(prevState.mails ?? [], newMails);
          final intermediateState = MailState.transform(
            MailLoaded.new,
            prevState,
            mails: mergedMails,
          );
          emit(intermediateState);
        }
      }

      // Load drafts since the given date
      List<send_mail.SendMail> newDrafts = [];
      currentPage = 1;
      totalPages = 1;
      hasMorePages = true;

      while (hasMorePages && currentPage <= totalPages) {
        final paginationResult = await _mailService.getDraftsSince(
            since: prevState.latestSync ?? DateTime.now(),
            page: currentPage,
            size: 10);

        final List<send_mail.SendMail> pageDrafts =
            paginationResult['drafts'] as List<send_mail.SendMail>;
        totalPages = paginationResult['total_pages'] as int;

        // Add all drafts from this page to our collection
        newDrafts.addAll(pageDrafts);

        // Check if we have more pages to load
        hasMorePages = currentPage < totalPages;
        currentPage++;
      }

      // Merge with existing state
      final mergedMails = _mergeMails(prevState.mails ?? [], newMails);
      final mergedDrafts = _mergeDrafts(prevState.drafts ?? [], newDrafts);

      // Emit final state with merged mails and drafts
      final newState = MailState.transform(MailLoaded.new, prevState,
          mails: mergedMails, drafts: mergedDrafts, latestSync: DateTime.now());

      emit(newState);
    } catch (e) {
      emit(MailState.transformError(
          MailLoadingError.new, prevState, e.toString()));
    }
  }

  void _onMarkAsRead(MarkAsRead event, Emitter<MailState> emit) async {
    final prevState = state;
    if (prevState.readMails.contains(event.mailId ?? "")) {
      return;
    }
    prevState.unreadMails.remove(event.mailId);
    if (event.mailId != null) {
      prevState.readMails.add(event.mailId!);
    }
    if (event.mailIds != null) {
      prevState.readMails.addAll(event.mailIds!);
    }
    emit(MailState.transform(MailMarkAsReadSuccess.new, prevState));
    add(SyncMailActions());
  }

  void _onMarkAsUnread(MarkAsUnread event, Emitter<MailState> emit) async {
    final prevState = state;
    if (prevState.unreadMails.contains(event.mailId)) {
      return;
    }
    prevState.readMails.remove(event.mailId);
    if (event.mailId != null) {
      prevState.unreadMails.add(event.mailId!);
    }
    if (event.mailIds != null) {
      prevState.unreadMails.addAll(event.mailIds!);
    }
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
        state.archivedMails.clear();
        state.unarchivedMails.clear();
        state.trashedMails.clear();
        state.untrashedMails.clear();
        emit(MailState.transform(MailLoaded.new, prevState));
      } else {
        emit(MailState.transformError(MailLoadingError.new, prevState,
            result.message ?? "Unknown error"));
      }
    } catch (e) {
      emit(MailState.transformError(
          MailLoadingError.new, prevState, e.toString()));
    }
    add(const SyncSince());
  }

  void _onSendMail(SendMail event, Emitter<MailState> emit) async {
    final prevState = state;
    emit(MailState.transform(MailSending.new, prevState));
    try {
      await _mailService.sendMail(event.mail);
      emit(MailState.transform(MailSendSuccess.new, prevState));
      add(const SyncAllMailsPaginated());
    } catch (e) {
      emit(
          MailState.transformError(MailSendError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onSaveDraft(SaveDraft event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      await _mailService.saveDraft(event.mail);
      emit(MailState.transform(MailSaveDraftSuccess.new, prevState));
      add(const SyncAllMailsPaginated());
    } catch (e) {
      emit(MailState.transformError(
          MailSaveDraftError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onDeleteDraft(
      DeleteDraft event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      await _mailService.deleteDraft(event.draftId);
      emit(MailState.transform(MailDeleteDraftSuccess.new, prevState));
      add(const SyncAllMailsPaginated());
    } catch (e) {
      emit(MailState.transformError(
          MailDeleteDraftError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onUpdateDraft(
      UpdateDraft event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      await _mailService.updateDraft(event.mail, event.draftId);
      emit(MailState.transform(MailUpdateDraftSuccess.new, prevState));
      add(const SyncAllMailsPaginated());
    } catch (e) {
      emit(MailState.transformError(
          MailUpdateDraftError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onArchiveMail(
      ArchiveMail event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      if (prevState.archivedMails.contains(event.mailId)) {
        return;
      }
      prevState.unarchivedMails.remove(event.mailId);
      if (event.mailId != null) {
        prevState.archivedMails.add(event.mailId!);
      }
      if (event.mailIds != null) {
        prevState.archivedMails.addAll(event.mailIds!);
      }
      emit(MailState.transform(MailArchiveSuccess.new, prevState));
      add(SyncMailActions());
    } catch (e) {
      emit(MailState.transformError(
          MailArchiveError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onUnarchiveMail(
      UnarchiveMail event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      if (prevState.unarchivedMails.contains(event.mailId)) {
        return;
      }
      prevState.archivedMails.remove(event.mailId);
      if (event.mailId != null) {
        prevState.unarchivedMails.add(event.mailId!);
      }
      if (event.mailIds != null) {
        prevState.unarchivedMails.addAll(event.mailIds!);
      }
      emit(MailState.transform(MailUnarchiveSuccess.new, prevState));
      add(SyncMailActions());
    } catch (e) {
      emit(MailState.transformError(
          MailUnarchiveError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onTrashMail(TrashMail event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      if (prevState.trashedMails.contains(event.mailId)) {
        return;
      }
      prevState.untrashedMails.remove(event.mailId);
      if (event.mailId != null) {
        prevState.trashedMails.add(event.mailId!);
      }
      if (event.mailIds != null) {
        prevState.trashedMails.addAll(event.mailIds!);
      }
      emit(MailState.transform(MailTrashSuccess.new, prevState));
      add(SyncMailActions());
    } catch (e) {
      emit(MailState.transformError(
          MailTrashError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onUntrashMail(
      UntrashMail event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      if (prevState.untrashedMails.contains(event.mailId)) {
        return;
      }
      prevState.trashedMails.remove(event.mailId);
      if (event.mailId != null) {
        prevState.untrashedMails.add(event.mailId!);
      }
      if (event.mailIds != null) {
        prevState.untrashedMails.addAll(event.mailIds!);
      }
      emit(MailState.transform(MailUntrashSuccess.new, prevState));
      add(SyncMailActions());
    } catch (e) {
      emit(MailState.transformError(
          MailUntrashError.new, prevState, e.toString()));
    }
  }

  FutureOr<void> _onEmptyTrash(
      EmptyTrash event, Emitter<MailState> emit) async {
    final prevState = state;
    try {
      await _mailService.emptyTrash();
      emit(MailState.transform(MailEmptyTrashSuccess.new, prevState));
      add(const SyncAllMailsPaginated());
    } catch (e) {
      emit(MailState.transformError(
          MailEmptyTrashError.new, prevState, e.toString()));
    }
  }

  /// Merges new mails with existing mails, updating existing ones or adding new ones
  List<Mail> _mergeMails(List<Mail> existingMails, List<Mail> newMails) {
    final Map<String, Mail> mailMap = {};

    // Add existing mails to map
    for (final mail in existingMails) {
      if (mail.id != null) {
        mailMap[mail.id!] = mail;
      }
    }

    // Update or add new mails
    for (final mail in newMails) {
      if (mail.id != null) {
        mailMap[mail.id!] = mail;
      }
    }

    // Convert back to list and sort by date (newest first)
    return mailMap.values.toList()
      ..sort((a, b) => (b.createdAt ?? DateTime(1970))
          .compareTo(a.createdAt ?? DateTime(1970)));
  }

  /// Merges new drafts with existing drafts, updating existing ones or adding new ones
  List<send_mail.SendMail> _mergeDrafts(List<send_mail.SendMail> existingDrafts,
      List<send_mail.SendMail> newDrafts) {
    final Map<String, send_mail.SendMail> draftMap = {};

    // Add existing drafts to map
    for (final draft in existingDrafts) {
      if (draft.id != null) {
        draftMap[draft.id!] = draft;
      }
    }

    // Update or add new drafts
    for (final draft in newDrafts) {
      if (draft.id != null) {
        draftMap[draft.id!] = draft;
      }
    }

    // Convert back to list and sort by date (newest first)
    return draftMap.values.toList()
      ..sort((a, b) => (b.mail?.createdAt ?? DateTime(1970))
          .compareTo(a.mail?.createdAt ?? DateTime(1970)));
  }

  FutureOr<void> _onLogout(MailLogout event, Emitter<MailState> emit) {
    emit(MailInitial());
  } 
}
