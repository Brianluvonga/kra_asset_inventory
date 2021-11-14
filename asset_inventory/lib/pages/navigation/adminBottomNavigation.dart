import 'package:asset_inventory/pages/asset/forms/asset_receiving_form.dart';

import 'package:asset_inventory/pages/settings/settings.dart';
import 'package:asset_inventory/record_count/records.dart';
import 'package:flutter/material.dart';

class AdminBottomNavigation extends StatefulWidget {
  const AdminBottomNavigation({Key? key}) : super(key: key);

  @override
  _AdminBottomNavigationState createState() => _AdminBottomNavigationState();
}

class _AdminBottomNavigationState extends State<AdminBottomNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _classNavOptions = [
    SettingsPage(),
    Recordssection(),
    AssetSurrenderForm()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _classNavOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fiber_smart_record),
            title: Text('Records'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            title: Text('Reports'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
