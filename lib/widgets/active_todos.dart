import 'package:flutter/material.dart';
import 'package:video_resource_go_router_todo_app/data/todos.dart';
import 'package:video_resource_go_router_todo_app/todo_router.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_list_view.dart';

enum TabsItems { active, completed }

typedef TabsItemItemSelectedCallback = void Function(TabsItems item);

class Tabs extends StatefulWidget {
  const Tabs({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.title,
  });

  final TabsItems selected;
  final TabsItemItemSelectedCallback onSelected;
  final String title;

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (TabsItems.values.indexOf(widget.selected)) {
          case 0:
            widget.onSelected(TabsItems.active);
          case 1:
            widget.onSelected(TabsItems.completed);
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant Tabs oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selected != widget.selected) {
      _tabController.animateTo(TabsItems.values.indexOf(widget.selected));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Active'), Tab(text: 'Completed')],
        ),
      ),
      body: ListenableBuilder(
        listenable: Todos(),
        builder: (context, snapshot) {
          return TabBarView(
            controller: _tabController,
            children: [
              TodoListView(
                todos: Todos().active,
                onTodoTapped: (todo) => context.todoRouter.goToTodo(todo.id),
                onTodoLongPressed: Todos().archive,
                onTodoCheck: Todos().toggleComplete,
              ),
              TodoListView(
                todos: Todos().completed,
                onTodoTapped: (todo) => context.todoRouter.goToTodo(todo.id),
                onTodoLongPressed: Todos().archive,
                onTodoCheck: Todos().toggleComplete,
              ),
            ],
          );
        },
      ),
    );
  }
}
