import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/mails/filtered_mail_view.dart';

part 'archive.g.dart';

@TypedGoRoute<ArchiveRoute>(path: '/archive', name: "archive")
class ArchiveRoute extends GoRouteData with _$ArchiveRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ArchiveScreen();
  }
}

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  List<Mail> selectedMails = [];
  bool? isSelecting = false;

  @override
  Widget build(BuildContext context) {
    return FliteredMailView(
      title: context.t.email_folders.archive,
      filter: (mail) => mail.archived == true,
    );
  }
}
