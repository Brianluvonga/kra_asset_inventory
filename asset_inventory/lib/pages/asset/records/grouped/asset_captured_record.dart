import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:excel/excel.dart';

class AssetFeed extends StatefulWidget {
  @override
  _AssetFeedState createState() => _AssetFeedState();
}

class _AssetFeedState extends State<AssetFeed> {
  final CollectionReference assetsCaptured =
      FirebaseFirestore.instance.collection('Assets');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        centerTitle: true,
        title: Text("Assets"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(5),
          child: StreamBuilder(
            stream: assetsCaptured.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return DataTable(
                  columnSpacing: 15,
                  showCheckboxColumn: false,
                  columns: [
                    DataColumn(
                        label: Text('Barcode', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('Manufacturer',
                            style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label:
                            Text('SerialNo', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('Model', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('Type', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label:
                            Text('Condition', style: TextStyle(fontSize: 10))),
                  ],
                  rows: snapshot.data!.docs
                      .map(
                        (e) => DataRow(cells: [
                          DataCell(Text(e['barcode'].toString(),
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['manufacturer'],
                              style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['serialNo'],
                              style: TextStyle(fontSize: 10))),
                          DataCell(
                              Text(e['model'], style: TextStyle(fontSize: 10))),
                          DataCell(
                              Text(e['type'], style: TextStyle(fontSize: 10))),
                          DataCell(Text(e['condition'],
                              style: TextStyle(fontSize: 10)))
                        ], onSelectChanged: (value) {}),
                      )
                      .toList(),
                );
              } else {
                return Center(
                  child: new CircularProgressIndicator(color: Colors.red[600]),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // exportAssetDataToExcel(assetsCaptured);
        },
        child: const Text("Excel"),
        backgroundColor: Colors.black,
      ),
    );
  }

  // exportAssetDataToExcel(assetsCaptured) async {
  //   var excelDoc;
  //   excelDoc.Excel.createExcel(assetsCaptured);

  //   Sheet sheetObject = excelDoc['Asset Records'];
  //   var cell = sheetObject.cell(CellIndex.indexByString("A1"));
  //   cell.value = 7; // dynamic values support provided;
  //   CellStyle cellStyle = CellStyle(
  //       backgroundColorHex: "#1AFF1A",
  //       fontFamily: getFontFamily(FontFamily.Calibri));
  //   cell.cellStyle = cellStyle;
  // }

  // search query to fetch specific asset by Serial number
  setSearchQuery(String serialNo) {
    List<String> assetSearchList = [];
    String searchResult = "";
    for (int i = 0; i < serialNo.length; i++) {
      searchResult = searchResult + serialNo[i];
      assetSearchList.add(searchResult);
    }
    return assetSearchList;
  }

  generateAssetCapturedReportToPdf() {
    return StreamBuilder(
      stream: assetsCaptured.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return DataTable(
            showCheckboxColumn: false,
            columns: [
              DataColumn(
                  label: Text('Barcode', style: TextStyle(fontSize: 10))),
              DataColumn(
                  label: Text('Manufacturer', style: TextStyle(fontSize: 10))),
              DataColumn(
                  label: Text('SerialNo', style: TextStyle(fontSize: 10))),
              DataColumn(label: Text('Model', style: TextStyle(fontSize: 10))),
              DataColumn(label: Text('Type', style: TextStyle(fontSize: 10))),
              DataColumn(
                  label: Text('Condition', style: TextStyle(fontSize: 10))),
            ],
            rows: snapshot.data!.docs
                .map(
                  (e) => DataRow(cells: [
                    DataCell(Text(e['barcode'].toString(),
                        style: TextStyle(fontSize: 10))),
                    DataCell(Text(e['manufacturer'],
                        style: TextStyle(fontSize: 10))),
                    DataCell(
                        Text(e['serialNo'], style: TextStyle(fontSize: 10))),
                    DataCell(Text(e['model'], style: TextStyle(fontSize: 10))),
                    DataCell(Text(e['type'], style: TextStyle(fontSize: 10))),
                    DataCell(
                        Text(e['condition'], style: TextStyle(fontSize: 10)))
                  ], onSelectChanged: (value) {}),
                )
                .toList(),
          );
        } else {
          return Center(
            child: new CircularProgressIndicator(color: Colors.red[600]),
          );
        }
      },
    );
  }
}
