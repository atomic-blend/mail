import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:mail/models/mail/mail.dart';

class MailCard extends StatelessWidget {
  final Mail mail;
  const MailCard({super.key, required this.mail});

  @override
  Widget build(BuildContext context) {
    return ElevatedContainer(
      padding: EdgeInsets.symmetric(
          horizontal: $constants.insets.sm, vertical: $constants.insets.xs + 4),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular($constants.corners.full),
            ),
            child: Center(
              child: Text(
                getInitials(mail.getHeader("From")),
                style: getTextTheme(context)
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: $constants.insets.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mail.getHeader("Subject"),
                style: getTextTheme(context).headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: $constants.insets.xxs),
              Text(
                mail.textContent ?? mail.htmlContent ?? "No content",
                style: getTextTheme(context).bodyMedium,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                maxLines: 1,
              ),
            ],
          ),
        ],
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
}
