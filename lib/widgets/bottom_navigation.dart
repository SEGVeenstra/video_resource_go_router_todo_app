import 'package:flutter/material.dart';

enum BottomNavigationItems { todos, archive }

typedef BottomNavigationItemSelectedCallback =
    void Function(BottomNavigationItems item);

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.onSelected,
    required this.selected,
    required this.child,
  });

  final BottomNavigationItemSelectedCallback onSelected;
  final BottomNavigationItems selected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: BottomNavigationItems.values.indexOf(selected),
        onTap: (value) => onSelected(BottomNavigationItems.values[value]),
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
