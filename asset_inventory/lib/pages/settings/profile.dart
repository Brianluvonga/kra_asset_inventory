import 'package:asset_inventory/pages/ictOfficer/notifier/ictOfficer_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileFeed extends StatefulWidget {
  const ProfileFeed();

  @override
  _ProfileFeedState createState() => _ProfileFeedState();
}

class _ProfileFeedState extends State<ProfileFeed> {
  @override
  Widget build(context) {
    return _settingitems(context);
  }

  Widget _settingitems(BuildContext context) {
    AuthNotifier? authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      appBar: new AppBar(
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontFamily: 'times'),
          ),
          backgroundColor: Color(0xff2a0404)),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(15),
          children: <Widget>[
            ListTile(
              title: Text(
                "Ict Officer Name",
                // textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    fontFamily: "Times"),
              ),
              subtitle: Text(
                authNotifier.ictOfficer!.displayName.toString(),
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(Icons.edit),
              onTap: () => {},
            ),
            Divider(),
            ListTile(
              title: Text(
                "Email",
                // textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    fontFamily: "Times"),
              ),
              subtitle: Text(
                "Email",
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(Icons.edit),
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
