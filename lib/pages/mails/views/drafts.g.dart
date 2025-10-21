// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drafts.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $draftRoute,
    ];

RouteBase get $draftRoute => GoRouteData.$route(
      path: '/drafts',
      name: 'drafts',
      factory: _$DraftRoute._fromState,
    );

mixin _$DraftRoute on GoRouteData {
  static DraftRoute _fromState(GoRouterState state) => DraftRoute();

  @override
  String get location => GoRouteData.$location(
        '/drafts',
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
