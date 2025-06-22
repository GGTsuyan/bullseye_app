import 'package:flutter/material.dart';
import 'dart_tracking_screen.dart';
import 'scoreboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = const [
    DartTrackingScreen(),
    ScoreboardScreen(),
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.camera_alt_outlined),
      activeIcon: Icon(Icons.camera_alt),
      label: 'Track',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.scoreboard_outlined),
      activeIcon: Icon(Icons.scoreboard),
      label: 'Score',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: _navItems,
          selectedFontSize: 12,
          unselectedFontSize: 12,
        ),
      ),
    );
  }
}
