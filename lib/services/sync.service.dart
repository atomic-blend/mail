import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/components/app/ab_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';

class SyncService {
  static Future<void> sync(BuildContext context) async {
    if (context.read<AuthBloc>().state is! LoggedIn) return;

    // Sync data
    context.read<MailBloc>().add(const SyncMailActions());
    if (context.read<MailBloc>().state is MailInitial) {
      context.read<MailBloc>().add(const SyncAllMailsPaginated());
    } else {
      context.read<MailBloc>().add(const SyncSince());
    }
  }

  static void syncUserData(BuildContext context) {
    if (context.read<AuthBloc>().state is! LoggedIn) return;

    // Sync user data
    context.read<AuthBloc>().add(const RefreshUser());
  }

  static List<SyncedElement> getSyncedElements({
    required MailState mailState,
    required AuthState authState,
  }) {
    return [
      SyncedElement(
          key: const Key("mails"),
          label: "Mails",
          icon: CupertinoIcons.mail,
          count: mailState.mails?.length ?? 0),
      SyncedElement(
          key: const Key("drafts"),
          label: "Drafts",
          icon: CupertinoIcons.square_pencil,
          count: mailState.drafts?.length ?? 0),
    ];
  }

  static bool isSyncing({
    required MailState mailState,
    required AuthState authState,
  }) {
    return mailState is MailLoading || authState is Loading;
  }
}
