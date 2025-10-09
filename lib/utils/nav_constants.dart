import 'package:ab_shared/components/app/ab_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:icons_plus/icons_plus.dart';

final $navConstants = NavConstants();

@immutable
class NavConstants {
  // list of fixed items, limited to 5 on mobile
  // on mobile: the rest is added as a grid on the more apps page (last item to the right)
  // on desktop: the more apps page is moved at the end of the menu
  List<NavigationItem> primaryMenuItems(BuildContext context) => [
        NavigationItem(
          key: const Key("page_1"),
          icon: LineAwesome.file,
          cupertinoIcon: CupertinoIcons.doc,
          label: "Page 1",
          location: "/page1",
        ),
        NavigationItem(
          key: const Key("page_2"),
          icon: LineAwesome.search_solid,
          cupertinoIcon: CupertinoIcons.search,
          label: "Page 2",
          location: "/page2",
        ),
        NavigationItem(
          key: const Key("page_3"),
          icon: LineAwesome.filter_solid,
          cupertinoIcon: CupertinoIcons.square_fill_line_vertical_square,
          label: "Page 3",
          location: "/page3",
        ),
        NavigationItem(
          key: const Key("page_4"),
          icon: LineAwesome.cog_solid,
          cupertinoIcon: CupertinoIcons.gear,
          label: "Page 4",
          location: "/page4",
        ),
      ];
}
