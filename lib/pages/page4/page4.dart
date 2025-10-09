import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'page4.g.dart';

@TypedGoRoute<Page4>(path: '')
class Page4 extends GoRouteData with _$Page4 {
  Page4({this.from});
  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Text("page 4");
  }
}
