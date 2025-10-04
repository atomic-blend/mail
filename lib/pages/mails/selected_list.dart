import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ab_shared/components/buttons/ab_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/components/cards/mail_card.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';

class SelectedListScreen extends StatelessWidget {
  final List<Mail> mails;
  final bool? archive;
  final bool? trash;
  const SelectedListScreen(
      {super.key, required this.mails, this.archive, this.trash});

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
                    CupertinoIcons.envelope_open,
                    () {
                      _markReadUnreadBulk(context, mails, true);
                    },
                  ),
                  _buildActionButton(
                    context,
                    context.t.mail_actions.mark_as_unread,
                    CupertinoIcons.envelope,
                    () {
                      _markReadUnreadBulk(context, mails, false);
                    },
                  ),
                  if (archive != true)
                    _buildActionButton(
                      context,
                      context.t.mail_actions.archive,
                      CupertinoIcons.archivebox,
                      () {
                        _archiveBulk(context, mails);
                      },
                    ),
                  if (trash != true)
                    _buildActionButton(
                      context,
                      context.t.mail_actions.trash,
                      CupertinoIcons.trash,
                      () {
                        _trashBulk(context, mails);
                      },
                    ),
                  if (archive == true)
                    _buildActionButton(
                      context,
                      context.t.mail_actions.unarchive,
                      CupertinoIcons.archivebox,
                      () {
                        _unarchiveBulk(context, mails);
                      },
                    ),
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

  void _markReadUnreadBulk(BuildContext context, List<Mail> mails, bool read) {
    if (read) {
      context
          .read<MailBloc>()
          .add(MarkAsRead(mailIds: mails.map((mail) => mail.id!).toList()));
    } else {
      context
          .read<MailBloc>()
          .add(MarkAsUnread(mailIds: mails.map((mail) => mail.id!).toList()));
    }
  }

  void _archiveBulk(BuildContext context, List<Mail> mails) {
    context
        .read<MailBloc>()
        .add(ArchiveMail(mailIds: mails.map((mail) => mail.id!).toList()));
  }

  void _unarchiveBulk(BuildContext context, List<Mail> mails) {
    context
        .read<MailBloc>()
        .add(UnarchiveMail(mailIds: mails.map((mail) => mail.id!).toList()));
  }

  void _trashBulk(BuildContext context, List<Mail> mails) {
    context
        .read<MailBloc>()
        .add(TrashMail(mailIds: mails.map((mail) => mail.id!).toList()));
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
