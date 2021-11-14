import 'package:asset_inventory/pages/asset/records/faulty_Assets.dart';
import 'package:asset_inventory/pages/asset/records/record_types/cpu.dart';
import 'package:asset_inventory/pages/asset/records/record_types/ipPhones.dart';
import 'package:asset_inventory/pages/asset/records/record_types/laptop.dart';
import 'package:asset_inventory/pages/asset/records/record_types/monitor.dart';
import 'package:asset_inventory/pages/asset/records/record_types/printer.dart';
import 'package:asset_inventory/pages/asset/records/record_types/switch.dart';
import 'package:asset_inventory/pages/asset/records/record_types/tablet.dart';
import 'package:asset_inventory/pages/asset/records/record_types/vdi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecordTypesCaptured extends StatefulWidget {
  const RecordTypesCaptured({Key? key}) : super(key: key);

  @override
  _RecordTypesCapturedState createState() => _RecordTypesCapturedState();
}

class _RecordTypesCapturedState extends State<RecordTypesCaptured> {
  CollectionReference assetsCaptured =
      FirebaseFirestore.instance.collection('Assets');

  // asset type records section

  Stream<QuerySnapshot> countCPUs() {
    return assetsCaptured.where('type', isEqualTo: 'CPU').snapshots();
  }

  Stream<QuerySnapshot> countVDIs() {
    return assetsCaptured.where('type', isEqualTo: 'VDI').snapshots();
  }

  Stream<QuerySnapshot> countLaptops() {
    return assetsCaptured.where('type', isEqualTo: 'Laptop').snapshots();
  }

  Stream<QuerySnapshot> countPrinters() {
    return assetsCaptured.where('type', isEqualTo: 'Printer').snapshots();
  }

  Stream<QuerySnapshot> countSwitches() {
    return assetsCaptured.where('type', isEqualTo: 'Switch').snapshots();
  }

  Stream<QuerySnapshot> countMonitor() {
    return assetsCaptured.where('type', isEqualTo: 'Monitor').snapshots();
  }

  Stream<QuerySnapshot> countTablets() {
    return assetsCaptured.where('type', isEqualTo: 'Tablet').snapshots();
  }

  Stream<QuerySnapshot> countIP_Phones() {
    return assetsCaptured.where('type', isEqualTo: 'IP Phone').snapshots();
  }

  Widget vdiEntry() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 100,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: countVDIs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "VDIs",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 30),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ViewNoOfVDIs(),
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

  Widget laptopEntry() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 100,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: countLaptops(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Laptops",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 30),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ViewLaptops(),
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

  Widget printerEntry() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 100,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: countPrinters(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Printers",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 30),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ViewPrintersCaptured(),
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

  Widget switchEntry() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 100,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: countSwitches(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Switches",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 30),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ViewSwitches(),
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

  Widget CPUEntry() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 100,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: countCPUs(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "CPUs",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 30),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ViewCPUs(),
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

  Widget monitorEntry() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 100,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: countMonitor(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Monitors",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 30),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ViewMonitors(),
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

  Widget ipPhonesEntry() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 100,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: countIP_Phones(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "IpPhones",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 30),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ViewIpPhones(),
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

  Widget tabletEntry() {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      child: Container(
        height: 100,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: countTablets(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Tablets",
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          snapshot.data!.size.toString(),
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xff2a0404), fontSize: 30),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ViewTablets(),
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
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'Asset Types',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: <Widget>[
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
                        switchEntry(),
                        printerEntry(),
                        laptopEntry(),
                        tabletEntry()
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
                      Row(
                        children: <Widget>[
                          CPUEntry(),
                          vdiEntry(),
                          monitorEntry(),
                          ipPhonesEntry()
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
