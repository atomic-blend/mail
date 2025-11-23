import 'package:ab_shared/components/app/conditional_parent_wrapper.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mail/components/avatars/mail_user_avatar.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/mails/composer/mail_composer.dart';

class BigMailCard extends StatefulWidget {
  final Mail mail;
  final bool? isSent;
  final Color? backgroundColor;
  final bool collapsed;
  final bool? readOnly;
  const BigMailCard(
      {super.key,
      required this.mail,
      this.isSent,
      this.readOnly,
      this.backgroundColor,
      this.collapsed = false});

  @override
  State<BigMailCard> createState() => _BigMailCardState();
}

class _BigMailCardState extends State<BigMailCard> {
  bool _collapsed = false;

  @override
  void initState() {
    super.initState();
    _collapsed = widget.collapsed;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_collapsed == true || widget.readOnly == true) {
          setState(() {
            _collapsed = !_collapsed;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: $constants.insets.md,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? getTheme(context).surface,
          borderRadius: BorderRadius.circular($constants.corners.md),
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: $constants.insets.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MailUserAvatar(
                    value: widget.mail.getHeader("From"),
                    read: widget.mail.read != true || widget.isSent != true),
                SizedBox(width: $constants.insets.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildPeopleRow(
                      context,
                      context.t.mail_composer.from,
                      widget.mail.getHeader("From"),
                      widget.mail,
                      widget.isSent,
                    ),
                    buildPeopleRow(
                      context,
                      context.t.mail_composer.to,
                      widget.mail.getHeader("To"),
                      widget.mail,
                      widget.isSent,
                    ),
                    if (!isDesktop(context))
                      buildPeopleRow(
                        context,
                        context.t.mail_composer.date,
                        "${Jiffy.parseFromDateTime(widget.mail.createdAt!).yMd.toString()} ${Jiffy.parseFromDateTime(widget.mail.createdAt!).Hm.toString()}",
                        widget.mail,
                        widget.isSent,
                        valueTextStyle: getTextTheme(context).bodySmall!,
                      ),
                  ],
                ),
                Spacer(),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 100,
                  ),
                  child: Wrap(
                    children: [
                      if (_collapsed != true && widget.readOnly != true)
                        _buildActionPill(
                            context: context,
                            icon: CupertinoIcons.reply,
                            onTap: () {
                              MailComposerHelper.openMailComposer(
                                context,
                                inReplyTo: widget.mail,
                              );
                            }),
                    ],
                  ),
                ),
                SizedBox(width: $constants.insets.sm),
                if (isDesktop(context))
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (widget.mail.createdAt != null)
                        Text(
                          Jiffy.parseFromDateTime(widget.mail.createdAt!)
                              .yMd
                              .toString(),
                          style: getTextTheme(context)
                              .bodySmall!
                              .copyWith(color: Colors.grey),
                        ),
                      if (widget.mail.createdAt != null)
                        Text(
                          Jiffy.parseFromDateTime(widget.mail.createdAt!)
                              .Hm
                              .toString(),
                          style: getTextTheme(context)
                              .bodySmall!
                              .copyWith(color: Colors.grey),
                        )
                    ],
                  )
              ],
            ),
            SizedBox(height: $constants.insets.sm),
            if (!_collapsed) ...[
              Text(
                getContent(context, widget.mail),
                textAlign: TextAlign.left,
                style: getTextTheme(context).bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String getContent(BuildContext context, Mail mail) {
    if (mail.htmlContent != null && mail.htmlContent != "") {
      return mail.htmlContent!;
    } else if (mail.textContent != null && mail.textContent!.isNotEmpty) {
      return mail.textContent!;
    } else {
      return context.t.mail_card.no_content;
    }
  }

  Widget buildPeopleRow(BuildContext context, String label, dynamic value,
      Mail mail, bool? isSent,
      {TextStyle? valueTextStyle}) {
    String displayValue = value is List ? value.join(", ") : value.toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$label: ",
          style: getTextTheme(context).bodyMedium!.copyWith(color: Colors.grey),
        ),
        SizedBox(width: $constants.insets.xs),
        Text(
          displayValue,
          style: valueTextStyle ??
              getTextTheme(context).bodyMedium!.copyWith(
                  fontWeight: mail.read != true && isSent != true
                      ? FontWeight.bold
                      : null),
        ),
      ],
    );
  }

  Widget _buildActionPill({
    required BuildContext context,
    String? text,
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    Border? border,
    VoidCallback? onTap,
  }) {
    return ElevatedContainer(
      padding: EdgeInsets.symmetric(
        horizontal: $constants.insets.xs,
        vertical: $constants.insets.xs,
      ),
      color: backgroundColor ?? getTheme(context).surface,
      border: border,
      blurRadius: 1,
      borderRadius: $constants.corners.sm,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: textColor,
            ),
          ],
          if (text != null) ...[
            SizedBox(width: $constants.insets.xs),
            Text(
              text,
              style: getTextTheme(context).bodySmall!.copyWith(
                    color: textColor,
                  ),
            ),
          ]
        ],
      ),
    );
  }
}
