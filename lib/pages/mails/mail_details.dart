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
    context.read<MailBloc>().add(MarkAsRead(widget.mail.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: $constants.insets.sm),
                  child: AutoSizeText(
                    maxLines: 1,
                    widget.mail.getHeader("Subject"),
                    overflow: TextOverflow.ellipsis,
                    style: getTextTheme(context).displaySmall!.copyWith(
                          fontWeight:
                              widget.mail.read != true ? FontWeight.bold : null,
                        ),
                  ),
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
                            value: widget.mail.getHeader("From"),
                            read: widget.mail.read),
                        SizedBox(width: $constants.insets.sm),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildPeopleRow(
                                "From", widget.mail.getHeader("From")),
                            buildPeopleRow("To", widget.mail.getHeader("To")),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                Jiffy.parseFromDateTime(widget.mail.createdAt!)
                                    .yMd
                                    .toString(),
                                style: getTextTheme(context)
                                    .bodySmall!
                                    .copyWith(color: Colors.grey),
                              ),
                              Text(
                                Jiffy.parseFromDateTime(widget.mail.createdAt!)
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
                        getContent(),
                        textAlign: TextAlign.left,
                        style: getTextTheme(context).bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: $constants.insets.lg),
        ],
      ),
    );
  }

  String getContent() {
    if (widget.mail.htmlContent != null && widget.mail.htmlContent != "") {
      return widget.mail.htmlContent!;
    } else if (widget.mail.textContent != null &&
        widget.mail.textContent!.isNotEmpty) {
      return widget.mail.textContent!;
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
