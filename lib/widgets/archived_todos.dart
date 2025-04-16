import 'package:flutter/material.dart';
import 'package:video_resource_go_router_todo_app/data/todos.dart';
import 'package:video_resource_go_router_todo_app/todo_router.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_list_view.dart';

class ArchivedTodo extends StatelessWidget {
  const ArchivedTodo({super.key});

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
            onTodoTapped: (todo) => context.todoRouter.goToTodo(todo.id),
          );
        },
      ),
    );
  }
}
