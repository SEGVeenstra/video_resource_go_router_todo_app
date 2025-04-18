import 'package:flutter/material.dart';
import 'package:video_resource_go_router_todo_app/data/todos.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_list_view.dart';

class TodoArchived extends StatelessWidget {
  const TodoArchived({super.key, this.onTodoTapped});

  final void Function(Todo todo)? onTodoTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Archived')),
      body: ListenableBuilder(
        listenable: Todos(),
        builder: (context, snapshot) {
          return TodoListView(
            todos: Todos().archived,
            onTodoLongPressed: Todos().unarchive,
            onTodoCheck: Todos().toggleComplete,
            onTodoTapped: onTodoTapped,
          );
        },
      ),
    );
  }
}
