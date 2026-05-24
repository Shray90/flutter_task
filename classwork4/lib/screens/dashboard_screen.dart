import 'package:flutter/material.dart';

import 'arithmetic_screen.dart';
import 'image_screen.dart';
import 'palindrom_screen.dart';
import 'si_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final _screens = const <Widget>[
    ArithmeticScreen(),
    SiScreen(),
    ImageScreen(),
    PalindromScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Arithmetic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'SI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Images',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Palindrome',
          ),
        ],
      ),
    );
  }
}



