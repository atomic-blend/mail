import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'page2.g.dart';

@TypedGoRoute<Page2>(path: '')
class Page2 extends GoRouteData with _$Page2 {
  Page2({this.from});
  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Text("page 2");
  }
}
