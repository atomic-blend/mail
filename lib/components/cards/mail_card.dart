import 'package:ab_shared/components/app/window_layout/window_layout_controller.dart';
import 'package:ab_shared/components/modals/ab_modal.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/components/avatars/checkbox_avatar.dart';
import 'package:mail/components/avatars/mail_user_avatar.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/mails/composer/mail_composer.dart';
import 'package:mail/pages/mails/composer/window_mail_composer.dart';
import 'package:mail/pages/mails/mail_details.dart';
import 'package:mail/services/sync.service.dart';
import 'package:mail/models/send_mail/send_mail.dart' as send_mail;
import 'package:mail/utils/get_it.dart';

class MailCard extends StatefulWidget {
  final Mail? mail;
  final send_mail.SendMail? draft;

  final bool? isSent;
  final Function(String)? onDelete;
  final Function(dynamic)? onSelect;
  final Function(dynamic)? onDeselect;
  final Function(dynamic)? onTap;
  final List<dynamic> selectedMails;
  final bool? selectMode;
  final Function(bool)? setSelectMode;
  final bool? enabled;
  final Color? backgroundColor;
  const MailCard(
      {super.key,
      this.mail,
      this.draft,
      this.isSent,
      this.onDelete,
      this.onSelect,
      this.onDeselect,
      this.selectedMails = const [],
      this.selectMode,
      this.setSelectMode,
      this.enabled = true,
      this.backgroundColor,
      this.onTap});

  @override
  State<MailCard> createState() => _MailCardState();
}

