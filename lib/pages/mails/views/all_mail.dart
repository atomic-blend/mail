import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/mails/filtered_mail_view.dart';

class AllMailScreen extends StatefulWidget {
  const AllMailScreen({super.key});

  @override
  State<AllMailScreen> createState() => _AllMailScreenState();
}

class _AllMailScreenState extends State<AllMailScreen> {
  List<Mail> selectedMails = [];
  bool? isSelecting = false;

  @override
  Widget build(BuildContext context) {
    return FliteredMailView(
      title: context.t.email_folders.all,
      filter: (mail) => true,
    );
  }
}
