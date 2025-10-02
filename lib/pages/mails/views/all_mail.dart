import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mail/pages/mails/filtered_mail.dart';

class AllMailScreen extends StatelessWidget {
  const AllMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: isDesktop(context) ? 300 : getSize(context).width,
          child: FilteredMailScreen(
            filterFunction: (mails) => mails ?? [],
          ),
        ),
        if (isDesktop(context)) ...[
          VerticalDivider(
            width: 1,
          ),
          Expanded(child: Container()),
        ]
      ],
    );
  }
}
