import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/app_layout_screen.dart';
import 'package:template/main.dart';
import 'package:template/pages/page1/page1.dart';
import 'package:template/pages/page2/page2.dart';
import 'package:template/pages/page3/page3.dart';
import 'package:template/pages/page4/page4.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> appLayoutNavigatorKey =
    GlobalKey<NavigatorState>();

@TypedShellRoute<AppRouter>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<Page1Route>(path: '/page1', name: "page1"),
    TypedGoRoute<Page2>(path: '/page2', name: "page2"),
    TypedGoRoute<Page3>(path: '/page3', name: "page3"),
    TypedGoRoute<Page4>(path: '/page4', name: "page4"),
  ],
)
class AppRouter extends ShellRouteData {
  AppRouter();

  static final GlobalKey<NavigatorState> $navigatorKey = appLayoutNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AppLayoutScreen(
      env: env,
      prefs: prefs,
      globalApiClient: globalApiClient,
      encryptionService: encryptionService,
    );
  }
}
