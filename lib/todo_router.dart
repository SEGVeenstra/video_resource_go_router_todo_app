import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class TodoRouter extends GoRouter {
  TodoRouter()
    : super.routingConfig(
        initialLocation: '/',
        routingConfig: ValueNotifier(RoutingConfig(routes: _routes)),
        navigatorKey: _rootNavigatorKey,
      );

  // TODO: add navigation methods

  static TodoRouter of(BuildContext context) {
    return GoRouter.of(context) as TodoRouter;
  }
}

extension TodoRouterExt on BuildContext {
  TodoRouter get todoRouter => TodoRouter.of(this);
}

// TODO: add routes
final _routes = <RouteBase>[
  GoRoute(
    path: '/',
    builder:
        (context, state) => Scaffold(body: Center(child: Text('placeholder'))),
  ),
];
