import 'package:asset_inventory/api/ict_officer_api.dart';
import 'package:asset_inventory/pages/asset/feed/asset_feed.dart';
import 'package:asset_inventory/pages/ictOfficer/notifier/ictOfficer_notifier.dart';
import 'package:asset_inventory/pages/settings/profile.dart';
import 'package:asset_inventory/pages/ictOfficer/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssetSection extends StatefulWidget {
  const AssetSection({Key? key}) : super(key: key);

  @override
  _AssetSectionState createState() => _AssetSectionState();
}

class _AssetSectionState extends State<AssetSection> {
  User? user;

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      appBar: new AppBar(
        title: Text("Asset"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      endDrawer: new Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text('Settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.red[600],
              ),
              title: Text('Profile'),
              onTap: () {
                ProfileFeed();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.red[600],
              ),
              title: Text('Assets'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssetFeed(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.red[600],
              ),
              title: Text('About'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.red[600],
              ),
              title: Text('Help'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.red[600],
              ),
              title: Text('Logout'),
              onTap: () {
                signout(authNotifier);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return Login();
                  }),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return AssetFeed();
            }),
          );
        },
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red[600],
      ),
    );
  }
}
