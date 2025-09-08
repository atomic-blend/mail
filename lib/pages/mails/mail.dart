import 'package:ab_shared/components/forms/search_bar.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/services/sync.service.dart';

class MailScreen extends StatefulWidget {
  const MailScreen({super.key});

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      if (true) {
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            SyncService.sync(context);
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: $constants.insets.sm,
                    vertical: $constants.insets.xs),
                child: ElevatedContainer(
                  child: ABSearchBar(controller: searchController),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(
                    top: getSize(context).height * 0.15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedContainer(
                      width: getSize(context).width * 0.65,
                      // height: getSize(context).height * 0.15,
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
                            style:
                                getTextTheme(context).headlineMedium!.copyWith(
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
    });
  }
}
