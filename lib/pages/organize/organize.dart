import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/models/mail/mail.dart';

class OrganizeScreen extends StatefulWidget {
  const OrganizeScreen({super.key});

  @override
  State<OrganizeScreen> createState() => _OrganizeScreenState();
}

class _OrganizeScreenState extends State<OrganizeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      final inboxMails = mailState.mails?.where((mail) => mail.archived != true && mail.trashed != true).toList() ?? [];
      if (inboxMails.isEmpty) {
        return _buildNothingToOrganize();
      }
      return _buildOrganizer(inboxMails);
    });
  }

  Widget _buildNothingToOrganize() {
    return Container();
  }

  Widget _buildOrganizer(List<Mail> inboxMails) {
    return Container();
  }
}