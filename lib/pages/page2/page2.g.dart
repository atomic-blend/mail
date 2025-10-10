// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page2.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $page2,
    ];

RouteBase get $page2 => GoRouteData.$route(
      path: '',
      factory: _$Page2._fromState,
    );

mixin _$Page2 on GoRouteData {
  static Page2 _fromState(GoRouterState state) => Page2(
        from: state.uri.queryParameters['from'],
      );

  Page2 get _self => this as Page2;

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
