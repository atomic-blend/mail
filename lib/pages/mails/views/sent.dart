import 'package:ab_shared/components/app/conditional_parent_wrapper.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/pages/mails/mail_details.dart';
import 'package:mail/pages/mails/mail_list.dart';
import 'package:mail/pages/mails/no_mail_selected.dart';
import 'package:mail/services/sync.service.dart';
import 'package:mail/models/send_mail/send_mail.dart' as send_mail;

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
  send_mail.SendMail? selected;
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
        mainAxisSize: MainAxisSize.min,
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
                      sent: true,
                      mails: sentMails,
                      onSelect: (mail) => setState(() {
                        send_mail.SendMail sentMail = sentMails.firstWhere(
                            (element) => element.mail?.id == mail.id);
                        selected = sentMail;
                      }),
                      onDeselect: (mail) {
                        setState(() {
                          selected = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isDesktop(context) &&
              getSize(context).width > $constants.screenSize.lg) ...[
            Expanded(
              child: sentMails.isEmpty || selected == null
                  ? NoMailSelectedScreen(
                      icon: CupertinoIcons.tray_arrow_down,
                      title: context.t.email_folders.sent,
                      numberOfMails: sentMails.length,
                    )
                  : MailDetailScreen(
                      selected!.mail!,
                      isSent: true,
                      onCancel: () => setState(() {
                        selected = null;
                      }),
                      mode: MailScreenMode.integrated,
                    ),
            ),
          ]
        ],
      );
    });
  }
}
