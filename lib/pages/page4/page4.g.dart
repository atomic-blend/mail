// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page4.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $page4,
    ];

RouteBase get $page4 => GoRouteData.$route(
      path: '',
      factory: _$Page4._fromState,
    );

mixin _$Page4 on GoRouteData {
  static Page4 _fromState(GoRouterState state) => Page4(
        from: state.uri.queryParameters['from'],
      );

  Page4 get _self => this as Page4;

  @override
  String get location => GoRouteData.$location(
        '',
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
