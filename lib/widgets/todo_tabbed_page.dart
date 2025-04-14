import 'package:flutter/material.dart';

enum TodoTabbedItem { active, completed }

typedef TodoTabbedItemSelectedCallback = void Function(TodoTabbedItem item);

class TodoTabbedPage extends StatefulWidget {
  const TodoTabbedPage({
    super.key,
    required this.selected,
    required this.activeList,
    required this.completedList,
    required this.onTabSelected,
    required this.title,
  });

  final TodoTabbedItem selected;
  final Widget activeList;
  final Widget completedList;
  final TodoTabbedItemSelectedCallback onTabSelected;
  final String title;

  @override
  State<TodoTabbedPage> createState() => _TodoTabbedPageState();
}

class _TodoTabbedPageState extends State<TodoTabbedPage>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (TodoTabbedItem.values.indexOf(widget.selected)) {
          case 0:
            widget.onTabSelected(TodoTabbedItem.active);
          case 1:
            widget.onTabSelected(TodoTabbedItem.completed);
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant TodoTabbedPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selected != widget.selected) {
      _tabController.animateTo(TodoTabbedItem.values.indexOf(widget.selected));
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
      body: TabBarView(
        controller: _tabController,
        children: [widget.activeList, widget.completedList],
      ),
    );
  }
}
