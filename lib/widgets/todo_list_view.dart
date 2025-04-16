import 'package:flutter/material.dart';
import 'package:video_resource_go_router_todo_app/data/todos.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_list_item.dart';

typedef TodoListItemCallback = void Function(Todo todo);

class TodoListView extends StatelessWidget {
  const TodoListView({
    super.key,
    this.onTodoTapped,
    this.onTodoLongPressed,
    required this.todos,
  });

  final TodoListItemCallback? onTodoTapped;
  final TodoListItemCallback? onTodoLongPressed;
  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      padding: EdgeInsets.all(16),
      itemCount: todos.length,
      itemBuilder:
          (context, index) => TodoListItem(
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
  }
}
