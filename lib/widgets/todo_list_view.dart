import 'package:flutter/material.dart';
import 'package:video_resource_go_router_todo_app/data/todos.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_list_item_view.dart';

typedef TodoListItemCallback = void Function(Todo todo);

class TodoListView extends StatelessWidget {
  const TodoListView({
    super.key,
    this.onTodoTapped,
    this.onTodoLongPressed,
    required this.filter,
  });

  final TodoListItemCallback? onTodoTapped;
  final TodoListItemCallback? onTodoLongPressed;
  final bool Function(Todo todo) filter;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Todos(),
      builder: (context, snapshot) {
        final todos = Todos().todos.where((todo) => filter(todo)).toList();
        return ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          padding: EdgeInsets.all(16),
          itemCount: todos.length,
          itemBuilder:
              (context, index) => TodoListItemView(
                todo: todos[index],
                onTap:
                    onTodoTapped != null
                        ? () => onTodoTapped!(todos[index])
                        : () {},
                onLongPress:
                    onTodoLongPressed != null
                        ? () => onTodoLongPressed!(todos[index])
                        : null,
              ),
        );
      },
    );
  }
}
