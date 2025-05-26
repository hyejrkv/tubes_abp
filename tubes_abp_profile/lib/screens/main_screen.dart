import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'calendar_screen.dart';
import 'favorite_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CalendarScreen(),
    Container(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      _showAddTaskDialog();
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: Text('Add task functionality here'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 2 ? _screens[0] : _screens[_selectedIndex],
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4C63D2), Color(0xFF6366F1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF4C63D2).withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _onItemTapped(2),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 56,
              height: 56,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          notchMargin: 8.0,
          shape: null,
          child: Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Home Icon
                Expanded(
                  child: InkWell(
                    onTap: () => _onItemTapped(0),
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: _selectedIndex == 0
                                  ? Color(0xFF4C63D2).withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              _selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                              color: _selectedIndex == 0
                                  ? Color(0xFF4C63D2)
                                  : Color(0xFF9CA3AF),
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Calendar Icon
                Expanded(
                  child: InkWell(
                    onTap: () => _onItemTapped(1),
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: _selectedIndex == 1
                                  ? Color(0xFF4C63D2).withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              _selectedIndex == 1 ? Icons.calendar_today : Icons.calendar_today_outlined,
                              color: _selectedIndex == 1
                                  ? Color(0xFF4C63D2)
                                  : Color(0xFF9CA3AF),
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Spacer for FAB
                Expanded(child: SizedBox()),
                // Favorites Icon
                Expanded(
                  child: InkWell(
                    onTap: () => _onItemTapped(3),
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: _selectedIndex == 3
                                  ? Color(0xFF4C63D2).withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              _selectedIndex == 3 ? Icons.star : Icons.star_outline,
                              color: _selectedIndex == 3
                                  ? Color(0xFF4C63D2)
                                  : Color(0xFF9CA3AF),
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Profile Icon
                Expanded(
                  child: InkWell(
                    onTap: () => _onItemTapped(4),
                    child: Container(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 48,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _selectedIndex == 4
                                  ? Color(0xFF4C63D2).withOpacity(0.15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Icon(
                                _selectedIndex == 4 ? Icons.person : Icons.person_outline,
                                color: _selectedIndex == 4
                                    ? Color(0xFF4C63D2)
                                    : Color(0xFF9CA3AF),
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}