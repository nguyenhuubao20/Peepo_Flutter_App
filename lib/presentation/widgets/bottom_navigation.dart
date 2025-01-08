import 'package:flutter/material.dart';
import 'package:peefo/presentation/screens/home/home_screen.dart';
import 'package:peefo/presentation/screens/order/order_history_screen.dart';
import 'package:peefo/presentation/screens/product/product_search_screen.dart';

import '../screens/setting/setting_screen.dart';

class BottomNavigation extends StatefulWidget {
  final Widget child;

  const BottomNavigation({Key? key, required this.child}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    ProductSearchScreen(),
    OrderHistoryScreen(),
    SettingsScreen()
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_outlined),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
