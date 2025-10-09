// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page1.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $page1Route,
    ];

RouteBase get $page1Route => GoRouteData.$route(
      path: '/sso',
      name: 'sso',
      factory: _$Page1Route._fromState,
    );

mixin _$Page1Route on GoRouteData {
  static Page1Route _fromState(GoRouterState state) => Page1Route(
        from: state.uri.queryParameters['from'],
      );

  Page1Route get _self => this as Page1Route;

  @override
  String get location => GoRouteData.$location(
        '/sso',
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
