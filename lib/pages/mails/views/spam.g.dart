// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spam.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $spamRoute,
    ];

RouteBase get $spamRoute => GoRouteData.$route(
      path: '/spam',
      name: 'spam',
      factory: _$SpamRoute._fromState,
    );

mixin _$SpamRoute on GoRouteData {
  static SpamRoute _fromState(GoRouterState state) => SpamRoute();

  @override
  String get location => GoRouteData.$location(
        '/spam',
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
