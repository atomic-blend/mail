import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/mails/filtered_mail_view.dart';

part 'spam.g.dart';

@TypedGoRoute<SpamRoute>(path: '/spam', name: "spam")
class SpamRoute extends GoRouteData with _$SpamRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SpamScreen();
  }
}

class SpamScreen extends StatefulWidget {
  const SpamScreen({super.key});

  @override
  State<SpamScreen> createState() => _SpamScreenState();
}

class _SpamScreenState extends State<SpamScreen> {
  List<Mail> selectedMails = [];
  bool? isSelecting = false;

  @override
  Widget build(BuildContext context) {
    return FliteredMailView(
      title: context.t.email_folders.spam,
      filter: (mail) => mail.rejected == true,
    );
  }
}
