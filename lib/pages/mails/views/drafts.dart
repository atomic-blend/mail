import 'package:ab_shared/components/app/conditional_parent_wrapper.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/pages/mails/mail_list.dart';
import 'package:mail/services/sync.service.dart';

part 'drafts.g.dart';

@TypedGoRoute<DraftRoute>(path: '/drafts', name: "drafts")
class DraftRoute extends GoRouteData with _$DraftRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DraftScreen();
  }
}

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
          ConditionalParentWidget(
            condition: getSize(context).width < $constants.screenSize.lg,
            parentBuilder: (child) => Expanded(
              child: child,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop(context) &&
                        getSize(context).width > $constants.screenSize.lg
                    ? 450
                    : getSize(context).width,
              ),
              child: Column(
                children: [
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
