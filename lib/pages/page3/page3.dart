import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'page3.g.dart';

@TypedGoRoute<Page3>(path: '')
class Page3 extends GoRouteData with _$Page3 {
  Page3({this.from});
  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Text("page 3");
  }
}
