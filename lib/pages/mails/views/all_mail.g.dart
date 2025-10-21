// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_mail.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $allMailRoute,
    ];

RouteBase get $allMailRoute => GoRouteData.$route(
      path: '/all',
      name: 'all',
      factory: _$AllMailRoute._fromState,
    );

mixin _$AllMailRoute on GoRouteData {
  static AllMailRoute _fromState(GoRouterState state) => AllMailRoute();

  @override
  String get location => GoRouteData.$location(
        '/all',
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
