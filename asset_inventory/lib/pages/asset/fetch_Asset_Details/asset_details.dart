// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CheckAssetEntryDetails extends StatefulWidget {
  const CheckAssetEntryDetails({Key? key}) : super(key: key);

  @override
  _CheckAssetEntryDetailsState createState() => _CheckAssetEntryDetailsState();
}

class _CheckAssetEntryDetailsState extends State<CheckAssetEntryDetails> {
  TextEditingController barcodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Asset Entry Details'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Container(
        child: Center(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Card(
                  elevation: 20,
                  child: Container(
                      height: 150,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: _barcodeField(),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _barcodeField() {
    return Container(
        width: 250,
        child: TextFormField(
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: Colors.black),
              ),
              suffixIcon: Icon(
                Icons.photo_camera,
                color: Colors.black,
              ),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              filled: true,
              hintText: 'Scan Asset Barcode',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              labelStyle: TextStyle(color: Colors.white)),
          keyboardType: TextInputType.name,
          style:
              TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
          cursorColor: Colors.white,
          validator: (String? value) {
            if (value!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
          controller: barcodeController,
          onTap: () {
            scanBarcode();
            FocusScope.of(context).requestFocus(new FocusNode());
          },
        ));
  }

// barcoode to fetch details after scan
  Future<void> scanBarcode() async {
    String scannedBarcodeResult;
    try {
      scannedBarcodeResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(scannedBarcodeResult);
    } on PlatformException {
      scannedBarcodeResult = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      var codeScanned = scannedBarcodeResult;
      barcodeController.text = codeScanned;
      var result = _showBarcodeDialogDetails(codeScanned);
      if (result.length >= 1) {
        barcodeDetails();
        barcodeController.text = codeScanned;
      } else {}
      _showNoBarcodeDialog();
    });
  }

  _showBarcodeDialogDetails(String barcode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
            overflow: Overflow.visible,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 200,
                child: AlertDialog(
                  title: Text("Barcode Details", textAlign: TextAlign.center),
                  insetPadding: EdgeInsets.symmetric(horizontal: 100),
                  content: Container(
                    child: barcodeDetails(),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child:
                          Text('Ok', style: TextStyle(color: Colors.red[600])),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              )
            ]);
      },
    );
  }

  void _showNoBarcodeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("This Asset Has Not Been Recorded"),
          actions: <Widget>[
            ElevatedButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget barcodeDetails() {
    return Container(
      child: StreamBuilder(
        stream: checkBarcode(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return DataTable(
              columnSpacing: 10,
              columns: [
                DataColumn(label: Text('Manu', style: TextStyle(fontSize: 8))),
                DataColumn(
                    label: Text('SerialNo', style: TextStyle(fontSize: 8))),
                DataColumn(label: Text('Model', style: TextStyle(fontSize: 8))),
              ],
              rows: snapshot.data!.docs
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(Text(e['manufacturer'],
                            style: TextStyle(fontSize: 8))),
                        DataCell(
                            Text(e['serialNo'], style: TextStyle(fontSize: 8))),
                        DataCell(
                            Text(e['model'], style: TextStyle(fontSize: 8))),
                      ],
                    ),
                  )
                  .toList(),
            );
          } else {
            return Text('Not Recorded');
          }
        },
      ),
    );
  }

  Stream<QuerySnapshot<Object?>> checkBarcode() {
    return FirebaseFirestore.instance
        .collection('Assets')
        .where('barcode', isEqualTo: barcodeController.text)
        .snapshots();
  }

//query deployment database to fetch details of asset being used
  CollectionReference assetsCaptured =
      FirebaseFirestore.instance.collection('Asset');
}
