import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/components/app/ab_navbar.dart';
import 'package:ab_shared/pages/account/account.dart';
import 'package:mail/blocs/app/app.bloc.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/main.dart';
import 'package:mail/pages/mails/views/all_mail.dart';
import 'package:mail/pages/mails/views/archive.dart';
import 'package:mail/pages/mails/views/drafts.dart';
import 'package:mail/pages/mails/views/inbox.dart';
import 'package:mail/pages/mails/views/trashed.dart';
import 'package:mail/pages/more/more.dart';
import 'package:mail/pages/organize/organize.dart';
import 'package:mail/pages/search/search.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mail/pages/settings/settings.dart';

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
        body: AllMailScreen(),
        mainSecondaryKey: "inbox",
        subItems: [
          NavigationItem(
            key: Key("inbox"),
            icon: LineAwesome.envelope,
            cupertinoIcon: CupertinoIcons.envelope,
            label: "Inbox",
            body: InboxScreen(),
          ),
          NavigationItem(
            key: Key("drafts"),
            icon: LineAwesome.envelope,
            cupertinoIcon: CupertinoIcons.square_pencil,
            label: "Drafts",
            body: DraftScreen(),
          ),
          NavigationItem(
            key: Key("archive"),
            icon: LineAwesome.box_solid,
            cupertinoIcon: CupertinoIcons.archivebox,
            label: "Archive",
            body: ArchiveScreen(),
          ),
          NavigationItem(
            key: Key("trashed"),
            icon: LineAwesome.trash_solid,
            cupertinoIcon: CupertinoIcons.bin_xmark_fill,
            label: "Trashed",
            body: TrashedScreen(),
          ),
          NavigationItem(
            key: Key("all"),
            icon: LineAwesome.envelope_open_solid,
            cupertinoIcon: CupertinoIcons.envelope_open_fill,
            label: "All",
            body: AllMailScreen(),
          ),
        ],
        appBar: AppBar(
          key: const Key("inbox"),
          backgroundColor: getTheme(context).surfaceContainer,
          title: BlocBuilder<AppCubit, AppState>(builder: (context, appState) {
            var selectedSecondaryItem = primaryMenuItems(context)
                .where((element) =>
                    (element.key as ValueKey).value ==
                    appState.primaryMenuSelectedKey)
                .firstOrNull
                ?.subItems
                ?.where((element) =>
                    (element.key as ValueKey).value ==
                    appState.secondaryMenuSelectedKey)
                .firstOrNull;
            return Text(
              selectedSecondaryItem?.label ?? "",
              style: getTextTheme(context).headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            );
          }),
          actions: [
            BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
              return Container();
            }),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
        ),
      ),
      NavigationItem(
        key: const Key("organize"),
        icon: LineAwesome.filter_solid,
        cupertinoIcon: CupertinoIcons.square_fill_line_vertical_square,
        label: "Organize",
        body: OrganizeScreen(),
        subItems: [],
        appBar: AppBar(
            key: const Key("organize"),
            backgroundColor: getTheme(context).surfaceContainer,
            surfaceTintColor: getTheme(context).surface,
            leading: Container(),
            title: Text(
              "Organize",
              style: getTextTheme(context).headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            actions: [
              BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
                return Container();
              })
            ]),
      ),
      NavigationItem(
        key: const Key("search"),
        icon: LineAwesome.search_solid,
        cupertinoIcon: CupertinoIcons.search,
        label: "Search",
        body: SearchScreen(),
        subItems: [],
        appBar: AppBar(
            key: const Key("search"),
            backgroundColor: getTheme(context).surfaceContainer,
            leading: Container(),
            title: Text(
              "Search",
              style: getTextTheme(context).headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            actions: [
              BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
                return Container();
              })
            ]),
      ),
      NavigationItem(
        key: const Key("account"),
        icon: LineAwesome.user_solid,
        cupertinoIcon: CupertinoIcons.person,
        label: "Account",
        body: Account(
          globalApiClient: globalApiClient,
          encryptionService: encryptionService,
          prefs: prefs,
        ),
        subItems: [],
        appBar: AppBar(
            key: const Key("account"),
            backgroundColor: getTheme(context).surfaceContainer,
            leading: Container(),
            title: Text(
              "Account",
              style: getTextTheme(context).headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            actions: [
              BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
                return Container();
              })
            ]),
      ),
      NavigationItem(
        key: const Key("settings"),
        icon: LineAwesome.cog_solid,
        cupertinoIcon: CupertinoIcons.gear,
        label: "Settings",
        body: Settings(),
        subItems: [],
        appBar: AppBar(
            key: const Key("settings"),
            backgroundColor: getTheme(context).surfaceContainer,
            leading: Container(),
            title: Text(
              "Settings",
              style: getTextTheme(context).headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            actions: [
              BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
                return Container();
              })
            ]),
      ),
    ];
    return allItems;
  }
}
