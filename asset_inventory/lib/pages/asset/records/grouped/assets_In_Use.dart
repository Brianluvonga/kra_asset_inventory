import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewAssetsInUse extends StatefulWidget {
  const ViewAssetsInUse({Key? key}) : super(key: key);

  @override
  _ViewAssetsInUseState createState() => _ViewAssetsInUseState();
}

class _ViewAssetsInUseState extends State<ViewAssetsInUse> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> obsoleteAssets =
      FirebaseFirestore.instance
          .collection('Assets')
          .where('condition', isEqualTo: 'In Use')
          .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Assets In Use"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Container(
        child: StreamBuilder(
          stream: obsoleteAssets,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return DataTable(
                columns: [
                  DataColumn(
                      label: Text('Barcode', style: TextStyle(fontSize: 10))),
                  DataColumn(
                      label: Text('Condition', style: TextStyle(fontSize: 10))),
                  DataColumn(
                      label:
                          Text('Manufacturer', style: TextStyle(fontSize: 10))),
                  DataColumn(
                      label: Text('Model', style: TextStyle(fontSize: 10))),
                  DataColumn(
                      label: Text('SerialNo', style: TextStyle(fontSize: 10))),
                  DataColumn(
                      label: Text('Type', style: TextStyle(fontSize: 10))),
                ],
                rows: snapshot.data!.docs
                    .map((e) => DataRow(cells: [
                          DataCell(
                            Text(
                              e['barcode'],
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          DataCell(
                            Text(
                              e['condition'],
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          DataCell(
                            Text(
                              e['manufacturer'],
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          DataCell(
                              Text(e['model'], style: TextStyle(fontSize: 10))),
                          DataCell(
                            Text(
                              e['serialNo'],
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          DataCell(
                            Text(
                              e['type'],
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ]))
                    .toList(),
              );
            } else {
              return Text('No Assets In Use Recorded');
            }
          },
        ),
      ),
    );
  }
}
