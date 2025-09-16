import 'package:ab_shared/components/widgets/elevated_container.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/models/mail/mail.dart';
import 'package:mail/pages/mails/mail_details.dart';
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
    final inboxCards = inboxMails.map((mail) => _buildMailCard(mail)).toList();
    return Column(
      children: [
        SizedBox(
          height: getSize(context).height * 0.5,
          child: CardSwiper(
            cardsCount: inboxCards.length,
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) =>
                    inboxCards[index],
            onSwipe: (previousIndex, currentIndex, direction) {
              if (direction == CardSwiperDirection.left) {
                // archive
                _onArchive();
              } else if (direction == CardSwiperDirection.right) {
                // skip (mark as read if not read)
                _onRead();
              } else if (direction == CardSwiperDirection.top) {
                // move
                _onMove();
              } else if (direction == CardSwiperDirection.bottom) {
                // trash
                _onTrash();
              } else if (direction == CardSwiperDirection.none) {
                print("none");
              }
              return true;
            },
          ),
        ),
        SizedBox(
          height: getSize(context).height * 0.08,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedContainer(
              width: 70,
              height: 70,
              onTap: _onTrash,
              borderRadius: $constants.corners.full,
              child: Icon(CupertinoIcons.trash,
                  size: 25, color: getTheme(context).error),
            ),
            ElevatedContainer(
              width: 100,
              height: 100,
              onTap: _onArchive,
              borderRadius: $constants.corners.full,
              child: Icon(CupertinoIcons.archivebox,
                  size: 35, color: Colors.grey.shade600),
            ),
            ElevatedContainer(
              width: 100,
              height: 100,
              onTap: _onRead,
              borderRadius: $constants.corners.full,
              child: Icon(
                CupertinoIcons.envelope_open,
                size: 35,
                color: getTheme(context).primary,
              ),
            ),
            ElevatedContainer(
              width: 70,
              height: 70,
              onTap: _onMove,
              borderRadius: $constants.corners.full,
              child: Icon(
                CupertinoIcons.arrow_branch,
                size: 25,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMailCard(Mail mail) {
    return ElevatedContainer(
      padding: EdgeInsets.symmetric(
          horizontal: $constants.insets.sm, vertical: $constants.insets.sm),
      width: getSize(context).width * 0.9,
      height: getSize(context).height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            mail.getHeader("Subject"),
            maxLines: 1,
            style: getTextTheme(context)
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: $constants.insets.xs),
          _buildPeopleRow("From", mail.getHeader("From"), mail.read),
          _buildPeopleRow("To", mail.getHeader("To"), mail.read),
          SizedBox(height: $constants.insets.xs),
          Divider(),
          SizedBox(height: $constants.insets.xs),
          SizedBox(
            height: getSize(context).height * 0.2,
            child: mail.htmlContent != null && mail.htmlContent != ""
                ? Html(
                    data: mail.htmlContent!,
                  )
                : mail.textContent != null && mail.textContent != ""
                    ? Text(mail.textContent!)
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildPeopleRow(String label, String value, bool? read) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$label: ",
          style: getTextTheme(context).bodyMedium!.copyWith(color: Colors.grey),
        ),
        SizedBox(width: $constants.insets.xs),
        Text(
          value,
          style: getTextTheme(context)
              .bodyMedium!
              .copyWith(fontWeight: read != true ? FontWeight.bold : null),
        ),
      ],
    );
  }

  void _onArchive() {
    print("archive");
  }

  void _onTrash() {
    print("trash");
  }

  void _onRead() {
    print("read");
  }

  void _onMove() {
    print("move");
  }
}
