import 'package:flutter/material.dart';
import 'package:video_resource_go_router_todo_app/data/todos.dart';
import 'package:video_resource_go_router_todo_app/widgets/todo_list_view.dart';

enum TabsItems { active, completed }

typedef TodoActiveTabsItemSelectedCallback = void Function(TabsItems item);

class TodoActiveTabs extends StatefulWidget {
  const TodoActiveTabs({
    super.key,
    required this.selected,
    required this.onSelected,
    this.onActiveTodoTapped,
    this.onComplededTodoTapped,
  });

  final TabsItems selected;
  final TodoActiveTabsItemSelectedCallback onSelected;
  final void Function(Todo todo)? onActiveTodoTapped;
  final void Function(Todo todo)? onComplededTodoTapped;

  @override
  State<TodoActiveTabs> createState() => _TodoActiveTabsState();
}

class _TodoActiveTabsState extends State<TodoActiveTabs>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging &&
          _tabController.index != _tabController.previousIndex) {
        switch (_tabController.index) {
          case 0:
            widget.onSelected(TabsItems.active);
          case 1:
            widget.onSelected(TabsItems.completed);
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant TodoActiveTabs oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selected != widget.selected) {
      _tabController.animateTo(TabsItems.values.indexOf(widget.selected));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
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
                onTodoTapped: widget.onActiveTodoTapped,
                onTodoLongPressed: Todos().archive,
                onTodoCheck: Todos().toggleComplete,
              ),
              TodoListView(
                todos: Todos().completed,
                onTodoTapped: widget.onComplededTodoTapped,
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
