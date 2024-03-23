import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  final int selectedIndex;
  final Widget bodyContent;

  const MainLayout({
    super.key,
    required this.selectedIndex,
    required this.bodyContent,
  });

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed('/inicio');
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed('/biblia');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Biblia',
          ),
        ],
        currentIndex: widget.selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
