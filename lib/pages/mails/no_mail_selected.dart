import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail/i18n/strings.g.dart';

class NoMailSelectedScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final int? numberOfMails;
  const NoMailSelectedScreen(
      {super.key, this.numberOfMails, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all($constants.insets.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 100, color: Colors.grey.shade600),
          SizedBox(height: $constants.insets.sm),
          Text(
            title,
            style: getTextTheme(context)
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: $constants.insets.sm),
          if (numberOfMails != null)
            Text(context.t.xx_mail_card.description(count: numberOfMails!)),
        ],
      ),
    );
  }
}
