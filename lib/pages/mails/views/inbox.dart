import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/pages/mails/filtered_mail_view.dart';
import 'package:go_router/go_router.dart';

part 'inbox.g.dart';

@TypedGoRoute<InboxRoute>(path: '/inbox', name: "inbox")
class InboxRoute extends GoRouteData with _$InboxRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return InboxScreen();
  }
}

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return FliteredMailView(
      title: context.t.email_folders.inbox,
      filter: (mail) => mail.archived != true && mail.trashed != true,
    );
  }
}
