import 'package:ab_shared/components/forms/search_bar.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/components/cards/mail_card.dart';
import 'package:mail/services/sync.service.dart';

class FilteredMailScreen extends StatefulWidget {
  final List<dynamic> Function(List<dynamic>? mails) filterFunction;
  final bool? drafts;
  final Function(String)? onDelete;

  const FilteredMailScreen({
    super.key,
    required this.filterFunction,
    this.drafts = false,
    this.onDelete,
  });

  @override
  State<FilteredMailScreen> createState() => _FilteredMailScreenState();
}

class _FilteredMailScreenState extends State<FilteredMailScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MailBloc, MailState>(builder: (context, mailState) {
      List<dynamic> filteredMails = widget.filterFunction(mailState.mails);
      
      if (widget.drafts ?? false) {
        filteredMails = widget.filterFunction(mailState.drafts);
      }

      if (filteredMails.isEmpty) {
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
      } else {
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            SyncService.sync(context);
          },
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: $constants.insets.xs),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: $constants.insets.xs),
                child: ElevatedContainer(
                  child: ABSearchBar(controller: searchController),
                ),
              ),
              SizedBox(height: $constants.insets.xxs),
              ...filteredMails.map((mail) => Padding(
                padding: EdgeInsets.only(bottom: $constants.insets.xs),
                child: MailCard(
                  draft: widget.drafts == true ? mail  : null,
                      mail: widget.drafts != true ? mail  : null,
                      onDelete: widget.onDelete,
                    ),
              ))
            ],
          ),
        );
      }
    });
  }
}


