import 'package:flutter/widgets.dart';
import 'package:mail/pages/mails/filtered_mail.dart';

class TrashedScreen extends StatelessWidget {
  const TrashedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FilteredMailScreen(
      filterFunction: (mails) => mails?.where((mail) => mail.trashed == true).toList() ?? [],
    );
  }
}