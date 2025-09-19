import 'package:ab_shared/components/forms/search_bar.dart';
import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/components/cards/mail_card.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/services/sync.service.dart';

class FilteredMailScreen extends StatefulWidget {
  final List<dynamic> Function(List<dynamic>? mails) filterFunction;
  final bool? drafts;
  final Widget? header;
  final Function(String)? onDelete;

  const FilteredMailScreen({
    super.key,
    required this.filterFunction,
    this.drafts = false,
    this.onDelete,
    this.header,
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
                            context.t.zero_inbox_card.title,
                            style:
                                getTextTheme(context).headlineMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          SizedBox(height: $constants.insets.xs),
                          Text(
                            context.t.zero_inbox_card.description,
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
                  child: ABSearchBar(
                    controller: searchController,
                    onChanged: (p0) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              if (widget.header != null) ...[
                widget.header!,
                SizedBox(height: $constants.insets.xxs),
              ],
              SizedBox(height: $constants.insets.xxs),
              ...filteredMails.map((mail) {
                if (searchController.text.isNotEmpty &&
                    !mail.search(searchController.text)) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.only(bottom: $constants.insets.xs),
                  child: MailCard(
                    draft: widget.drafts == true ? mail : null,
                    mail: widget.drafts != true ? mail : null,
                    onDelete: widget.onDelete,
                  ),
                );
              })
            ],
          ),
        );
      }
    });
  }
}
