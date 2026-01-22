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
    on<SyncSentPaginated>(_onSyncSentPaginated);
    on<SyncSentSince>(_onSyncSentSince);
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
        sentMails: (json["sent_mails"] as List)
            .map((e) => send_mail.SendMail.fromJson(e))
            .toList(),
        latestSync: json["latestSync"] != null
            ? DateTime.parse(json["latestSync"])
            : null,
        readMails: List<String>.from(json["readMails"] ?? []),
        unreadMails: List<String>.from(json["unreadMails"] ?? []),
        archivedMails: List<String>.from(json["archivedMails"] ?? []),
        unarchivedMails: List<String>.from(json["unarchivedMails"] ?? []),
        trashedMails: List<String>.from(json["trashedMails"] ?? []),
        untrashedMails: List<String>.from(json["untrashedMails"] ?? []),
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
        "sent_mails": state.sentMails!.map((e) => e.toJson()).toList(),
        "latestSync": state.latestSync?.toIso8601String(),
        "readMails": state.readMails.toList(),
        "unreadMails": state.unreadMails.toList(),
        "archivedMails": state.archivedMails.toList(),
        "unarchivedMails": state.unarchivedMails.toList(),
        "trashedMails": state.trashedMails.toList(),
        "untrashedMails": state.untrashedMails.toList(),
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

      // Load sent mails
      List<send_mail.SendMail> allSent = [];
      int currentPageSent = 1;
      bool hasMorePagesSent = true;

      while (hasMorePagesSent) {
        final pageSent =
            await _mailService.getSent(page: currentPageSent, size: 10);
        if (pageSent.isEmpty) {
          hasMorePagesSent = false;
        } else {
          allSent.addAll(pageSent);
          currentPageSent++;
        }
      }

      // Emit final state with all mails, drafts, and sent mails
      final newState = MailState.transform(MailLoaded.new, prevState,
          mails: allMails,
          drafts: drafts,
          sentMails: allSent,
          latestSync: DateTime.now());

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
            since: prevState.latestSync ?? DateTime(1970),
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
            since: prevState.latestSync ?? DateTime(1970),
            page: currentPage,
            size: 10);

        final List<send_mail.SendMail> pageDrafts =
            paginationResult['drafts'] as List<send_mail.SendMail>;
        totalPages = paginationResult['total_count'] as int;

        // Add all drafts from this page to our collection
        newDrafts.addAll(pageDrafts);

        // Check if we have more pages to load
        hasMorePages = currentPage < totalPages;
        currentPage++;
      }

      // Merge with existing state
      final mergedMails = _mergeMails(prevState.mails ?? [], newMails);
      final mergedDrafts = _mergeDrafts(prevState.drafts ?? [], newDrafts);

      // Load sent mails since the given date
      List<send_mail.SendMail> newSent = [];
      currentPage = 1;
      totalPages = 1;
      hasMorePages = true;

      while (hasMorePages && currentPage <= totalPages) {
        final paginationResult = await _mailService.getSentSince(
            since: prevState.latestSync ?? DateTime(1970),
            page: currentPage,
            size: 10);

        final List<send_mail.SendMail> pageSent =
            paginationResult['sent_mails'] as List<send_mail.SendMail>;
        totalPages = paginationResult['total_count'] as int;

        // Add all sent mails from this page to our collection
        newSent.addAll(pageSent);

        // Check if we have more pages to load
        hasMorePages = currentPage < totalPages;
        currentPage++;
      }

      // Merge sent mails
      final mergedSent = _mergeSentMails(prevState.sentMails ?? [], newSent);

      // Emit final state with merged mails, drafts, and sent mails
      final newState = MailState.transform(
        MailLoaded.new,
        prevState,
        mails: mergedMails,
        drafts: mergedDrafts,
        sentMails: mergedSent,
        latestSync: DateTime.now(),
      );

      emit(newState);
    } catch (e) {
      emit(MailState.transformError(
          MailLoadingError.new, prevState, e.toString()));
    }
  }

  void _onSyncSentPaginated(
      SyncSentPaginated event, Emitter<MailState> emit) async {
    final prevState = state;
    emit(MailState.transform(MailLoading.new, prevState));
    try {
      // Load all pages of sent mails
      List<send_mail.SendMail> allSent = [];
      int currentPage = 1;
      bool hasMorePages = true;

      while (hasMorePages) {
        final pageSent =
            await _mailService.getSent(page: currentPage, size: 10);
        if (pageSent.isEmpty) {
          hasMorePages = false;
        } else {
          allSent.addAll(pageSent);
          currentPage++;
          // Emit intermediate state to show progress
          final intermediateState = MailState.transform(
            MailLoaded.new,
            prevState,
            sentMails: allSent,
          );
          emit(intermediateState);
        }
      }

      // Emit final state with all sent mails
      final newState = MailState.transform(MailLoaded.new, prevState,
          sentMails: allSent, latestSync: DateTime.now());

      emit(newState);
    } catch (e) {
      emit(MailState.transformError(
          MailLoadingError.new, prevState, e.toString()));
    }
  }

  void _onSyncSentSince(SyncSentSince event, Emitter<MailState> emit) async {
    final prevState = state;
    emit(MailState.transform(MailLoading.new, prevState));

    try {
      // Load sent mails since the given date
      List<send_mail.SendMail> newSent = [];
      int currentPage = 1;
      int totalPages = 1;
      bool hasMorePages = true;

      while (hasMorePages && currentPage <= totalPages) {
        final paginationResult = await _mailService.getSentSince(
            since: prevState.latestSync ?? DateTime(1970),
            page: currentPage,
            size: 10);

        final List<send_mail.SendMail> pageSent =
            paginationResult['sent_mails'] as List<send_mail.SendMail>;
        totalPages = paginationResult['total_count'] as int;

        // Add all sent mails from this page to our collection
        newSent.addAll(pageSent);

        // Check if we have more pages to load
        hasMorePages = currentPage < totalPages;
        currentPage++;

        // Emit intermediate state to show progress
        if (hasMorePages) {
          final mergedSent =
              _mergeSentMails(prevState.sentMails ?? [], newSent);
          final intermediateState = MailState.transform(
            MailLoaded.new,
            prevState,
            sentMails: mergedSent,
          );
          emit(intermediateState);
        }
      }

      // Merge with existing state
      final mergedSent = _mergeSentMails(prevState.sentMails ?? [], newSent);

      // Emit final state with merged sent mails
      final newState = MailState.transform(MailLoaded.new, prevState,
          sentMails: mergedSent, latestSync: DateTime.now());

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
    final newReadMails = List<String>.from(prevState.readMails);
    final newUnreadMails = List<String>.from(prevState.unreadMails);
    newUnreadMails.remove(event.mailId);
    if (event.mailId != null) {
      newReadMails.add(event.mailId!);
    }
    if (event.mailIds != null) {
      newReadMails.addAll(event.mailIds!);
    }
    emit(MailState.transform(MailMarkAsReadSuccess.new, prevState,
        readMails: newReadMails, unreadMails: newUnreadMails));
    add(SyncMailActions());
  }

  void _onMarkAsUnread(MarkAsUnread event, Emitter<MailState> emit) async {
    final prevState = state;
    if (prevState.unreadMails.contains(event.mailId)) {
      return;
    }
    final newReadMails = List<String>.from(prevState.readMails);
    final newUnreadMails = List<String>.from(prevState.unreadMails);
    newReadMails.remove(event.mailId);
    if (event.mailId != null) {
      newUnreadMails.add(event.mailId!);
    }
    if (event.mailIds != null) {
      newUnreadMails.addAll(event.mailIds!);
    }
    emit(MailState.transform(MailMarkAsUnreadSuccess.new, prevState,
        readMails: newReadMails, unreadMails: newUnreadMails));
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
        emit(MailState.transform(MailLoaded.new, prevState,
            readMails: [],
            unreadMails: [],
            archivedMails: [],
            unarchivedMails: [],
            trashedMails: [],
            untrashedMails: []));
      } else {
        emit(MailState.transformError(MailLoadingError.new, prevState,
            result.message ?? "Unknown error"));
      }
    } catch (e) {
      emit(MailState.transformError(
          MailLoadingError.new, prevState, e.toString()));
    }
    // Don't trigger another sync here - the sync service handles calling the appropriate sync
  }

  void _onSendMail(SendMail event, Emitter<MailState> emit) async {
    final prevState = state;
    emit(MailState.transform(MailSending.new, prevState));
    try {
      await _mailService.sendMail(event.mail);
      emit(MailState.transform(MailSendSuccess.new, prevState));
      add(const SyncSince());
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
      add(const SyncSince());
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
      add(const SyncSince());
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
      add(const SyncSince());
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
      final newArchivedMails = List<String>.from(prevState.archivedMails);
      final newUnarchivedMails = List<String>.from(prevState.unarchivedMails);
      newUnarchivedMails.remove(event.mailId);
      if (event.mailId != null) {
        newArchivedMails.add(event.mailId!);
      }
      if (event.mailIds != null) {
        newArchivedMails.addAll(event.mailIds!);
      }
      emit(MailState.transform(MailArchiveSuccess.new, prevState,
          archivedMails: newArchivedMails,
          unarchivedMails: newUnarchivedMails));
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
      final newArchivedMails = List<String>.from(prevState.archivedMails);
      final newUnarchivedMails = List<String>.from(prevState.unarchivedMails);
      newArchivedMails.remove(event.mailId);
      if (event.mailId != null) {
        newUnarchivedMails.add(event.mailId!);
      }
      if (event.mailIds != null) {
        newUnarchivedMails.addAll(event.mailIds!);
      }
      emit(MailState.transform(MailUnarchiveSuccess.new, prevState,
          archivedMails: newArchivedMails,
          unarchivedMails: newUnarchivedMails));
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
      final newTrashedMails = List<String>.from(prevState.trashedMails);
      final newUntrashedMails = List<String>.from(prevState.untrashedMails);
      newUntrashedMails.remove(event.mailId);
      if (event.mailId != null) {
        newTrashedMails.add(event.mailId!);
      }
      if (event.mailIds != null) {
        newTrashedMails.addAll(event.mailIds!);
      }
      emit(MailState.transform(MailTrashSuccess.new, prevState,
          trashedMails: newTrashedMails, untrashedMails: newUntrashedMails));
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
      final newTrashedMails = List<String>.from(prevState.trashedMails);
      final newUntrashedMails = List<String>.from(prevState.untrashedMails);
      newTrashedMails.remove(event.mailId);
      if (event.mailId != null) {
        newUntrashedMails.add(event.mailId!);
      }
      if (event.mailIds != null) {
        newUntrashedMails.addAll(event.mailIds!);
      }
      emit(MailState.transform(MailUntrashSuccess.new, prevState,
          trashedMails: newTrashedMails, untrashedMails: newUntrashedMails));
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
      add(const SyncSince());
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

  /// Merges new sent mails with existing sent mails, updating existing ones or adding new ones
  List<send_mail.SendMail> _mergeSentMails(
      List<send_mail.SendMail> existingSent, List<send_mail.SendMail> newSent) {
    final Map<String, send_mail.SendMail> sentMap = {};

    // Add existing sent mails to map
    for (final sent in existingSent) {
      if (sent.id != null) {
        sentMap[sent.id!] = sent;
      }
    }

    // Update or add new sent mails
    for (final sent in newSent) {
      if (sent.id != null) {
        sentMap[sent.id!] = sent;
      }
    }

    // Convert back to list and sort by date (newest first)
    return sentMap.values.toList()
      ..sort((a, b) => (b.mail?.createdAt ?? DateTime(1970))
          .compareTo(a.mail?.createdAt ?? DateTime(1970)));
  }

  FutureOr<void> _onLogout(MailLogout event, Emitter<MailState> emit) {
    emit(MailInitial());
  }
}
