import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/components/app/ab_navbar.dart';
import 'package:ab_shared/components/app/ab_header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail/blocs/mail/mail_bloc.dart';
import 'package:mail/pages/mails/mail_composer.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mail/services/sync.service.dart';

final $navConstants = NavConstants();

@immutable
class NavConstants {
  // list of fixed items, limited to 5 on mobile
  // on mobile: the rest is added as a grid on the more apps page (last item to the right)
  // on desktop: the more apps page is moved at the end of the menu
  List<NavigationItem> primaryMenuItems(BuildContext context) {
    final allItems = [
      NavigationItem(
        key: const Key("inbox"),
        icon: LineAwesome.envelope,
        cupertinoIcon: CupertinoIcons.envelope,
        label: "Mail",
        location: "/inbox",
        action: NavigationAction(
          icon: LineAwesome.plus_solid,
          label: "New Mail",
          onTap: () {
            if (isDesktop(context)) {
              showDialog(
                  context: context,
                  builder: (context) => const Dialog(child: MailComposer()));
            } else {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SizedBox(
                      height: getSize(context).height * 0.88,
                      child: const MailComposer()));
            }
          },
        ),
        subItems: [
          NavigationItem(
            key: Key("inbox"),
            icon: LineAwesome.envelope,
            cupertinoIcon: CupertinoIcons.tray_arrow_down,
            label: "Inbox",
            location: "/inbox",
            header: _buildHeader(context, "Inbox"),
          ),
          NavigationItem(
            key: Key("drafts"),
            icon: LineAwesome.envelope,
            cupertinoIcon: CupertinoIcons.square_pencil,
            label: "Drafts",
            location: "/drafts",
            header: _buildHeader(context, "Drafts"),
          ),
          NavigationItem(
            key: Key("archive"),
            icon: LineAwesome.box_solid,
            cupertinoIcon: CupertinoIcons.archivebox,
            label: "Archive",
            location: "/archive",
            header: _buildHeader(context, "Archive"),
          ),
          NavigationItem(
            key: Key("trashed"),
            icon: LineAwesome.trash_solid,
            cupertinoIcon: CupertinoIcons.bin_xmark_fill,
            label: "Trashed",
            location: "/trashed",
            header: _buildHeader(context, "Trashed"),
          ),
          NavigationItem(
            key: Key("all"),
            icon: LineAwesome.envelope_open_solid,
            cupertinoIcon: CupertinoIcons.envelope_open_fill,
            label: "All",
            location: "/all",
            header: _buildHeader(context, "All"),
          ),
        ],
      ),
      NavigationItem(
        key: const Key("organize"),
        icon: LineAwesome.filter_solid,
        cupertinoIcon: CupertinoIcons.square_fill_line_vertical_square,
        label: "Organize",
        location: "/organize",
        action: NavigationAction(
          icon: LineAwesome.plus_solid,
          label: "New Mail",
          onTap: () {
            if (isDesktop(context)) {
              showDialog(
                  context: context,
                  builder: (context) => const Dialog(child: MailComposer()));
            } else {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SizedBox(
                      height: getSize(context).height * 0.88,
                      child: const MailComposer()));
            }
          },
        ),
        header: _buildHeader(context, "Organize"),
        subItems: [],
      ),
      NavigationItem(
        key: const Key("search"),
        icon: LineAwesome.search_solid,
        cupertinoIcon: CupertinoIcons.search,
        label: "Search",
        header: _buildHeader(context, "Search"),
        location: "/search",
        action: NavigationAction(
          icon: LineAwesome.plus_solid,
          label: "New Mail",
          onTap: () {
            if (isDesktop(context)) {
              showDialog(
                  context: context,
                  builder: (context) => const Dialog(child: MailComposer()));
            } else {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SizedBox(
                      height: getSize(context).height * 0.88,
                      child: const MailComposer()));
            }
          },
        ),
        subItems: [],
      ),
      NavigationItem(
        key: const Key("account"),
        icon: LineAwesome.cog_solid,
        cupertinoIcon: CupertinoIcons.settings,
        label: "Account & Settings",
        location: "/account",
        subItems: const [],
        header: _buildHeader(context, "Account & Settings"),
      ),
    ];
    return allItems;
  }

  Widget _buildHeader(BuildContext context, String title) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
      return BlocBuilder<MailBloc, MailState>(
        builder: (context, mailState) {
          return ABHeader(
            title: title,
            syncedElements: SyncService.getSyncedElements(
              mailState: mailState,
              authState: authState,
            ),
            isSyncing: SyncService.isSyncing(
              mailState: mailState,
              authState: authState,
            ),
          );
        },
      );
    });
  }
}
