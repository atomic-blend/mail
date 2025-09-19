import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/pages/mails/filtered_mail.dart';
import 'package:mail/services/sync.service.dart';

class DraftScreen extends StatefulWidget {
  const DraftScreen({super.key});

  @override
  State<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends State<DraftScreen> {
  @override
  void initState() {
    SyncService.sync(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FilteredMailScreen(
      drafts: true,
      onDelete: (draftId) {
        context.read<MailBloc>().add(DeleteDraft(draftId));
      },
      filterFunction: (mails) {
        return mails ?? [];
      },
    );
  }
}
