import 'package:ab_shared/utils/shortcuts.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/pages/app_layout.dart';
import 'package:mail/pages/appbars/mail_appbar.dart';
import 'package:mail/pages/mails/mail_list.dart';
import 'package:mail/pages/mails/no_mail_selected.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      final archivedMails =
          mailState.mails?.where((mail) => mail.archived == true).toList() ??
              [];
      return Row(
        children: [
          SizedBox(
            width: isDesktop(context) ? 300 : getSize(context).width,
            child: Column(
              children: [
                MailAppbar(
                    sideMenuController: sideMenuController,
                    title: context.t.email_folders.archive),
                Expanded(
                  child: MailList(
                    mails: archivedMails,
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
              child: archivedMails.isEmpty
                  ? NoMailSelectedScreen(
                      title: context.t.email_folders.archive,
                      numberOfMails: archivedMails.length,
                    )
                  : Container(),
            ),
          ]
        ],
      );
    });
  }
}
