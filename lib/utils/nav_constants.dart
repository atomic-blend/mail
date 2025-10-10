import 'package:ab_shared/components/app/ab_navbar.dart';
import 'package:mail/pages/mails/mail_composer.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

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
          ),
          NavigationItem(
            key: Key("drafts"),
            icon: LineAwesome.envelope,
            cupertinoIcon: CupertinoIcons.square_pencil,
            label: "Drafts",
            location: "/drafts",
          ),
          NavigationItem(
            key: Key("archive"),
            icon: LineAwesome.box_solid,
            cupertinoIcon: CupertinoIcons.archivebox,
            label: "Archive",
            location: "/archive",
          ),
          NavigationItem(
            key: Key("trashed"),
            icon: LineAwesome.trash_solid,
            cupertinoIcon: CupertinoIcons.bin_xmark_fill,
            label: "Trashed",
            location: "/trashed",
          ),
          NavigationItem(
            key: Key("all"),
            icon: LineAwesome.envelope_open_solid,
            cupertinoIcon: CupertinoIcons.envelope_open_fill,
            label: "All",
            location: "/all",
          ),
        ],

        // appBar: AppBar(
        //   key: const Key("inbox"),
        //   backgroundColor: getTheme(context).surface,
        //   title: BlocBuilder<AppCubit, AppState>(builder: (context, appState) {
        //     var selectedSecondaryItem = primaryMenuItems(context)
        //         .where((element) =>
        //             (element.key as ValueKey).value ==
        //             appState.primaryMenuSelectedKey)
        //         .firstOrNull
        //         ?.subItems
        //         ?.where((element) =>
        //             (element.key as ValueKey).value ==
        //             appState.secondaryMenuSelectedKey)
        //         .firstOrNull;
        //     return Text(
        //       selectedSecondaryItem?.label ?? "",
        //       style: getTextTheme(context).headlineSmall!.copyWith(
        //             fontWeight: FontWeight.bold,
        //           ),
        //     );
        //   }),
        //   actions: [
        //     BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
        //       return Container();
        //     }),
        //   ],
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(16.0),
        //       bottomRight: Radius.circular(16.0),
        //     ),
        //   ),
        // ),
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
        subItems: [],
      ),
      NavigationItem(
        key: const Key("search"),
        icon: LineAwesome.search_solid,
        cupertinoIcon: CupertinoIcons.search,
        label: "Search",
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
        icon: LineAwesome.user_solid,
        cupertinoIcon: CupertinoIcons.person,
        label: "Account",
        location: "/account",
        subItems: [],
      ),
      NavigationItem(
        key: const Key("settings"),
        icon: LineAwesome.cog_solid,
        cupertinoIcon: CupertinoIcons.gear,
        label: "Settings",
        location: "/settings",
        subItems: [],
      ),
    ];
    return allItems;
  }
}
