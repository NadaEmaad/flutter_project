import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travell_app/auth_provider.dart';
import 'package:travell_app/screens/category_screen.dart';
import '../widgets/app_drawer.dart';
import './favorites_screen.dart';
import '../models/trip.dart';

class TabsScreen extends StatefulWidget {
  final List<Trip> favoriteTrips;

  const TabsScreen(this.favoriteTrips, {super.key});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  int _selectedScreenIndex = 0;

  late List<Map<String, Object>> _screens;

  @override
  void initState() {
    _screens = [
      {
        'Screen': const CategoryScreen(),
        'Title': 'تصنيفات الرحلات',
      },
      {
        'Screen': FavoritesScreen(widget.favoriteTrips),
        'Title': 'الرحلات المفضلة',
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<RegisterProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                authProvider.signOut(context);
              },
              icon: const Icon(Icons.logout))
        ],
        title: Text(_screens[_selectedScreenIndex]['Title'].toString()),
      ),
      drawer: const AppDrawer(),
      body: _screens[_selectedScreenIndex]['Screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedScreenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'التصنيفات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'المفضلة',
          ),
        ],
      ),
    );
  }
}
