import 'package:ab_shared/utils/constants.dart';
import 'package:ab_shared/utils/shortcuts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:get_it/get_it.dart';

class MailAppbar extends StatelessWidget {
  final getIt = GetIt.instance;
  final String title;
  late final SideMenuController sideMenuController;
  MailAppbar({super.key, required this.title}) {
    sideMenuController = getIt<SideMenuController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: $constants.insets.xs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: $constants.insets.xxs),
            IconButton(
              hoverColor: getTheme(context).surfaceContainer,
              focusColor: getTheme(context).surfaceContainer,
              highlightColor: getTheme(context).surfaceContainer,
              onPressed: () {
                if (isDesktop(context)) {
                  sideMenuController.isCollapsed()
                      ? sideMenuController.open()
                      : sideMenuController.close();
                } else {
                  getIt<GlobalKey<ScaffoldState>>(instanceName: 'layoutScaffoldKey').currentState?.openDrawer();
                }
              },
              icon: const Icon(
                CupertinoIcons.sidebar_left,
                size: 20,
              ),
            ),
            SizedBox(width: $constants.insets.sm),
            Text(
              title,
              style: getTextTheme(context).bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
