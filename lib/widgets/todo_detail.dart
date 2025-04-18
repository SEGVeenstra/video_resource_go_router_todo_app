import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_resource_go_router_todo_app/data/todos.dart';

class TodoDetail extends StatelessWidget {
  const TodoDetail({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Todos(),
      builder: (context, child) {
        final todo = Todos().todos.firstWhere((todo) => todo.id == id);
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        todo.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Checkbox(
                      value: todo.completed,
                      onChanged: (value) {
                        Todos().toggleComplete(todo);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    todo.archived
                        ? Todos().unarchive(todo)
                        : Todos().archive(todo);
                  },
                  child: Text(todo.archived ? 'Unarchive' : 'Archive'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
