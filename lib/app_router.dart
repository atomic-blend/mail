import 'package:ab_shared/pages/account/account.dart';
import 'package:ab_shared/pages/settings/settings.dart';
import 'package:ab_shared/utils/api_client.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ab_shared/components/app/app_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/pages/section1/page1/page1.dart';
import 'package:template/pages/section1/page2/page2.dart';
import 'package:template/pages/page2/page2.dart';
import 'package:template/pages/page3/page3.dart';
import 'package:template/utils/nav_constants.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> appLayoutNavigatorKey =
    GlobalKey<NavigatorState>();

@TypedShellRoute<AppRouter>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<Page1Route>(path: '/', name: "page1"),
    TypedGoRoute<Section1Page2>(path: '/page2', name: "page2"),
    TypedGoRoute<Page2>(path: '/page3', name: "page3"),
    TypedGoRoute<Page3>(path: '/page4', name: "page4"),
    TypedGoRoute<AccountRoute>(path: '/account', name: "account"),
    TypedGoRoute<SettingsRoute>(path: '/settings', name: "settings"),
  ],
)
class AppRouter extends ShellRouteData {
  final getIt = GetIt.instance;
  AppRouter();

  static final GlobalKey<NavigatorState> $navigatorKey = appLayoutNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AppLayout(
      key: state.pageKey,
      items: $navConstants.primaryMenuItems(
        context,
        prefs: getIt<SharedPreferences>(),
        globalApiClient: getIt<ApiClient>(),
      ),
      homeRouteLocation: '/',
      child: navigator,
    );
  }
}
