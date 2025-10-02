import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/pages/app_layout.dart';
import 'package:mail/pages/mails/appbars/mail_appbar.dart';
import 'package:mail/pages/mails/mail_list.dart';

class AllMailScreen extends StatelessWidget {
  const AllMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      return Row(
        children: [
          SizedBox(
            width: isDesktop(context) ? 300 : getSize(context).width,
            child: Column(
              children: [
                MailAppbar(
                    sideMenuController: sideMenuController, title: "All Mail"),
                Expanded(
                  child: MailList(
                    mails: mailState.mails ?? [],
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
    });
  }
}
