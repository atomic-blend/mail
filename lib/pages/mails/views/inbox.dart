import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/pages/app_layout.dart';
import 'package:mail/pages/mails/appbars/mail_appbar.dart';
import 'package:mail/pages/mails/mail_list.dart';
import 'package:mail/pages/mails/no_mail_selected.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

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
              child: inboxMails.isEmpty
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
