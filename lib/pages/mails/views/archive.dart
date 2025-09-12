import 'package:flutter/widgets.dart';
import 'package:mail/pages/mails/filtered_mail.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FilteredMailScreen(
      filterFunction: (mails) => mails?.where((mail) => mail.archived == true).toList() ?? [],
    );
  }
}