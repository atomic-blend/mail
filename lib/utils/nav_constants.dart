import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/components/app/ab_navbar.dart';
import 'package:mail/blocs/app/app.bloc.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/pages/mails/mail_composer.dart';
import 'package:mail/pages/mails/views/all_mail.dart';
import 'package:mail/pages/mails/views/archive.dart';
import 'package:mail/pages/mails/views/drafts.dart';
import 'package:mail/pages/mails/views/inbox.dart';
import 'package:mail/pages/more/more.dart';
import 'package:mail/services/sync.service.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:ab_shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

final $navConstants = NavConstants();

@immutable
class NavConstants {
  List<NavigationSection> secondaryMenuSections(BuildContext context) => [
        const NavigationSection(
          key: Key("mail"),
          items: [
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
              key: Key("all"),
              icon: LineAwesome.envelope_open_solid,
              cupertinoIcon: CupertinoIcons.envelope_open_fill,
              label: "All",
              body: AllMailScreen(),
            ),
          ],
        ),
        const NavigationSection(
          key: Key("organize"),
          items: [],
        ),
        const NavigationSection(
          key: Key("new_mail"),
          items: [],
        ),
        const NavigationSection(
          key: Key("search"),
          items: [],
        ),
        const NavigationSection(
          key: Key("more"),
          items: [],
        ),
      ];

  // list of fixed items, limited to 5 on mobile
  // on mobile: the rest is added as a grid on the more apps page (last item to the right)
  // on desktop: the more apps page is moved at the end of the menu
  List<NavigationItem> primaryMenuItems(BuildContext context) => [
        NavigationItem(
          key: const Key("mail"),
          icon: LineAwesome.envelope,
          cupertinoIcon: CupertinoIcons.envelope,
          label: "Mail",
          body: AllMailScreen(),
          mainSecondaryKey: "inbox",
          appBar: AppBar(
            key: const Key("mail"),
            backgroundColor: getTheme(context).surfaceContainer,
            title: BlocBuilder<AppCubit, AppState>(builder: (context, appState) {
                    var selectedSecondarySection =
                        secondaryMenuSections(context)
                            .where((element) =>
                                (element.key as ValueKey).value ==
                                appState.primaryMenuSelectedKey)
                            .firstOrNull;
                    var selectedSecondaryItem = selectedSecondarySection?.items
                        .where((element) =>
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
          body: Container(),
          appBar: AppBar(
              key: const Key("organize"),
              backgroundColor: getTheme(context).surface,
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
          key: const Key("new_mail"),
          icon: LineAwesome.plus_solid,
          cupertinoIcon: CupertinoIcons.plus_circle_fill,
          label: "Compose",
          color: getTheme(context).secondary,
          onTap: (index) {
            if (isDesktop(context)) {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: SizedBox(
                          height: getSize(context).height * 0.8,
                          width: getSize(context).width * 0.8,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular($constants.corners.md),
                            child: MailComposer(),
                          ),
                        ),
                      ));
            } else {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                isDismissible: false,
                enableDrag: false,
                backgroundColor: Colors.transparent,
                builder: (context) => SizedBox(height: getSize(context).height * 0.92, child: MailComposer()),
              );
            }
            SyncService.sync(context);
          },
        ),
        NavigationItem(
          key: const Key("search"),
          icon: LineAwesome.search_solid,
          cupertinoIcon: CupertinoIcons.search,
          label: "Search",
          body: Container(),
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
          key: const Key("more"),
          icon: CupertinoIcons.ellipsis_circle_fill,
          cupertinoIcon: CupertinoIcons.ellipsis_circle_fill,
          label: context.t.more.title,
          body: const MoreApps(),
          appBar: AppBar(
              key: const Key("more"),
              backgroundColor: getTheme(context).surface,
              leading: Container(),
              title: Text(
                context.t.more.title,
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
}
