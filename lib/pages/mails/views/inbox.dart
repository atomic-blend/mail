import 'package:flutter/widgets.dart';
import 'package:mail/pages/mails/filtered_mail.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FilteredMailScreen(
      filterFunction: (mails) {
        return mails?.where((mail) => mail.archived != true && mail.trashed != true).toList() ?? [];
      },
    );
  }
}