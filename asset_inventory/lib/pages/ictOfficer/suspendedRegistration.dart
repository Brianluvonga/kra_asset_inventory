import 'package:flutter/material.dart';

class SuspendedRegistration extends StatelessWidget {
  const SuspendedRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Registration"),
        backgroundColor: Colors.red[600],
        centerTitle: true,
      ),
      body: Center(
        child: Text("Sorry Registration Suspended",
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
