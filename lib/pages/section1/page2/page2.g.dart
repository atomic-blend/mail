// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page2.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $section1Page2,
    ];

RouteBase get $section1Page2 => GoRouteData.$route(
      path: '',
      factory: _$Section1Page2._fromState,
    );

mixin _$Section1Page2 on GoRouteData {
  static Section1Page2 _fromState(GoRouterState state) => Section1Page2(
        from: state.uri.queryParameters['from'],
      );

  Section1Page2 get _self => this as Section1Page2;

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
