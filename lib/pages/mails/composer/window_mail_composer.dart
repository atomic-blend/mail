import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:ab_shared/components/app/window_layout/window_layout_widget.dart';
import 'package:mail/models/send_mail/send_mail.dart';
import 'package:mail/pages/mails/composer/mail_composer.dart';

class WindowMailComposer extends WindowLayoutWidget {
  final SendMail? draft;
  const WindowMailComposer({
    super.key,
    this.draft,
    super.initiallyCollapsed = true,
    super.contentHeight = 500,
    super.headerHeight = 50,
    super.width = 400,
  });

  @override
  WindowLayoutWidgetState createState() => _WindowMailComposerState();
}

class _WindowMailComposerState extends WindowLayoutWidgetState {
  String? subject;

  @override
  Widget header(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          subject ?? 'New Mail',
          style: getTextTheme(context).bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Material(
      child: MailComposer(
        mail: (widget as WindowMailComposer).draft,
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
