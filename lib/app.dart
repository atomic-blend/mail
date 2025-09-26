import 'dart:io';

import 'package:ab_shared/blocs/auth/auth.bloc.dart';
import 'package:ab_shared/flavors.dart';
import 'package:ab_shared/pages/auth/login_or_register_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:macos_window_utils/widgets/titlebar_safe_area.dart';
import 'package:mail/i18n/strings.g.dart';
import 'package:mail/main.dart';
import 'package:mail/pages/app_layout.dart';
import 'package:ab_shared/utils/app_theme.dart';
import 'package:fleather/l10n/fleather_localizations.g.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: BlocBuilder<AuthBloc, AuthState>(builder: (context, authState) {
        if (authState is LoggedOut) {
          final loginPage = LoginOrRegisterModal(
            encryptionService: encryptionService,
            globalApiClient: globalApiClient,
            prefs: prefs!,
            env: env!,
            onAuthSuccess: () {});
          Widget? body = SafeArea(child: loginPage);
          if (!kIsWeb && Platform.isMacOS) {
            body = TitlebarSafeArea(child: loginPage);
          }
          if (!kIsWasm && Platform.isMacOS) {
            body = TitlebarSafeArea(child: loginPage);
          }
          return Scaffold(
              body: body,
          );
        }
        return _flavorBanner(
          child: const Scaffold(body: AppLayout()),
          show: kDebugMode && env!.debugShowCheckedModeBanner,
        );
      }),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withValues(alpha: 0.6),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(
              child: child,
            );
}
