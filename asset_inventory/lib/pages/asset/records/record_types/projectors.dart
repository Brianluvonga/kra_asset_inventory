import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewProjectors extends StatefulWidget {
  const ViewProjectors({Key? key}) : super(key: key);

  @override
  _ViewProjectorsState createState() => _ViewProjectorsState();
}

class _ViewProjectorsState extends State<ViewProjectors> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> projectorRecords =
      FirebaseFirestore.instance
          .collection('Assets')
          .where('type', isEqualTo: 'Projector')
          .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Projectors"),
          centerTitle: true,
          backgroundColor: Colors.red[600],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(5),
            child: StreamBuilder(
              stream: projectorRecords,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return DataTable(
                    columns: [
                      DataColumn(
                          label:
                              Text('Barcode', style: TextStyle(fontSize: 10))),
                      DataColumn(
                          label: Text('Condition',
                              style: TextStyle(fontSize: 10))),
                      DataColumn(
                          label: Text('Manufacturer',
                              style: TextStyle(fontSize: 10))),
                      DataColumn(
                          label: Text('Model', style: TextStyle(fontSize: 10))),
                      DataColumn(
                          label:
                              Text('SerialNo', style: TextStyle(fontSize: 10))),
                      DataColumn(
                          label: Text('Type', style: TextStyle(fontSize: 10))),
                    ],
                    rows: snapshot.data!.docs
                        .map(
                          (e) => DataRow(
                            cells: [
                              DataCell(Text(e['barcode'],
                                  style: TextStyle(fontSize: 10))),
                              DataCell(Text(e['condition'],
                                  style: TextStyle(fontSize: 10))),
                              DataCell(Text(e['manufacturer'],
                                  style: TextStyle(fontSize: 10))),
                              DataCell(Text(e['model'],
                                  style: TextStyle(fontSize: 10))),
                              DataCell(Text(e['serialNo'],
                                  style: TextStyle(fontSize: 10))),
                              DataCell(Text(e['type'],
                                  style: TextStyle(fontSize: 10))),
                            ],
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return Text('No Projectors Found');
                }
              },
            ),
          ),
        ));
  }
}
