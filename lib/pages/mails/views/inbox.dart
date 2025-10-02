import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/app_layout.dart';
import 'package:mail/pages/mails/appbars/mail_appbar.dart';
import 'package:mail/pages/mails/mail_list.dart';
import 'package:mail/pages/mails/no_mail_selected.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<Mail> selectedMails = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      final inboxMails = mailState.mails
              ?.where((mail) => mail.archived != true && mail.trashed != true)
              .toList() ??
          [];
      return Row(
        children: [
          SizedBox(
            width: isDesktop(context) ? 400 : getSize(context).width,
            child: Column(
              children: [
                MailAppbar(
                    sideMenuController: sideMenuController,
                    title: context.t.email_folders.inbox),
                Expanded(
                  child: MailList(
                    mails: inboxMails,
                    onSelect: (mail) {
                      setState(() {
                        selectedMails.add(mail);
                      });
                    },
                    onDeselect: (mail) {
                      setState(() {
                        selectedMails.remove(mail);
                      });
                    },
                    selectedMails: selectedMails,
                  ),
                ),
              ],
            ),
          ),
          if (isDesktop(context)) ...[
            VerticalDivider(
              width: 1,
            ),
            Expanded(
              child: inboxMails.isEmpty || selectedMails.isEmpty
                  ? NoMailSelectedScreen(
                      title: context.t.email_folders.inbox,
                      numberOfMails: inboxMails.length,
                    )
                  : Container(),
            ),
          ]
        ],
      );
    });
  }
}
