import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail/components/cards/mail_card.dart';
import 'package:mail/models/mail/mail.dart';

class SelectedListScreen extends StatelessWidget {
  final List<Mail> mails;
  const SelectedListScreen({super.key, required this.mails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getTheme(context).surface,
      body: SafeArea(
        left: false,
        right: false,
        bottom: !isDesktop(context),
        top: !isDesktop(context),
        child: Container(
          padding: EdgeInsets.all($constants.insets.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bulk edit",
                style: getTextTheme(context)
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: $constants.insets.xs),
              Text(
                "You have selected ${mails.length} mails.\nYou can choose the actions you want to perform on them.",
                style: getTextTheme(context)
                    .bodyMedium!
                    .copyWith(color: Colors.grey.shade600),
              ),
              SizedBox(height: $constants.insets.sm),
              ...mails.map((mail) => Padding(
                    padding: EdgeInsets.only(bottom: $constants.insets.xs),
                    child: MailCard(
                      mail: mail,
                      enabled: false,
                      backgroundColor: getTheme(context).surfaceContainer,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
