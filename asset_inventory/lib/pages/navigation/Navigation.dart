import 'package:asset_inventory/pages/asset/deployment/feed/deployment_feed.dart';
import 'package:asset_inventory/pages/asset/feed/asset_feed.dart';
import 'package:asset_inventory/pages/asset/forms/asset_receiving_form.dart';
import 'package:asset_inventory/record_count/records.dart';

import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _classNavOptions = [
    Recordssection(),
    AssetFeed(),
    DeploymentFeed(),
    AssetSurrenderForm(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //   title: Text('Asset Inventory'),
      //   centerTitle: true,
      // ),
      body: _classNavOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.computer),
            title: Text('Records'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Add'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.outbond_outlined),
            title: Text('Deploy'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            title: Text('Surrender'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   title: Text('Settings'),
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
