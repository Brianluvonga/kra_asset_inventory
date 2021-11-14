import 'package:asset_inventory/api/ict_officer_api.dart';
import 'package:asset_inventory/pages/asset/records/asset_captured_record.dart';
import 'package:asset_inventory/pages/asset/records/assets_In_Use.dart';
import 'package:asset_inventory/pages/asset/records/deployed_asset_records.dart';
import 'package:asset_inventory/pages/asset/records/faulty_Assets.dart';
import 'package:asset_inventory/pages/asset/records/obsolete_records.dart';
import 'package:asset_inventory/pages/asset/records/record_types/laptop.dart';
import 'package:asset_inventory/pages/asset/records/record_types/printer.dart';
import 'package:asset_inventory/pages/asset/records/record_types/switch.dart';
import 'package:asset_inventory/pages/asset/records/record_types/vdi.dart';
import 'package:asset_inventory/pages/ictOfficer/login.dart';
import 'package:asset_inventory/pages/ictOfficer/notifier/ictOfficer_notifier.dart';
import 'package:asset_inventory/pages/settings/profile.dart';
import 'package:asset_inventory/record_count/record_types.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Recordssection extends StatefulWidget {
  const Recordssection({Key? key}) : super(key: key);

  @override
  _RecordssectionState createState() => _RecordssectionState();
}

class _RecordssectionState extends State<Recordssection> {
  CollectionReference assetsCaptured =
      FirebaseFirestore.instance.collection('Assets');

  CollectionReference assetsDeployed =
      FirebaseFirestore.instance.collection('Deployment');

  Widget assetsCapturedCard() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 120,
        width: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: requestCountAssets(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Assets",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 35),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => AssetFeed(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red[600],
                  // value: 0,
                ),
              );
            }
          },
        ),
      ),
    );
  }

//count number of assets in the system
  Stream<QuerySnapshot> requestCountAssets() {
    return assetsCaptured.snapshots();
  }

// count assets deployed
  Stream<QuerySnapshot> requestCountAssetsDeployed() {
    return assetsDeployed.snapshots();
  }

// count assets In Use
  Stream<QuerySnapshot> requestCountAssetsInUse() {
    return assetsCaptured.where('condition', isEqualTo: 'In Use').snapshots();
  }

  Stream<QuerySnapshot> requestCountFaultyAssets() {
    return assetsCaptured.where('condition', isEqualTo: 'Faulty').snapshots();
  }

  Stream<QuerySnapshot> requestCountObsoleteAssets() {
    return assetsCaptured.where('condition', isEqualTo: 'Obsolete').snapshots();
  }

  Widget assetsDeployedCard() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 120,
        width: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: requestCountAssetsDeployed(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Assets Deployed",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 35),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DeployedAssetsRecords(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(color: Colors.red[600]),
            );
          },
        ),
      ),
    );
  }

  Widget assetsInUse() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: requestCountAssetsInUse(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "In Use",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 20),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ViewAssetsInUse(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(color: Colors.red[600]),
            );
          },
        ),
      ),
    );
  }

  Widget assetsObsolete() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: requestCountObsoleteAssets(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Obsolete",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 20),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ViewObsoleteAssets(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(color: Colors.red[600]),
            );
          },
        ),
      ),
    );
  }

  Widget faultyAssets() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: requestCountFaultyAssets(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Faulty",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 20),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ViewFaultyAssets(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red[600],
                  // value: 0,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      appBar: new AppBar(
        title: Text("Records"),
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
              child: Text(
                'Records and Reports',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            ListTile(
              title: Text('More Records'),
              leading: Icon(Icons.receipt, color: Colors.red[600]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => RecordTypesCaptured(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings, color: Colors.red[600]),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => ProfileFeed(),
                //   ),
                // );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help, color: Colors.red[600]),
              title: Text('Logout'),
              onTap: () {
                signout(authNotifier);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => Login(),
                  ),
                );
                // ...
              },
            ),
          ],
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: <Widget>[
          ClipPath(
            // clipper: ClippingClass(),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 2 / 7,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Colors.white],
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 150,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        assetsInUse(),
                        faultyAssets(),
                        assetsObsolete()
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            right: 2,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        assetsCapturedCard(),
                        assetsDeployedCard(),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   width: double.infinity,
          //   height: MediaQuery.of(context).size.height * 2 / 7,
          //   child: Column(
          //     children: <Widget>[
          //       GestureDetector(
          //         behavior: HitTestBehavior.translucent,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: <Widget>[
          //             assetsCapturedCard(),
          //             assetsDeployedCard(),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
