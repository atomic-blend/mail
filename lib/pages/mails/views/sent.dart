import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/pages/mails/mail_list.dart';
import 'package:mail/services/sync.service.dart';

part 'sent.g.dart';

@TypedGoRoute<SentRoute>(path: '/sent', name: "sent")
class SentRoute extends GoRouteData with _$SentRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SentScreen();
  }
}

class SentScreen extends StatefulWidget {
  const SentScreen({super.key});

  @override
  State<SentScreen> createState() => _SentScreenState();
}

class _SentScreenState extends State<SentScreen> {
  @override
  void initState() {
    SyncService.sync(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      final sentMails = mailState.sentMails ?? [];
      return Row(
        children: [
          SizedBox(
            width: isDesktop(context) ? 300 : getSize(context).width,
            child: Column(
              children: [
                Expanded(
                  child: MailList(
                    drafts: true,
                    mails: sentMails,
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
