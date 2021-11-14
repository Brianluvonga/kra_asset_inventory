import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewFaultyAssets extends StatefulWidget {
  const ViewFaultyAssets({Key? key}) : super(key: key);

  @override
  _ViewFaultyAssetsState createState() => _ViewFaultyAssetsState();
}

class _ViewFaultyAssetsState extends State<ViewFaultyAssets> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> obsoleteAssets =
      FirebaseFirestore.instance
          .collection('Assets')
          .where('condition', isEqualTo: 'Faulty')
          .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Faulty Assets"),
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
                          DataCell(Text(e['barcode'],
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['condition'],
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['manufacturer'],
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['model'].toString().trim(),
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['serialNo'].toString().trim(),
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['type'].toString().trim(),
                              style: TextStyle(fontSize: 10))),
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