class _MailCardState extends State<MailCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Mail? mail = widget.mail ?? widget.draft!.mail;
    if (mail == null) {
      return const SizedBox.shrink();
    }

    final statusPill = _buildStatusPillList(
      context: context,
      mail: mail,
      draft: widget.draft,
      isSent: widget.isSent == true,
    );
    return LayoutBuilder(builder: (context, constraints) {
      return Slidable(
        enabled: widget.enabled == true && widget.isSent != true,
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SizedBox(
            width: $constants.insets.xs,
          ),
          if (widget.isSent != true)
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
                              title:
                                  context.t.mail_card.delete_draft_modal.title,
                              description: context
                                  .t.mail_card.delete_draft_modal.description,
                              warning: context
                                  .t.mail_card.delete_draft_modal.warning,
                              onConfirm: () {
                                widget.onDelete?.call(widget.draft!.id!);
                                Navigator.of(context).pop();
                              },
                            ));
                  } else {
                    if (mail.trashed != true) {
                      context.read<MailBloc>().add(TrashMail(mailId: mail.id!));
                    } else {
                      context
                          .read<MailBloc>()
                          .add(UntrashMail(mailId: mail.id!));
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
                    context.read<MailBloc>().add(ArchiveMail(mailId: mail.id!));
                  } else {
                    context
                        .read<MailBloc>()
                        .add(UnarchiveMail(mailId: mail.id!));
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
            if (widget.enabled == false) return;
            setState(() {
              isHovering = true;
            });
          },
          onExit: (event) {
            if (widget.enabled == false) return;
            setState(() {
              isHovering = false;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isHovering || (widget.selectedMails.contains(mail))
                  ? widget.backgroundColor?.darken(3) ??
                      getTheme(context).surfaceContainer
                  : widget.backgroundColor,
              borderRadius: BorderRadius.circular($constants.corners.sm),
            ),
            padding: EdgeInsets.only(
              left: $constants.insets.sm,
              top: $constants.insets.xs,
              bottom: $constants.insets.xs,
            ),
            child: GestureDetector(
              onLongPress: () {
                widget.setSelectMode?.call(true);
                _toggleSelected(mail);
              },
              onTap: () async {
                if (widget.onTap != null) {
                  widget.onTap?.call(mail);
                  return;
                }
                if (widget.draft == null) {
                  // on mobile, open the mail in the detail screen only when no mails are selected (ie not in multi-select mode)
                  if (!isDesktop(context)) {
                    if (widget.selectedMails.isEmpty) {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MailDetailScreen(
                                mail,
                                onCancel: () {
                                  Navigator.of(context).pop();
                                },
                              )));
                    } else {
                      // when in multi-select mode, toggle the selection of the mail
                      _toggleSelected(mail);
                    }
                    if (!context.mounted) return;
                    SyncService.sync(context);
                  } else {
                    if (getSize(context).width < $constants.screenSize.md) {
                      // on mobile, tapping the mail opens it in the detail screen
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MailDetailScreen(
                            mail,
                            onCancel: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      );
                    } else {
                      // on desktop, tapping the mail opens it in the preview panel
                      // multi-select mode enables itself when the user clicks on the avatar / checkbox
                      _toggleSelected(
                        mail,
                        reset: widget.selectMode != true,
                      );
                    }
                  }
                } else {
                  if (widget.isSent == true) {
                    if (getSize(context).width < $constants.screenSize.md) {
                      // on mobile, tapping the mail opens it in the detail screen
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MailDetailScreen(
                            mail,
                            isSent: true,
                            onCancel: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      );
                    } else {
                      // on desktop, tapping the mail opens it in the preview panel
                      // multi-select mode enables itself when the user clicks on the avatar / checkbox
                      _toggleSelected(
                        mail,
                        reset: widget.selectMode != true,
                      );
                    }
                  } else {
                    _openComposer(context);
                  }
                }
              },
              child: Row(
                children: [
                  if (widget.selectMode == true &&
                      widget.selectedMails.contains(mail))
                    CheckboxAvatar(
                      checked: widget.selectedMails.contains(mail),
                      onTap: () {
                        if (isDesktop(context)) {
                          if (widget.selectMode == true &&
                              widget.selectedMails.length == 1) {
                            widget.setSelectMode?.call(false);
                          } else {
                            widget.setSelectMode?.call(true);
                          }
                        } else {
                          widget.setSelectMode?.call(true);
                        }
                        _toggleSelected(mail, reset: widget.selectMode != true);
                      },
                    )
                  else
                    MailUserAvatar(
                      value: mail.getHeader("From"),
                      read: mail.read == true || widget.draft != null,
                      onTap: () {
                        if (isDesktop(context)) {
                          if (widget.selectMode == true &&
                              widget.selectedMails.length == 1 &&
                              widget.selectedMails.contains(mail)) {
                            widget.setSelectMode?.call(false);
                          } else {
                            widget.setSelectMode?.call(true);
                          }
                        } else {
                          widget.setSelectMode?.call(true);
                        }
                        _toggleSelected(mail, reset: widget.selectMode != true);
                      },
                    ),
                  SizedBox(width: $constants.insets.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: isDesktop(context)
                            ? constraints.maxWidth * 0.63
                            : null,
                        child: AutoSizeText(
                          mail.getHeader("From"),
                          style: getTextTheme(context).headlineSmall!.copyWith(
                                fontWeight:
                                    mail.read != true && widget.draft == null
                                        ? FontWeight.bold
                                        : null,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: $constants.insets.xxs),
                      SizedBox(
                        width: isDesktop(context)
                            ? constraints.maxWidth * 0.63
                            : null,
                        child: AutoSizeText(
                          mail.getHeader("Subject"),
                          style: getTextTheme(context).bodyMedium!.copyWith(
                                fontWeight:
                                    mail.read != true && widget.draft == null
                                        ? FontWeight.bold
                                        : null,
                              ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  if (statusPill != null) ...[
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: $constants.insets.xs),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: 130,
                        ),
                        child: statusPill,
                      ),
                    ),
                  ],
                  if (widget.selectMode == true) ...[
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (isDesktop(context)) {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              insetPadding: EdgeInsets.zero,
                              child: SizedBox(
                                width: getSize(context).width * 0.8,
                                height: getSize(context).height * 0.8,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      $constants.corners.lg),
                                  child: MailDetailScreen(
                                    mail,
                                    mode: MailScreenMode.integrated,
                                    onCancel: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SizedBox(
                              height: getSize(context).height * 0.8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular($constants.corners.lg),
                                  topRight:
                                      Radius.circular($constants.corners.lg),
                                ),
                                child: MailDetailScreen(
                                  mail,
                                  mode: MailScreenMode.integrated,
                                  onCancel: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all($constants.insets.xs),
                        decoration: BoxDecoration(
                          color: getTheme(context).surfaceContainer.lighten(10),
                          borderRadius:
                              BorderRadius.circular($constants.corners.sm),
                        ),
                        child: Icon(
                          CupertinoIcons.eye,
                          size: 17,
                        ),
                      ),
                    ),
                    SizedBox(width: $constants.insets.xs),
                  ]
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _toggleSelected(Mail mail, {bool reset = false}) {
    if (reset) {
      widget.selectedMails.clear();
    }
    if (widget.selectedMails.contains(mail)) {
      widget.onDeselect?.call(mail);
    } else {
      widget.onSelect?.call(mail);
    }
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
      getIt<WindowLayoutController>().addWindow(
        WindowMailComposer(
          initiallyCollapsed: false,
          draft: widget.draft,
        ),
      );
    } else {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        useRootNavigator: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => SizedBox(
            height: getSize(context).height * 0.88,
            child: MailComposer(
              mail: widget.draft,
            )),
      );
    }
  }

  Widget? _buildStatusPillList({
    required BuildContext context,
    Mail? mail,
    send_mail.SendMail? draft,
    bool? isSent,
  }) {
    if (draft != null) {
      if (isSent == true) {
        return _buildStatusPill(
            context: context,
            icon: _getSentMailIcon(status: draft.sendStatus),
            text: draft.sendStatus.name,
            color: _getSentMailColor(status: draft.sendStatus));
      } else {
        return _buildStatusPill(
          context: context,
          icon: CupertinoIcons.create,
          text: "Draft",
          color: Colors.grey.shade900,
        );
      }
    }
    return null;
  }

  IconData? _getSentMailIcon({
    required send_mail.SendStatus? status,
  }) {
    switch (status) {
      case send_mail.SendStatus.sent:
        return CupertinoIcons.paperplane_fill;
      case send_mail.SendStatus.failed:
        return CupertinoIcons.exclamationmark_circle;
      case send_mail.SendStatus.retry:
        return CupertinoIcons.arrow_2_circlepath;
      case send_mail.SendStatus.pending:
        return CupertinoIcons.clock;
      default:
        return null;
    }
  }

  Color? _getSentMailColor({
    required send_mail.SendStatus? status,
  }) {
    switch (status) {
      case send_mail.SendStatus.sent:
        return Colors.blue;
      case send_mail.SendStatus.failed:
        return Colors.red;
      case send_mail.SendStatus.retry:
        return Colors.orange;
      case send_mail.SendStatus.pending:
        return Colors.black;
      default:
        return null;
    }
  }

  Widget _buildStatusPill({
    required BuildContext context,
    required String text,
    Color? color,
    IconData? icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: $constants.insets.xs,
        vertical: $constants.insets.xxs,
      ),
      decoration: BoxDecoration(
        color: color?.withValues(alpha: 0.1) ??
            getTheme(context).primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular($constants.corners.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 12,
              color: color ?? getTheme(context).primary,
            ),
            SizedBox(width: $constants.insets.xxs),
          ],
          Text(
            text,
            style: getTextTheme(context).bodySmall!.copyWith(
                  color: color ?? getTheme(context).primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
