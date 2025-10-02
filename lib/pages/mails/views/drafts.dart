import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/pages/app_layout.dart';
import 'package:mail/pages/mails/appbars/mail_appbar.dart';
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
      return Row(
        children: [
          SizedBox(
            width: isDesktop(context) ? 300 : getSize(context).width,
            child: Column(
              children: [
                MailAppbar(
                    sideMenuController: sideMenuController, title: "Drafts"),
                Expanded(
                  child: MailList(
                    drafts: true,
                    onDelete: (draftId) {
                      context.read<MailBloc>().add(DeleteDraft(draftId));
                    },
                    mails: mailState.drafts ?? [],
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
