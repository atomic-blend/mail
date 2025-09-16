import 'package:ab_shared/components/modals/ab_modal.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/pages/mails/filtered_mail.dart';

class TrashedScreen extends StatelessWidget {
  const TrashedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FilteredMailScreen(
      filterFunction: (mails) =>
          mails?.where((mail) => mail.trashed == true).toList() ?? [],
      header: ElevatedContainer(
        border: Border.all(color: getTheme(context).error),
        padding: EdgeInsets.symmetric(
          horizontal: $constants.insets.sm,
          vertical: $constants.insets.xs + $constants.insets.xxs,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(CupertinoIcons.trash, size: 30),
            SizedBox(width: $constants.insets.xs),
            SizedBox(
              width: getSize(context).width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("xxx mails trashed",
                      style: getTextTheme(context)
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(
                      "Those are the mails that have been trashed by you, they will be deleted after 30 days.",
                      style: getTextTheme(context).bodyMedium!.copyWith(
                            color: Colors.grey.shade600,
                          )),
                  SizedBox(height: $constants.insets.xs),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => ABModal(
                                title: "Delete all trashed mails",
                                description:
                                    "Are you sure you want to delete all trashed mails?",
                                warning: "This action cannot be undone.",
                                onConfirm: () {
                                  context.read<MailBloc>().add(EmptyTrash());
                                  Navigator.of(context).pop();
                                }));
                      },
                      child: Text("Delete all trashed mails",
                          style: getTextTheme(context).bodyMedium!.copyWith(
                              color: getTheme(context).error,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
