import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

enum MenuPop { menu, help, logout }

class _SettingsPageState extends State<SettingsPage> {
  Widget settingsMenu() {
    return ListView(
      padding: EdgeInsets.all(10),
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            'Admin Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.blue, fontSize: 22, fontFamily: "Times"),
          ),
          subtitle: Text(
            'personal information',
            textAlign: TextAlign.center,
          ),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text(
            'Notifications',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.blue, fontSize: 22, fontFamily: "Times"),
          ),
          subtitle: Text(
            'Notes,Messages',
            textAlign: TextAlign.center,
          ),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.help),
          title: Text(
            'Help',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22,
              fontFamily: "Times",
            ),
          ),
          subtitle: Text(
            'About,Documentation',
            textAlign: TextAlign.center,
          ),
          onTap: () {},
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Settings", style: TextStyle()),
        centerTitle: true,
        backgroundColor: Colors.red[600],
        // actions: [Icon(Icons.menu_book_sharp), _popUpMenu()],
      ),
      body: settingsMenu(),
    );
  }
}
