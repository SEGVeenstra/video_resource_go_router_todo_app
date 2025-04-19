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
        initialLocation: '/active/todo',
        routingConfig: ValueNotifier(RoutingConfig(routes: _routes)),
        navigatorKey: _rootNavigatorKey,
      );

  void goToTodo() {
    go('/active/todo');
  }

  void goToCompleted() {
    go('/active/completed');
  }

  void goToArchive() {
    go('/archive');
  }

  void goToActiveTodoDetail(int id) {
    go('/active/todo/$id');
  }

  void goToCompletedTodoDetail(int id) {
    go('/active/completed/$id');
  }

  void goToArchiveTodoDetail(int id) {
    go('/archive/$id');
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
        (context, state, shell) => TodoBottomNav(
          onSelected: (item) {
            switch (item) {
              case TodoBottomNavItems.active:
                context.todoRouter.goToTodo();
              case TodoBottomNavItems.archive:
                context.todoRouter.goToArchive();
            }
          },
          selected: TodoBottomNavItems.values[shell.currentIndex],
          child: shell,
        ),
    branches: [
      StatefulShellBranch(
        initialLocation: '/active/todo',
        routes: [
          GoRoute(
            path: '/active/:tab',
            pageBuilder: (context, state) {
              final tab = switch (state.pathParameters['tab']) {
                'todo' => TabsItems.active,
                'completed' => TabsItems.completed,
                _ => TabsItems.active,
              };
              return NoTransitionPage(
                child: TodoActiveTabs(
                  selected: tab,
                  onSelected: (item) {
                    switch (item) {
                      case TabsItems.active:
                        context.todoRouter.goToTodo();
                      case TabsItems.completed:
                        context.todoRouter.goToCompleted();
                    }
                  },
                  onActiveTodoTapped:
                      (todo) =>
                          context.todoRouter.goToActiveTodoDetail(todo.id),
                  onComplededTodoTapped:
                      (todo) =>
                          context.todoRouter.goToCompletedTodoDetail(todo.id),
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
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/archive',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: TodoArchived(
                  onTodoTapped:
                      (todo) => context.todoRouter.go('/archive/${todo.id}'),
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
