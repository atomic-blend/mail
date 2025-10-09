// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $appRouter,
    ];

RouteBase get $appRouter => ShellRouteData.$route(
      navigatorKey: AppRouter.$navigatorKey,
      factory: $AppRouterExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/',
          name: 'page1',
          factory: _$Page1Route._fromState,
        ),
        GoRouteData.$route(
          path: '/page2',
          name: 'page2',
          factory: _$Section1Page2._fromState,
        ),
        GoRouteData.$route(
          path: '/page3',
          name: 'page3',
          factory: _$Page2._fromState,
        ),
        GoRouteData.$route(
          path: '/page4',
          name: 'page4',
          factory: _$Page3._fromState,
        ),
        GoRouteData.$route(
          path: '/settings',
          name: 'settings',
          factory: _$SettingsRoute._fromState,
        ),
      ],
    );

extension $AppRouterExtension on AppRouter {
  static AppRouter _fromState(GoRouterState state) => AppRouter();
}

mixin _$Page1Route on GoRouteData {
  static Page1Route _fromState(GoRouterState state) => Page1Route(
        from: state.uri.queryParameters['from'],
      );

  Page1Route get _self => this as Page1Route;

  @override
  String get location => GoRouteData.$location(
        '/',
        queryParams: {
          if (_self.from != null) 'from': _self.from,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$Section1Page2 on GoRouteData {
  static Section1Page2 _fromState(GoRouterState state) => Section1Page2(
        from: state.uri.queryParameters['from'],
      );

  Section1Page2 get _self => this as Section1Page2;

  @override
  String get location => GoRouteData.$location(
        '/page2',
        queryParams: {
          if (_self.from != null) 'from': _self.from,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$Page2 on GoRouteData {
  static Page2 _fromState(GoRouterState state) => Page2(
        from: state.uri.queryParameters['from'],
      );

  Page2 get _self => this as Page2;

  @override
  String get location => GoRouteData.$location(
        '/page3',
        queryParams: {
          if (_self.from != null) 'from': _self.from,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$Page3 on GoRouteData {
  static Page3 _fromState(GoRouterState state) => Page3(
        from: state.uri.queryParameters['from'],
      );

  Page3 get _self => this as Page3;

  @override
  String get location => GoRouteData.$location(
        '/page4',
        queryParams: {
          if (_self.from != null) 'from': _self.from,
        },
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => SettingsRoute(
        state.extra as SettingsParams?,
      );

  SettingsRoute get _self => this as SettingsRoute;

  @override
  String get location => GoRouteData.$location(
        '/settings',
      );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}
