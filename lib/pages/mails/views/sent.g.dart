// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sent.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $sentRoute,
    ];

RouteBase get $sentRoute => GoRouteData.$route(
      path: '/sent',
      name: 'sent',
      factory: _$SentRoute._fromState,
    );

mixin _$SentRoute on GoRouteData {
  static SentRoute _fromState(GoRouterState state) => SentRoute();

  @override
  String get location => GoRouteData.$location(
        '/sent',
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
