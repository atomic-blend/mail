// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page3.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $page3,
    ];

RouteBase get $page3 => GoRouteData.$route(
      path: '',
      factory: _$Page3._fromState,
    );

mixin _$Page3 on GoRouteData {
  static Page3 _fromState(GoRouterState state) => Page3(
        from: state.uri.queryParameters['from'],
      );

  Page3 get _self => this as Page3;

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
