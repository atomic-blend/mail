import 'package:ab_shared/pages/account/account.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ab_shared/components/app/app_layout.dart';
import 'package:mail/pages/home/home.dart';
import 'package:mail/pages/mails/views/all_mail.dart';
import 'package:mail/pages/mails/views/archive.dart';
import 'package:mail/pages/mails/views/drafts.dart';
import 'package:mail/pages/mails/views/inbox.dart';
import 'package:mail/pages/mails/views/trashed.dart';
import 'package:mail/pages/organize/organize.dart';
import 'package:mail/pages/search/search.dart';
import 'package:mail/utils/nav_constants.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> appLayoutNavigatorKey =
    GlobalKey<NavigatorState>();

@TypedShellRoute<AppRouter>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: '/', name: "home"),
    TypedGoRoute<InboxRoute>(path: '/inbox', name: "inbox"),
    TypedGoRoute<DraftRoute>(path: '/drafts', name: "drafts"),
    TypedGoRoute<ArchiveRoute>(path: '/archive', name: "archive"),
    TypedGoRoute<AllMailRoute>(path: '/all', name: "all"),
    TypedGoRoute<TrashedRoute>(path: '/trashed', name: "trashed"),
    TypedGoRoute<OrganizeRoute>(path: '/organize', name: "organize"),
    TypedGoRoute<SearchRoute>(path: '/search', name: "search"),
    TypedGoRoute<AccountRoute>(path: '/account', name: "account")
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
      ),
      homeRouteLocation: '/',
      child: navigator,
    );
  }
}
