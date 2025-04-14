import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:video_resource_go_router_todo_app/data/todos.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_list_view.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_page.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_root_navigation_page.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_tabbed_page.dart';

class TodoRouter extends GoRouter {
  TodoRouter()
    : super.routingConfig(
        initialLocation: '/active',
        routingConfig: ValueNotifier(RoutingConfig(routes: _routes)),
      );

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
        (context, state, child) => TodoRootNavigationPage(
          onNavbarItemSelected: (item) {
            switch (item) {
              case TodoRootNavigation.todos:
                context.todoRouter.goToTodos();
              case TodoRootNavigation.archive:
                context.todoRouter.goToArchive();
            }
          },
          selected: switch (state.pathParameters['tab']) {
            'active' => TodoRootNavigation.todos,
            'completed' => TodoRootNavigation.archive,
            _ => TodoRootNavigation.todos,
          },
          child: child,
        ),
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/archive',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: TodoPage(
                  title: 'Archive',
                  child: TodoListView(
                    filter: (todo) => todo.archived,
                    onTodoLongPressed: Todos().unarchive,
                  ),
                ),
              );
            },
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
                'active' => TodoTabbedItem.active,
                'completed' => TodoTabbedItem.completed,
                _ => TodoTabbedItem.active,
              };
              return NoTransitionPage(
                child: TodoTabbedPage(
                  title: 'Todos',
                  selected: tab,
                  activeList: TodoListView(
                    filter: (todo) => !todo.completed && !todo.archived,
                    onTodoTapped: Todos().toggleComplete,
                    onTodoLongPressed: Todos().archive,
                  ),
                  completedList: TodoListView(
                    filter: (todo) => todo.completed && !todo.archived,
                    onTodoLongPressed: Todos().archive,
                    onTodoTapped: Todos().toggleComplete,
                  ),
                  onTabSelected: (item) {
                    switch (item) {
                      case TodoTabbedItem.active:
                        context.todoRouter.goToTodos();
                      case TodoTabbedItem.completed:
                        context.todoRouter.goToCompleted();
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    ],
  ),
];
