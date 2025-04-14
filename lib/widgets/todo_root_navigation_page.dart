import 'package:flutter/material.dart';

enum TodoRootNavigation { todos, archive }

typedef NavbarItemSelectedCallback = void Function(TodoRootNavigation item);

class TodoRootNavigationPage extends StatelessWidget {
  const TodoRootNavigationPage({
    super.key,
    required this.onNavbarItemSelected,
    required this.selected,
    required this.child,
  });

  final NavbarItemSelectedCallback onNavbarItemSelected;
  final TodoRootNavigation selected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: TodoRootNavigation.values.indexOf(selected),
        onTap:
            (value) => onNavbarItemSelected(TodoRootNavigation.values[value]),
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
