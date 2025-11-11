import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../pages/home_page.dart';
import '../pages/events_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/create_event_page.dart';

class MainAppShell extends StatefulWidget {
  final int initialTab;

  const MainAppShell({this.initialTab = 0});

  @override
  _MainAppShellState createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages() => [
    HomePage(onNavTap: _onItemTapped),
    EventsPage(onNavTap: _onItemTapped),
    DashboardPage(onNavTap: _onItemTapped),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.event, color: AppColors.emerald600),
            SizedBox(width: 8),
            Text('EventEase', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gray800)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: AppColors.gray600),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _pages()[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.white,
          elevation: 0,
          child: Row(
            children: [
              // Create Event Button on the left
              SizedBox(
                width: 50,
                height: 56,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateEventPage()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: AppColors.emerald600, size: 24),
                      SizedBox(height: 2),
                      Text(
                        'Create',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.emerald600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Navigation items
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      icon: Icons.home,
                      label: 'Home',
                      index: 0,
                    ),
                    _buildNavItem(
                      icon: Icons.explore,
                      label: 'Browse',
                      index: 1,
                    ),
                    _buildNavItem(
                      icon: Icons.dashboard,
                      label: 'Dashboard',
                      index: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.emerald600 : AppColors.gray600,
            size: 24,
          ),
          SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? AppColors.emerald600 : AppColors.gray600,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
