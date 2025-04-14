import 'package:flutter/material.dart';
import 'package:video_resource_go_router_todo_app/todo_router.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key, required this.todoRouter});

  final TodoRouter todoRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: todoRouter,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
    );
  }
}
