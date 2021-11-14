import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settingitems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _settingitems(context);
  }
}

Widget _settingitems(BuildContext context) {
  return ListView(
    padding: EdgeInsets.all(10),
    children: <Widget>[
      ListTile(
        title: Text(
          'Profile Section',
          textAlign: TextAlign.center,
          style:
              TextStyle(color: Colors.blue, fontSize: 22, fontFamily: "Times"),
        ),
        subtitle: Text(
          'personal information',
          textAlign: TextAlign.center,
        ),
        onTap: () {},
      ),
      Divider(),
      ListTile(
        title: Text(
          'Payments Section',
          textAlign: TextAlign.center,
          style:
              TextStyle(color: Colors.blue, fontSize: 22, fontFamily: "Times"),
        ),
        subtitle: Text(
          'payment information',
          textAlign: TextAlign.center,
        ),
      ),
      Divider(),
      ListTile(
        title: Text(
          'Services Section',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 22,
            fontFamily: "Times",
          ),
        ),
        subtitle: Text(
          'services information',
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
