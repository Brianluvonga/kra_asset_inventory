import 'package:asset_inventory/pages/navigation/adminBottomNavigation.dart';
import 'package:asset_inventory/pages/navigation/Navigation.dart';
import 'package:asset_inventory/pages/ictOfficer/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menusection extends StatefulWidget {
  const Menusection({Key? key}) : super(key: key);

  @override
  _MenusectionState createState() => _MenusectionState();
}

class _MenusectionState extends State<Menusection> {
  signout() async {
    await FirebaseAuth.instance
        .signOut()
        .catchError(
          (error) => print(error.code),
        )
        .then(
          (value) => print("Successfully Logged Out"),
        );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }

  Widget cardAdmin() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          child: Text(
            "Admin",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontFamily: 'times'),
          ),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminBottomNavigation(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget cardAsset() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          child: Text(
            "Asset",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontFamily: 'times'),
          ),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Menu"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      drawer: new Drawer(
          child: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.lightBlue,
            ),
            title: Text("Profile"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.lightBlue,
            ),
            title: Text("Logout"),
            onTap: () => signout(),
          ),
        ],
      )),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: <Widget>[
          ClipPath(
            clipper: ClippingClass(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 2 / 7,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.red, Colors.black],
                ),
              ),
            ),
          ),
          Positioned(
            left: 70,
            top: 50,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("ICT Asset Inventory Application",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    )),
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: 150,
            right: 20,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[cardAdmin(), cardAsset()],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    var controlPoint = Offset(size.width - (size.width / 2), size.height - 120);
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
