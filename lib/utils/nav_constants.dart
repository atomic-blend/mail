import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/components/app/ab_header.dart';
import 'package:ab_shared/components/app/ab_navbar.dart';
import 'package:ab_shared/utils/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/services/sync.service.dart';

final $navConstants = NavConstants();

@immutable
class NavConstants {
  // list of fixed items, limited to 5 on mobile
  // on mobile: the rest is added as a grid on the more apps page (last item to the right)
  // on desktop: the more apps page is moved at the end of the menu
  List<NavigationItem> primaryMenuItems(BuildContext context,
          {SharedPreferences? prefs, ApiClient? globalApiClient}) =>
      [
        NavigationItem(
          key: const Key("section_1"),
          icon: LineAwesome.file,
          cupertinoIcon: CupertinoIcons.doc,
          label: "Section1",
          location: "/section1",
          action: NavigationAction(
            icon: LineAwesome.plus_solid,
            label: "Action",
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Section 1"),
                      ));
            },
          ),
          subItems: [
            NavigationItem(
              key: const Key("page_1"),
              icon: LineAwesome.file,
              cupertinoIcon: CupertinoIcons.doc,
              label: "Page 1",
              location: "/",
              header: _buildHeader(context, "Page 1"),
            ),
            NavigationItem(
              key: const Key("page_2"),
              icon: LineAwesome.search_solid,
              cupertinoIcon: CupertinoIcons.search,
              label: "Page 2",
              location: "/page2",
              header: _buildHeader(context, "Page 2"),
            ),
          ],
        ),
        NavigationItem(
          key: const Key("page_3"),
          icon: LineAwesome.search_solid,
          cupertinoIcon: CupertinoIcons.search,
          label: "Page 3",
          location: "/page3",
          header: _buildHeader(context, "Page 3"),
        ),
        NavigationItem(
          key: const Key("page_4"),
          icon: LineAwesome.filter_solid,
          cupertinoIcon: CupertinoIcons.square_fill_line_vertical_square,
          label: "Page 4",
          location: "/page4",
          header: _buildHeader(context, "Page 4"),
        ),
        NavigationItem(
          key: const Key("account"),
          icon: LineAwesome.user,
          cupertinoIcon: CupertinoIcons.person,
          label: "Account",
          location: "/account",
          header: _buildHeader(context, "Account"),
        ),
        NavigationItem(
          key: const Key("settings"),
          icon: LineAwesome.cog_solid,
          cupertinoIcon: CupertinoIcons.gear,
          label: "Settings",
          location: "/settings",
          header: _buildHeader(context, "Settings"),
        ),
      ];
}

Widget _buildHeader(BuildContext context, String title) {
  return BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
    return ABHeader(
      title: title,
      syncedElements: SyncService.getSyncedElements(
        authState: authState,
      ),
      isSyncing: SyncService.isSyncing(
        authState: authState,
      ),
    );
  });
}
