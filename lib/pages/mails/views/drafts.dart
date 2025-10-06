import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/app.dart';
import 'package:mail/pages/appbars/mail_appbar.dart';
import 'package:mail/pages/mails/mail_list.dart';
import 'package:mail/services/sync.service.dart';

class DraftScreen extends StatefulWidget {
  const DraftScreen({super.key});

  @override
  State<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends State<DraftScreen> {
  @override
  void initState() {
    SyncService.sync(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      final drafts = mailState.drafts ?? [];
      return Row(
        children: [
          SizedBox(
            width: isDesktop(context) ? 300 : getSize(context).width,
            child: Column(
              children: [
                MailAppbar(
                    sideMenuController: sideMenuController,
                    title: context.t.email_folders.drafts),
                Expanded(
                  child: MailList(
                    drafts: true,
                    onDelete: (draftId) {
                      context.read<MailBloc>().add(DeleteDraft(draftId));
                    },
                    mails: drafts,
                  ),
                ),
              ],
            ),
          ),
          // if (isDesktop(context)) ...[
          //   VerticalDivider(
          //     width: 1,
          //   ),
          //   Expanded(
          //     child: drafts.isEmpty
          //         ? NoMailSelectedScreen(
          //             icon: CupertinoIcons.tray_arrow_down,
          //             title: context.t.email_folders.drafts,
          //             numberOfMails: drafts.length,
          //           )
          //         : Container(),
          //   ),
          // ]
        ],
      );
    });
  }
}
