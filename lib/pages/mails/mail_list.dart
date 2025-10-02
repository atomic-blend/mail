import 'package:ab_shared/components/forms/search_bar.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mail/components/cards/mail_card.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/models/send_mail/send_mail.dart';
import 'package:mail/services/sync.service.dart';

class MailList extends StatefulWidget {
  final List<dynamic>? mails;
  final Function(dynamic)? onSelect;
  final Function(dynamic)? onDeselect;
  final List<dynamic>? selectedMails;
  final bool? drafts;
  final Widget? header;
  final Function(String)? onDelete;

  const MailList({
    super.key,
    this.drafts = false,
    this.onDelete,
    this.header,
    this.mails,
    this.onSelect,
    this.onDeselect,
    this.selectedMails,
  });

  @override
  State<MailList> createState() => _MailListState();
}

class _MailListState extends State<MailList> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.mails?.isEmpty ?? true) {
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
                  Container(
                    decoration: BoxDecoration(
                      color: getTheme(context).surfaceContainer,
                      borderRadius:
                          BorderRadius.circular($constants.corners.sm),
                    ),
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
                          style: getTextTheme(context).headlineMedium!.copyWith(
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
              padding: EdgeInsets.symmetric(vertical: $constants.insets.xxs),
              child: ABSearchBar(
                controller: searchController,
                onChanged: (p0) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: $constants.insets.xs),
            if (widget.header != null) ...[
              widget.header!,
              SizedBox(height: $constants.insets.xxs),
            ],
            SizedBox(height: $constants.insets.xxs),
            ...(widget.mails ?? []).map((mail) {
              if (searchController.text.isNotEmpty &&
                  !mail.search(searchController.text)) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: EdgeInsets.only(bottom: $constants.insets.xs),
                child: MailCard(
                  draft: widget.drafts == true ? mail as SendMail : null,
                  mail: widget.drafts != true ? mail : null,
                  onDelete: widget.onDelete,
                  onSelect: widget.onSelect,
                  onDeselect: widget.onDeselect,
                  selectedMails: widget.selectedMails,
                ),
              );
            })
          ],
        ),
      );
    }
  }
}
