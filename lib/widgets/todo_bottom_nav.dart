import 'package:flutter/material.dart';

enum TodoBottomNavItems { active, archive }

typedef TodoBottomNavItemSelectedCallback =
    void Function(TodoBottomNavItems item);

class TodoBottomNav extends StatelessWidget {
  const TodoBottomNav({
    super.key,
    required this.onSelected,
    required this.selected,
    required this.child,
  });

  final TodoBottomNavItemSelectedCallback onSelected;
  final TodoBottomNavItems selected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: TodoBottomNavItems.values.indexOf(selected),
        onTap: (value) => onSelected(TodoBottomNavItems.values[value]),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.list), label: 'Todos'),
          BottomNavigationBarItem(
            icon: const Icon(Icons.archive),
            label: 'Archive',
          ),
        ],
      ),
    );
  }
}
