import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewSwitches extends StatefulWidget {
  const ViewSwitches({Key? key}) : super(key: key);

  @override
  _ViewSwitchesState createState() => _ViewSwitchesState();
}

class _ViewSwitchesState extends State<ViewSwitches> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> noOfSwitches =
      FirebaseFirestore.instance
          .collection('Assets')
          .where('type', isEqualTo: 'Switch')
          .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Switches"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Container(
        child: StreamBuilder(
          stream: noOfSwitches,
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
                          DataCell(
                              Text(e['model'], style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['serialNo'],
                              style: TextStyle(fontSize: 10))),
                          DataCell(
                              Text(e['type'], style: TextStyle(fontSize: 10))),
                        ]))
                    .toList(),
              );
            } else {
              return Text('No Switches Recorded In Assets Entry');
            }
          },
        ),
      ),
    );
  }
}
