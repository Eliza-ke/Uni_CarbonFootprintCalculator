import 'package:daily_carbon_footprint/Screen/HistoryScreen.dart';
import 'package:daily_carbon_footprint/model/history_item.dart';
import 'package:flutter/material.dart';

import '../widget/start_widget.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  final List<HistoryItem> _historyItem = [];

  int _selectedPageIndex = 0;
  void _selectedBottomNavigation(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = StartWidget(historyItem: _historyItem);

    if (_selectedPageIndex == 1) {
      setState(() {
        activePage = HistoryScreen();
      });
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
        child: activePage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectedBottomNavigation,
        items: const [
          BottomNavigationBarItem(
            // index = 0
            icon: Icon(Icons.calculate),
            label: 'Calculate',
          ),
          BottomNavigationBarItem(
            // index = 1
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
