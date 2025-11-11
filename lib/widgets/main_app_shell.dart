import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../pages/home_page.dart';
import '../pages/events_page.dart';
import '../pages/dashboard_page.dart';
import '../pages/profile_page.dart';
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
    ProfilePage(onNavTap: _onItemTapped),
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
          // Create Event Button (Top Right)
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateEventPage()),
                );
              },
              icon: Icon(Icons.add, size: 18),
              label: Text('Create', style: TextStyle(fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.emerald600,
                foregroundColor: Colors.white,
                elevation: 2,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          // Profile Button
          IconButton(
            icon: Icon(Icons.person, color: AppColors.gray600),
            onPressed: () => _onItemTapped(3),
            tooltip: 'Profile',
          ),
          // Logout Button
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
