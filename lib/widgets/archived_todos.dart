import 'package:flutter/material.dart';
import 'package:video_resource_go_router_todo_app/data/todos.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_list_view.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListenableBuilder(
        listenable: Todos(),
        builder: (context, snapshot) {
          return TodoListView(
            todos: Todos().archived,
            onTodoLongPressed: Todos().unarchive,
          );
        },
      ),
    );
  }
}
