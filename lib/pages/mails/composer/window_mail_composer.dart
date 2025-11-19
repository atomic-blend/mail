import 'package:ab_shared/components/app/window_layout/window_layout_widget.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/models/send_mail/send_mail.dart';
import 'package:mail/pages/mails/composer/mail_composer.dart';
import 'package:mail/services/sync.service.dart';

class WindowMailComposer extends WindowLayoutWidget {
  final SendMail? draft;
  final Mail? inReplyTo;
  const WindowMailComposer({
    super.key,
    this.draft,
    this.inReplyTo,
    super.initiallyCollapsed = true,
    super.contentHeight = 600,
    super.headerHeight = 50,
    super.width = 700,
  });

  @override
  WindowLayoutWidgetState createState() => _WindowMailComposerState();
}

class _WindowMailComposerState extends WindowLayoutWidgetState {
  String? subject;
  final GlobalKey<MailComposerState> mailComposerKey =
      GlobalKey<MailComposerState>();

  @override
  Widget header(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          subject != null && subject!.isNotEmpty ? subject! : 'New Mail',
          style: getTextTheme(context).bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  @override
  void onClose(BuildContext context) {
    mailComposerKey.currentState?.draftAndPop(context, pop: false);
    SyncService.sync(context);
  }

  @override
  Widget body(BuildContext context) {
    return Material(
      child: MailComposer(
        key: mailComposerKey,
        mail: (widget as WindowMailComposer).draft,
        inReplyTo: (widget as WindowMailComposer).inReplyTo,
        backgroundColor: getTheme(context).surface,
        windowMode: true,
        onSubjectChanged: (newSubject) {
          setState(() {
            subject = newSubject;
          });
        },
      ),
    );
  }
}
