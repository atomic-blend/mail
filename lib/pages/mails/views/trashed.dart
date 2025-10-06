import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/mails/filtered_mail_view.dart';

class TrashedScreen extends StatefulWidget {
  const TrashedScreen({super.key});

  @override
  State<TrashedScreen> createState() => _TrashedScreenState();
}

class _TrashedScreenState extends State<TrashedScreen> {
  List<Mail> selectedMails = [];
  bool? isSelecting = false;

  @override
  Widget build(BuildContext context) {
    return FliteredMailView(
      title: context.t.email_folders.trashed,
      filter: (mail) => mail.trashed == true,
    );
  }
}
