import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/app_layout.dart';
import 'package:mail/pages/appbars/mail_appbar.dart';
import 'package:mail/pages/mails/mail_details.dart';
import 'package:mail/pages/mails/mail_list.dart';
import 'package:mail/pages/mails/no_mail_selected.dart';

class AllMailScreen extends StatefulWidget {
  const AllMailScreen({super.key});

  @override
  State<AllMailScreen> createState() => _AllMailScreenState();
}

class _AllMailScreenState extends State<AllMailScreen> {
  List<Mail> selectedMails = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      final allMails = mailState.mails ?? [];
      return Row(
        children: [
          SizedBox(
            width: isDesktop(context) ? 300 : getSize(context).width,
            child: Column(
              children: [
                MailAppbar(
                    sideMenuController: sideMenuController,
                    title: context.t.email_folders.all),
                Expanded(
                  child: MailList(
                    mails: allMails,
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
          if (isDesktop(context) &&
              getSize(context).width > $constants.screenSize.md) ...[
            SizedBox(width: $constants.insets.xs),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  right: $constants.insets.xs,
                  bottom: $constants.insets.xs,
                ),
                child: allMails.isEmpty || selectedMails.isEmpty
                    ? NoMailSelectedScreen(
                        icon: CupertinoIcons.tray_arrow_down,
                        title: context.t.email_folders.all,
                        numberOfMails: allMails.length,
                      )
                    : selectedMails.length == 1
                        ? MailDetailScreen(
                            selectedMails.first,
                            mode: MailScreenMode.integrated,
                            onCancel: () {
                              setState(() {
                                selectedMails.clear();
                              });
                            },
                          )
                        : Container(),
              ),
            ),
          ]
        ],
      );
    });
  }
}
