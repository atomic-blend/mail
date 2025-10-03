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
import 'package:mail/components/cards/big_mail_card.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';

enum MailScreenMode {
  integrated,
  standalone,
}

class MailDetailScreen extends ResponsiveStatefulWidget {
  final Mail mail;
  final MailScreenMode mode;
  const MailDetailScreen(this.mail,
      {super.key, this.mode = MailScreenMode.standalone});

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
        return ElevatedContainer(
          width: double.infinity,
          disableShadow: true,
          border: Border.all(
            color: isDarkMode(context) ? Colors.grey.shade800 : Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: $constants.insets.md),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            BorderRadius.circular($constants.corners.full),
                      ),
                      child: Icon(
                        widget.mode == MailScreenMode.standalone
                            ? CupertinoIcons.chevron_back
                            : CupertinoIcons.xmark,
                        size: 15,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: $constants.insets.md),
                    child: AutoSizeText(
                      maxLines: 1,
                      mail.getHeader("Subject"),
                      overflow: TextOverflow.ellipsis,
                      style: getTextTheme(context).headlineMedium!.copyWith(
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
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: $constants.insets.sm),
              //   child: Divider(),
              // ),
              // Content section - expands to fill remaining space
              Padding(
                padding: EdgeInsets.only(
                  left: $constants.insets.sm,
                  right: $constants.insets.sm,
                  bottom: $constants.insets.sm,
                ),
                child: BigMailCard(mail: mail),
              ),
              if (widget.mode == MailScreenMode.standalone) ...[
                SizedBox(height: $constants.insets.sm),
                Divider(),
                Container(
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
                            context.read<MailBloc>().add(ArchiveMail(mail.id!));
                          } else {
                            context
                                .read<MailBloc>()
                                .add(UnarchiveMail(mail.id!));
                          }
                        },
                        icon: mail.archived == true
                            ? Icon(CupertinoIcons.tray_arrow_down)
                            : Icon(CupertinoIcons.archivebox),
                      ),
                      IconButton(
                        onPressed: () {
                          if (mail.trashed != true) {
                            context.read<MailBloc>().add(TrashMail(mail.id!));
                          } else {
                            context.read<MailBloc>().add(UntrashMail(mail.id!));
                          }
                          Navigator.of(context).pop();
                        },
                        icon: mail.trashed == true
                            ? Icon(CupertinoIcons.trash_slash)
                            : Icon(CupertinoIcons.trash),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      }),
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
