import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'page1.g.dart';

@TypedGoRoute<Page1Route>(path: '/sso', name: "sso")
class Page1Route extends GoRouteData with _$Page1Route {
  Page1Route({this.from});
  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Text("page 1");
  }
}
