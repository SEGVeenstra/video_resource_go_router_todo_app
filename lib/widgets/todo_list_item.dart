import 'package:flutter/material.dart';
import 'package:video_resource_go_router_todo_app/data/todos.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onLongPress,
  });

  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.all(0),
      color: ColorScheme.of(context).primaryContainer,
      elevation: 0,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongPress,
        title: Text(todo.title),
        trailing: todo.completed ? Icon(Icons.check) : null,
      ),
    );
  }
}
