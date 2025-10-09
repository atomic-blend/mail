import 'package:ab_shared/components/ab_toast.dart';
import 'package:ab_shared/flavors.dart';
import 'package:ab_shared/pages/auth/screens/auth_routes.dart' as auth_routes;
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:template/app_router.dart';
import 'package:template/i18n/strings.g.dart';
import 'package:template/main.dart';
import 'package:ab_shared/utils/app_theme.dart';
import 'package:fleather/l10n/fleather_localizations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final SideMenuController sideMenuController = SideMenuController();
final ABToastController abToastController = ABToastController();
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      locale: TranslationProvider.of(context).flutterLocale,
      // use provider
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: const [
        FleatherLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: env!.debugShowCheckedModeBanner,
      title: F.title,
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    routes: [
      ...$appRoutes,
      ...auth_routes.$appRoutes,
    ],
    initialLocation: '/page1',
    navigatorKey: rootNavigatorKey,
  );
}
