import 'package:flutter/material.dart';
import 'package:tastemate_app/core/constants/app_styles.dart';
import 'package:tastemate_app/feature/cart/view/cart_page.dart';
import 'package:tastemate_app/feature/dashboard/dashboard_page.dart';
import 'package:tastemate_app/feature/discovery/view/discovery_page.dart';
import 'package:tastemate_app/feature/recipes/view/recipes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const <Widget>[
    DashboardPage(),
    DiscoveryPage(),
    Center(
      child: Text(
        'Chức năng chưa được cập nhật ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    RecipesPage(),
    CartPage(),
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Xác nhận thoát'),
            content:
                const Text('Bạn có chắc chắn muốn thoát khỏi ứng dụng không?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Không'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Có'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomAppBar(
          height: 76,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              bottomAppBarItem(
                title: 'Home',
                icon: Icons.home,
                index: 0,
              ),
              bottomAppBarItem(
                index: 1,
                title: 'Discovery',
                icon: Icons.grid_view_rounded,
              ),
              bottomAppBarItem(
                index: 2,
                icon: Icons.add_circle_outlined,
                title: ' ',
              ),
              bottomAppBarItem(
                index: 3,
                title: 'Recipes',
                icon: Icons.cookie,
              ),
              bottomAppBarItem(
                index: 4,
                title: 'cart',
                icon: Icons.shopping_cart,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomAppBarItem({
    required int index,
    required String title,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index
                ? AppStyles.primaryColor
                : Colors.grey.shade700,
            size: 32,
          ),
          Text(
            title,
            style: TextStyle(
              color: _selectedIndex == index
                  ? AppStyles.primaryColor
                  : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
