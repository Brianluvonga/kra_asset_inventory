import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeployedAssetsRecords extends StatefulWidget {
  const DeployedAssetsRecords({Key? key}) : super(key: key);

  @override
  _DeployedAssetsRecordsState createState() => _DeployedAssetsRecordsState();
}

class _DeployedAssetsRecordsState extends State<DeployedAssetsRecords> {
  final CollectionReference assetsDeployed =
      FirebaseFirestore.instance.collection('Deployment');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Deployed Assets"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: assetsDeployed.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return DataTable(
                columnSpacing: 20,
                columns: [
                  DataColumn(
                      label: Text('Barcode', style: TextStyle(fontSize: 10))),
                  DataColumn(
                      label: Text('UserPin', style: TextStyle(fontSize: 10))),
                  DataColumn(
                      label: Text('UserFloor', style: TextStyle(fontSize: 10))),
                  DataColumn(
                      label: Text('UserDepartment',
                          style: TextStyle(fontSize: 10))),
                  DataColumn(
                      label:
                          Text('UserStation', style: TextStyle(fontSize: 10))),
                  DataColumn(
                      label: Text('DateOfDeployment',
                          style: TextStyle(fontSize: 10))),
                  DataColumn(
                      label:
                          Text('DeployedBy', style: TextStyle(fontSize: 10))),
                ],
                rows: snapshot.data!.docs
                    .map((e) => DataRow(cells: [
                          DataCell(Text(e['barcode'].toString(),
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['userPIN'].toString(),
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['floor'].toString(),
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['department'].toString(),
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['station'].toString(),
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['createdAt'].toDate().toString(),
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['ictOfficerName'].toString(),
                              style: TextStyle(fontSize: 10)))
                        ]))
                    .toList(),
              );
            } else {
              return Center(
                  child: new CircularProgressIndicator(color: Colors.red[600]));
            }
          },
        ),
      ),
    );
  }
}
