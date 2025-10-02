import 'package:ab_shared/components/modals/ab_modal.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/pages/app_layout.dart';
import 'package:mail/pages/mails/appbars/mail_appbar.dart';
import 'package:mail/pages/mails/mail_list.dart';
import 'package:mail/pages/mails/no_mail_selected.dart';

class TrashedScreen extends StatelessWidget {
  const TrashedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      final trashedMails = mailState.mails
              ?.where((mail) => mail.trashed == true)
              .toList() ??
          [];
      return Row(
        children: [
          SizedBox(
            width: isDesktop(context) ? 300 : getSize(context).width,
            child: Column(
              children: [
                MailAppbar(
                    sideMenuController: sideMenuController, title: context.t.email_folders.trashed),
                Expanded(
                  child: MailList(
                    mails: mailState.mails
                            ?.where((mail) => mail.trashed == true)
                            .toList() ??
                        [],
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
                                Text(
                                    context.t.trashed.x_mails_trashed(
                                      count: mailState.mails
                                              ?.where((mail) =>
                                                  mail.trashed == true)
                                              .length ??
                                          0,
                                    ),
                                    style: getTextTheme(context)
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold)),
                                Text(context.t.trashed.description,
                                    style: getTextTheme(context)
                                        .bodyMedium!
                                        .copyWith(
                                          color: Colors.grey.shade600,
                                        )),
                                SizedBox(height: $constants.insets.xs),
                                GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => ABModal(
                                              title: context
                                                  .t
                                                  .trashed
                                                  .delete_all_trashed_mails_modal
                                                  .title,
                                              description: context
                                                  .t
                                                  .trashed
                                                  .delete_all_trashed_mails_modal
                                                  .description,
                                              warning: context
                                                  .t
                                                  .trashed
                                                  .delete_all_trashed_mails_modal
                                                  .warning,
                                              onConfirm: () {
                                                context
                                                    .read<MailBloc>()
                                                    .add(EmptyTrash());
                                                Navigator.of(context).pop();
                                              }));
                                    },
                                    child: Text(context.t.trashed.card_title,
                                        style: getTextTheme(context)
                                            .bodyMedium!
                                            .copyWith(
                                                color: getTheme(context).error,
                                                fontWeight: FontWeight.bold))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isDesktop(context)) ...[
            VerticalDivider(
              width: 1,
            ),
            Expanded(child: trashedMails.isEmpty
                  ? NoMailSelectedScreen(
                      title: context.t.email_folders.trashed,
                      numberOfMails: trashedMails.length,
                    )
                  : Container(),),
          ]
        ],
      );
    });
  }
}
