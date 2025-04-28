import 'package:car_tracking/features/fleetManagement/presentation/FleetScreen.dart';
import 'package:car_tracking/features/dashboard/presentation/dashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/setting/presentation/settingScreen.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  static const List<String> _routes = ['/', '/fleet', '/settings'];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return MainScreen._routes.indexWhere((route) => location.startsWith(route));
  }
  final List<Widget> _screens = [
    DashboardPage(),
    fleetManagementScreen(),
    settingPage(),
  ];

  // حفظ الـ index الحالي للشاشة
  int _selectedIndex = 0;

  // دالة لتغيير الصفحة بناءً على الضغط على الـ BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return  Scaffold(
      body: _screens[_selectedIndex],  // عرض الشاشة بناءً على الـ index
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,  // تحديد العنصر المحدد بناءً على الـ index
        onTap: _onItemTapped,  // تغيير الشاشة عند الضغط على أي زر
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fire_truck_outlined),
            label: 'Fleet Management',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
