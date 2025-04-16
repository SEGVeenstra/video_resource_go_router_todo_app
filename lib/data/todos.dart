import 'package:flutter/material.dart';

class Todo {
  int id;
  String title;
  bool completed;
  bool archived;

  Todo({
    required this.id,
    required this.title,
    this.completed = false,
    required this.archived,
  });
}

class Todos with ChangeNotifier {
  static Todos? _instance;
  Todos._();

  factory Todos() {
    _instance ??= Todos._();
    return _instance!;
  }

  List<Todo> todos = [
    Todo(id: 1, title: 'Make lunch', completed: false, archived: false),
    Todo(id: 2, title: 'Feed dog', completed: true, archived: false),
    Todo(id: 3, title: 'Watch movie', archived: true),
  ];

  List<Todo> get active =>
      todos.where((todo) => !todo.completed && !todo.archived).toList();
  List<Todo> get archived => todos.where((todo) => todo.archived).toList();
  List<Todo> get completed =>
      todos.where((todo) => todo.completed && !todo.archived).toList();

  void toggleComplete(Todo todo) {
    todo.completed = !todo.completed;
    notifyListeners();
  }

  void archive(Todo todo) {
    todo.archived = true;
    notifyListeners();
  }

  void unarchive(Todo todo) {
    todo.archived = false;
    notifyListeners();
  }
}
