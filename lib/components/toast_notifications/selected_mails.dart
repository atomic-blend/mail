import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';

class SelectedMailsToastNotification extends StatelessWidget {
  final List<Mail> mails;
  const SelectedMailsToastNotification({super.key, required this.mails});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(CupertinoIcons.envelope, size: 25),
        SizedBox(width: $constants.insets.sm),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                context.t.toast_notifications.selected_mails
                    .title(count: mails.length),
                style: getTextTheme(context)
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: $constants.insets.xxs),
              Text(
                context.t.toast_notifications.selected_mails.description,
                style: getTextTheme(context)
                    .bodySmall!
                    .copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
