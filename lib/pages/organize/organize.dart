import 'package:ab_shared/components/forms/search_bar.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/services/sync.service.dart';

class OrganizeScreen extends StatefulWidget {
  const OrganizeScreen({super.key});

  @override
  State<OrganizeScreen> createState() => _OrganizeScreenState();
}

class _OrganizeScreenState extends State<OrganizeScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      final inboxMails = mailState.mails
              ?.where((mail) => mail.archived != true && mail.trashed != true)
              .toList() ??
          [];
      if (inboxMails.isEmpty) {
        return _buildNothingToOrganize();
      }
      return _buildOrganizer(inboxMails);
    });
  }

  Widget _buildNothingToOrganize() {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        SyncService.sync(context);
      },
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding:
                EdgeInsetsGeometry.only(top: getSize(context).height * 0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedContainer(
                  width: getSize(context).width * 0.65,
                  padding: EdgeInsets.all($constants.insets.sm),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        CupertinoIcons.rocket,
                        size: 40,
                      ),
                      SizedBox(height: $constants.insets.sm),
                      Text(
                        "Congratulations!",
                        style: getTextTheme(context).headlineMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(height: $constants.insets.xs),
                      Text(
                        "You don't have any unread messages.",
                        textAlign: TextAlign.center,
                        style: getTextTheme(context).bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizer(List<Mail> inboxMails) {
    return Container();
  }
}
