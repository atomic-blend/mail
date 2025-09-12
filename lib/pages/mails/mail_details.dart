import 'package:ab_shared/components/responsive_stateful_widget.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/components/avatars/mail_user_avatar.dart';
import 'package:mail/models/mail/mail.dart';

class MailDetailScreen extends ResponsiveStatefulWidget {
  final Mail mail;
  const MailDetailScreen(this.mail, {super.key});

  @override
  ResponsiveState<MailDetailScreen> createState() => MailDetailScreenState();
}

class MailDetailScreenState extends ResponsiveState<MailDetailScreen> {
  @override
  void initState() {
    if (widget.mail.read != true) {
      context.read<MailBloc>().add(MarkAsRead(widget.mail.id!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
        final mail = mailState.mails
                ?.firstWhere((element) => element.id == widget.mail.id) ??
            widget.mail;
        return Column(
          children: [
            ElevatedContainer(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getSize(context).height * 0.05,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(CupertinoIcons.chevron_back)),
                  SizedBox(height: $constants.insets.sm),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: $constants.insets.sm),
                        child: AutoSizeText(
                          maxLines: 1,
                          mail.getHeader("Subject"),
                          overflow: TextOverflow.ellipsis,
                          style: getTextTheme(context).displaySmall!.copyWith(
                                fontWeight:
                                    mail.read != true ? FontWeight.bold : null,
                              ),
                        ),
                      ),
                      if (mail.read != true) ...[
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular($constants.corners.full),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: $constants.insets.sm),
                ],
              ),
            ),
            SizedBox(height: $constants.insets.sm),
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: $constants.insets.xs,
                ),
                child: ElevatedContainer(
                  padding: EdgeInsets.symmetric(
                      horizontal: $constants.insets.sm,
                      vertical: $constants.insets.sm),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MailUserAvatar(
                              value: mail.getHeader("From"), read: mail.read),
                          SizedBox(width: $constants.insets.sm),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildPeopleRow("From", mail.getHeader("From")),
                              buildPeopleRow("To", mail.getHeader("To")),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  Jiffy.parseFromDateTime(mail.createdAt!)
                                      .yMd
                                      .toString(),
                                  style: getTextTheme(context)
                                      .bodySmall!
                                      .copyWith(color: Colors.grey),
                                ),
                                Text(
                                  Jiffy.parseFromDateTime(mail.createdAt!)
                                      .Hm
                                      .toString(),
                                  style: getTextTheme(context)
                                      .bodySmall!
                                      .copyWith(color: Colors.grey),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: $constants.insets.xs),
                      Divider(),
                      SizedBox(height: $constants.insets.xs),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: $constants.insets.sm,
                          vertical: $constants.insets.xs,
                        ),
                        width: double.infinity,
                        child: Text(
                          getContent(mail),
                          textAlign: TextAlign.left,
                          style: getTextTheme(context).bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: $constants.insets.sm),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: $constants.insets.xs),
              child: ElevatedContainer(
                  padding: EdgeInsets.symmetric(
                    horizontal: $constants.insets.sm,
                  ),
                  height: 60,
                  child: Row(
                    spacing: $constants.insets.xs,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (mail.read == true) {
                            context
                                .read<MailBloc>()
                                .add(MarkAsUnread(mail.id!));
                          } else {
                            context.read<MailBloc>().add(MarkAsRead(mail.id!));
                          }
                        },
                        icon: mail.read == true
                            ? Icon(CupertinoIcons.envelope_open)
                            : Icon(CupertinoIcons.envelope),
                      ),
                      IconButton(
                        onPressed: () {
                          if (mail.archived != true) {
                            context
                                .read<MailBloc>()
                                .add(ArchiveMail(mail.id!));
                          } else {
                            context.read<MailBloc>().add(UnarchiveMail(mail.id!));
                          }
                        },
                        icon: mail.archived == true
                            ? Icon(CupertinoIcons.tray_arrow_down)
                            : Icon(CupertinoIcons.archivebox),
                      ),
                      IconButton(
                        onPressed: () {
                          if (mail.trashed != true) {
                            context
                                .read<MailBloc>()
                                .add(TrashMail(mail.id!));
                          } else {
                            context.read<MailBloc>().add(UntrashMail(mail.id!));
                          }
                        },
                        icon: mail.trashed == true
                            ? Icon(CupertinoIcons.trash_slash)
                            : Icon(CupertinoIcons.trash),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: $constants.insets.xl),
          ],
        );
      }),
    );
  }

  String getContent(Mail mail) {
    if (mail.htmlContent != null && mail.htmlContent != "") {
      return mail.htmlContent!;
    } else if (mail.textContent != null && mail.textContent!.isNotEmpty) {
      return mail.textContent!;
    } else {
      return "No content";
    }
  }

  Widget buildPeopleRow(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$label: ",
          style: getTextTheme(context).bodyMedium!.copyWith(color: Colors.grey),
        ),
        SizedBox(width: $constants.insets.xs),
        Text(
          value,
          style: getTextTheme(context).bodyMedium!.copyWith(
              fontWeight: widget.mail.read != true ? FontWeight.bold : null),
        ),
      ],
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return build(context);
  }

  @override
  Widget buildMobile(BuildContext context) {
    return build(context);
  }
}
