import 'package:ab_shared/components/modals/ab_modal.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/components/avatars/mail_user_avatar.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/mails/mail_composer.dart';
import 'package:mail/pages/mails/mail_details.dart';
import 'package:mail/services/sync.service.dart';
import 'package:mail/models/send_mail/send_mail.dart' as send_mail;

class MailCard extends StatefulWidget {
  final Mail? mail;
  final send_mail.SendMail? draft;
  final Function(String)? onDelete;
  const MailCard({super.key, this.mail, this.draft, this.onDelete});

  @override
  State<MailCard> createState() => _MailCardState();
}

class _MailCardState extends State<MailCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Mail? mail = this.widget.mail ?? widget.draft!.mail;
    if (mail == null) {
      return const SizedBox.shrink();
    }
    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SizedBox(
          width: $constants.insets.xs,
        ),
        Theme(
          data: Theme.of(context).copyWith(
              outlinedButtonTheme: const OutlinedButtonThemeData(
            style: ButtonStyle(
                iconColor: WidgetStatePropertyAll(Colors.white),
                iconSize: WidgetStatePropertyAll(25)),
          )),
          child: SlidableAction(
            onPressed: (context) {
              if (widget.draft != null) {
                showDialog(
                    context: context,
                    builder: (context) => ABModal(
                          title: context.t.mail_card.delete_draft_modal.title,
                          description: context
                              .t.mail_card.delete_draft_modal.description,
                          warning:
                              context.t.mail_card.delete_draft_modal.warning,
                          onConfirm: () {
                            widget.onDelete?.call(widget.draft!.id!);
                            Navigator.of(context).pop();
                          },
                        ));
              } else {
                if (mail.trashed != true) {
                  context.read<MailBloc>().add(TrashMail(mail.id!));
                } else {
                  context.read<MailBloc>().add(UntrashMail(mail.id!));
                }
              }
            },
            backgroundColor: getTheme(context).error,
            foregroundColor: Colors.white,
            icon: widget.draft != null
                ? CupertinoIcons.delete
                : mail.trashed != true
                    ? CupertinoIcons.delete
                    : CupertinoIcons.trash_slash,
            borderRadius: BorderRadius.circular(
              $constants.corners.sm,
            ),
          ),
        ),
        SizedBox(
          width: $constants.insets.xs,
        ),
        if (widget.draft == null)
          Theme(
            data: Theme.of(context).copyWith(
                outlinedButtonTheme: const OutlinedButtonThemeData(
              style: ButtonStyle(
                  iconColor: WidgetStatePropertyAll(Colors.white),
                  iconSize: WidgetStatePropertyAll(25)),
            )),
            child: SlidableAction(
              onPressed: (context) {
                if (mail.archived != true) {
                  context.read<MailBloc>().add(ArchiveMail(mail.id!));
                } else {
                  context.read<MailBloc>().add(UnarchiveMail(mail.id!));
                }
              },
              backgroundColor: getTheme(context).tertiary,
              foregroundColor: Colors.white,
              icon: mail.archived == true
                  ? CupertinoIcons.tray_arrow_down
                  : CupertinoIcons.archivebox,
              borderRadius: BorderRadius.circular(
                $constants.corners.sm,
              ),
            ),
          ),
      ]),
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHovering = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHovering = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isHovering ? getTheme(context).surfaceContainer : null,
            borderRadius: BorderRadius.circular($constants.corners.sm),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: $constants.insets.sm,
            vertical: $constants.insets.xs,
          ),
          child: GestureDetector(
            onTap: () async {
              if (widget.draft == null) {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MailDetailScreen(
                          mail,
                        )));
                if (!context.mounted) return;
                SyncService.sync(context);
              } else {
                _openComposer(context);
              }
            },
            child: IntrinsicWidth(
              child: Row(
                children: [
                  MailUserAvatar(
                      value: mail.getHeader("From"), read: mail.read),
                  SizedBox(width: $constants.insets.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            mail.getHeader("From"),
                            style:
                                getTextTheme(context).headlineSmall!.copyWith(
                                      fontWeight: mail.read != true
                                          ? FontWeight.bold
                                          : null,
                                    ),
                          ),
                          if (mail.read != true) ...[
                            SizedBox(width: $constants.insets.sm),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(
                                    $constants.corners.full),
                              ),
                            ),
                          ]
                        ],
                      ),
                      SizedBox(height: $constants.insets.xxs),
                      Text(
                        mail.getHeader("Subject"),
                        style: getTextTheme(context).bodyMedium!.copyWith(
                              fontWeight:
                                  mail.read != true ? FontWeight.bold : null,
                            ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = names.length >= 2 ? 2 : 1;
    for (var i = 0; i < numWords; i++) {
      if (names[i].isNotEmpty) {
        initials += names[i][0];
      }
    }
    return initials.toUpperCase();
  }

  void _openComposer(BuildContext context) {
    if (isDesktop(context)) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: SizedBox(
                  height: getSize(context).height * 0.8,
                  width: getSize(context).width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular($constants.corners.md),
                    child: MailComposer(
                      mail: widget.draft,
                    ),
                  ),
                ),
              ));
    } else {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => SizedBox(
            height: getSize(context).height * 0.92,
            child: MailComposer(mail: widget.draft)),
      );
    }
  }
}
