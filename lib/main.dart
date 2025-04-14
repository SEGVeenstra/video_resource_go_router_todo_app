import 'package:flutter/material.dart';
import 'package:video_resource_go_router_todo_app/todo_app.dart';
import 'package:video_resource_go_router_todo_app/todo_router.dart';

void main() {
  final todoRouter = TodoRouter();
  runApp(TodoApp(todoRouter: todoRouter));
}
