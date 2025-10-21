// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $archiveRoute,
    ];

RouteBase get $archiveRoute => GoRouteData.$route(
      path: '/archive',
      name: 'archive',
      factory: _$ArchiveRoute._fromState,
    );

mixin _$ArchiveRoute on GoRouteData {
  static ArchiveRoute _fromState(GoRouterState state) => ArchiveRoute();

  @override
  String get location => GoRouteData.$location(
        '/archive',
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
