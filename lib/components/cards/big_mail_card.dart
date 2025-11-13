import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mail/components/avatars/mail_user_avatar.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/mail/mail.dart';

class BigMailCard extends StatelessWidget {
  final Mail mail;
  final bool? isSent;
  final Color? backgroundColor;
  const BigMailCard(
      {super.key, required this.mail, this.isSent, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: $constants.insets.md,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? getTheme(context).surface,
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
                  value: mail.getHeader("From"),
                  read: mail.read != true || isSent != true),
              SizedBox(width: $constants.insets.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildPeopleRow(
                    context,
                    context.t.mail_composer.from,
                    mail.getHeader("From"),
                    mail,
                    isSent,
                  ),
                  buildPeopleRowList(
                    context,
                    context.t.mail_composer.to,
                    mail.getHeader("To"),
                    mail,
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (mail.createdAt != null)
                    Text(
                      Jiffy.parseFromDateTime(mail.createdAt!).yMd.toString(),
                      style: getTextTheme(context)
                          .bodySmall!
                          .copyWith(color: Colors.grey),
                    ),
                  if (mail.createdAt != null)
                    Text(
                      Jiffy.parseFromDateTime(mail.createdAt!).Hm.toString(),
                      style: getTextTheme(context)
                          .bodySmall!
                          .copyWith(color: Colors.grey),
                    )
                ],
              )
            ],
          ),
          SizedBox(height: $constants.insets.sm),
          Text(
            getContent(context, mail),
            textAlign: TextAlign.left,
            style: getTextTheme(context).bodyMedium,
          ),
        ],
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

  Widget buildPeopleRow(BuildContext context, String label, String value,
      Mail mail, bool? isSent) {
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
              fontWeight:
                  mail.read != true && isSent != true ? FontWeight.bold : null),
        ),
      ],
    );
  }

  Widget buildPeopleRowList(
      BuildContext context, String label, List<dynamic> value, Mail mail) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$label: ",
          style: getTextTheme(context).bodyMedium!.copyWith(color: Colors.grey),
        ),
        SizedBox(width: $constants.insets.xs),
        Text(
          value.join(", "),
          style: getTextTheme(context).bodyMedium!.copyWith(
              fontWeight:
                  mail.read != true && isSent != true ? FontWeight.bold : null),
        ),
      ],
    );
  }
}
