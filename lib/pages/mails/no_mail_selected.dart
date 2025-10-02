import 'package:ab_shared/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:mail/i18n/strings.g.dart';

class NoMailSelectedScreen extends StatelessWidget {
  final int numberOfMails;
  const NoMailSelectedScreen({super.key, required this.numberOfMails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(CupertinoIcons.tray_arrow_down, size: 40),
        SizedBox(height: $constants.insets.sm),
        Text(context.t.xx_mail_card.description(count: numberOfMails)),
      ],
    );
  }
}
