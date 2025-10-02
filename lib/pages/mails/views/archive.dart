import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mail/pages/app_layout.dart';
import 'package:mail/pages/mails/appbars/mail_appbar.dart';
import 'package:mail/pages/mails/filtered_mail.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: isDesktop(context) ? 300 : getSize(context).width,
          child: Column(
            children: [
              MailAppbar(sideMenuController: sideMenuController, title: "Archive"),
              Expanded(
                child: FilteredMailScreen(
            filterFunction: (mails) =>
                mails?.where((mail) => mail.archived == true).toList() ?? [],
                ),
              ),
            ],
          ),
        ),
        if (isDesktop(context)) ...[
          VerticalDivider(
            width: 1,
          ),
          Expanded(child: Container()),
        ]
      ],
    );
  }
}
