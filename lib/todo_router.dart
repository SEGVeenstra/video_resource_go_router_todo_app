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
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/active/todo',
        routingConfig: ValueNotifier(RoutingConfig(routes: _routes)),
      );

  // TODO: add navigation methods
  void goToActive() {
    go('/active/todo');
  }

  void goToCompleted() {
    go('/active/completed');
  }

  void goToArchivedDetail(int id) {
    go('/archived/$id');
  }

  void goToActiveDetail(int id) {
    go('/active/todo/$id');
  }

  void goToCompletedDetail(int id) {
    go('/active/completed/$id');
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
        (context, state, navigationShell) => TodoBottomNav(
          onSelected:
              (item) => navigationShell.goBranch(
                TodoBottomNavItems.values.indexOf(item),
              ),
          selected: TodoBottomNavItems.values[navigationShell.currentIndex],
          child: navigationShell,
        ),
    branches: [
      StatefulShellBranch(
        initialLocation: '/active/todo',
        routes: [
          GoRoute(
            path: '/active/:tab',
            pageBuilder: (context, state) {
              final selectedItem =
                  state.pathParameters['tab'] == 'completed'
                      ? TabsItems.completed
                      : TabsItems.active;

              return NoTransitionPage(
                child: TodoActiveTabs(
                  selected: selectedItem,
                  onSelected:
                      (item) => switch (item) {
                        TabsItems.active => context.todoRouter.goToActive(),
                        TabsItems.completed =>
                          context.todoRouter.goToCompleted(),
                      },
                  onActiveTodoTapped:
                      (todo) => context.todoRouter.goToActiveDetail(todo.id),
                  onComplededTodoTapped:
                      (todo) => context.todoRouter.goToCompletedDetail(todo.id),
                ),
              );
            },
            routes: [_detailPageRoute],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/archived',
            pageBuilder:
                (context, state) => NoTransitionPage(
                  child: TodoArchived(
                    onTodoTapped:
                        (todo) =>
                            context.todoRouter.goToArchivedDetail(todo.id),
                  ),
                ),
            routes: [_detailPageRoute],
          ),
        ],
      ),
    ],
  ),
];

final _detailPageRoute = GoRoute(
  parentNavigatorKey: _rootNavigatorKey,
  path: ':id',
  builder: (context, state) {
    final id = int.parse(state.pathParameters['id']!);
    return TodoDetail(id: id);
  },
);
