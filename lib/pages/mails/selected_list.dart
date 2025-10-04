import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ab_shared/components/buttons/ab_button.dart';
import 'package:mail/components/cards/mail_card.dart';
import 'package:mail/i18n/strings.g.dart';
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
              Row(
                spacing: $constants.insets.xs,
                children: [
                  _buildActionButton(
                      context,
                      context.t.mail_actions.mark_as_read,
                      CupertinoIcons.envelope_open, () {
                    print("Mark as read");
                  }),
                  _buildActionButton(
                      context,
                      context.t.mail_actions.mark_as_unread,
                      CupertinoIcons.envelope, () {
                    print("Mark as unread");
                  }),
                  _buildActionButton(context, context.t.mail_actions.archive,
                      CupertinoIcons.archivebox, () {
                    print("Archive");
                  }),
                  _buildActionButton(context, context.t.mail_actions.trash,
                      CupertinoIcons.trash, () {
                    print("Trash");
                  }),
                ],
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

  Widget _buildActionButton(
      BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return ABButton(
      label: label,
      icon: icon,
      onTap: onTap,
      iconSize: 15,
    );
  }
}
