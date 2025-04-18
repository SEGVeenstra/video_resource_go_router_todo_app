import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_active_tabs.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_archived.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_bottom_nav.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_detail.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class TodoRouter extends GoRouter {
  TodoRouter()
    : super.routingConfig(
        initialLocation: '/active',
        routingConfig: ValueNotifier(RoutingConfig(routes: _routes)),
        navigatorKey: _rootNavigatorKey,
      );

  void goToTodo(int id) {
    switch (state.topRoute?.path) {
      case '/active':
        go('/active/$id');
        break;
      case '/completed':
        go('/completed/$id');
        break;
      case '/archive':
        go('/archive/$id');
        break;
      default:
        go('/active/$id');
    }
  }

  void goToTodos() {
    go('/active');
  }

  void goToCompleted() {
    go('/completed');
  }

  void goToArchive() {
    go('/archive');
  }

  static TodoRouter of(BuildContext context) {
    return GoRouter.of(context) as TodoRouter;
  }
}

extension TodoRouterExt on BuildContext {
  TodoRouter get todoRouter => TodoRouter.of(this);
}

final _routes = <RouteBase>[
  StatefulShellRoute.indexedStack(
    builder:
        (context, state, child) => TodoBottomNav(
          onSelected: (item) {
            switch (item) {
              case TodoBottomNavItems.active:
                context.todoRouter.goToTodos();
              case TodoBottomNavItems.archive:
                context.todoRouter.goToArchive();
            }
          },
          selected: switch (state.pathParameters['tab']) {
            'active' => TodoBottomNavItems.active,
            'completed' => TodoBottomNavItems.archive,
            _ => TodoBottomNavItems.active,
          },
          child: child,
        ),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/archive',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: TodoArchived());
            },
            routes: [
              GoRoute(
                path: ':id',
                parentNavigatorKey: _rootNavigatorKey,
                builder:
                    (context, state) =>
                        TodoDetail(id: int.parse(state.pathParameters['id']!)),
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        initialLocation: '/active',
        routes: [
          GoRoute(
            path: '/:tab',
            pageBuilder: (context, state) {
              final tab = switch (state.pathParameters['tab']) {
                'active' => TabsItems.active,
                'completed' => TabsItems.completed,
                _ => TabsItems.active,
              };
              return NoTransitionPage(
                child: TodoActiveTabs(
                  selected: tab,
                  onSelected: (item) {
                    switch (item) {
                      case TabsItems.active:
                        context.todoRouter.goToTodos();
                      case TabsItems.completed:
                        context.todoRouter.goToCompleted();
                    }
                  },
                ),
              );
            },
            routes: [
              GoRoute(
                path: ':id',
                parentNavigatorKey: _rootNavigatorKey,
                builder:
                    (context, state) =>
                        TodoDetail(id: int.parse(state.pathParameters['id']!)),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
