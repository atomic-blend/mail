import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'page2.g.dart';

@TypedGoRoute<Section1Page2>(path: '')
class Section1Page2 extends GoRouteData with _$Section1Page2 {
  Section1Page2({this.from});
  final String? from;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Text("section 1 page 2");
  }
}
