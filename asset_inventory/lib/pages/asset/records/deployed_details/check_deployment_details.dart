import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CheckDeploymentDetails extends StatefulWidget {
  const CheckDeploymentDetails({Key? key}) : super(key: key);

  @override
  _CheckDeploymentDetailsState createState() => _CheckDeploymentDetailsState();
}

class _CheckDeploymentDetailsState extends State<CheckDeploymentDetails> {
  TextEditingController barcodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Asset Deployment Details'),
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
                _barcodeField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _barcodeField() {
    return TextFormField(
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelStyle: TextStyle(color: Colors.white)),
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
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
    );
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
        return AlertDialog(
          title: Text("Barcode Details", textAlign: TextAlign.center),
          content: (barcodeDetails()),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showNoBarcodeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("This Asset Has Not Been Deployed"),
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
              columns: [
                DataColumn(
                    label: Text('DateDeployed', style: TextStyle(fontSize: 8))),
                DataColumn(
                    label: Text('UserPin', style: TextStyle(fontSize: 8))),
                DataColumn(
                    label: Text('Department', style: TextStyle(fontSize: 8))),
                DataColumn(
                    label: Text('DeployedBy', style: TextStyle(fontSize: 8))),
              ],
              rows: snapshot.data!.docs
                  .map(
                    (e) => DataRow(
                      cells: [
                        DataCell(Text(e['createdAt'],
                            style: TextStyle(fontSize: 8))),
                        DataCell(
                            Text(e['userPIN'], style: TextStyle(fontSize: 8))),
                        DataCell(Text(e['department'],
                            style: TextStyle(fontSize: 8))),
                        DataCell(Text(e['displayName'],
                            style: TextStyle(fontSize: 8))),
                      ],
                    ),
                  )
                  .toList(),
            );
          } else {
            return Text('Not Deployed');
          }
        },
      ),
    );
  }

  Stream<QuerySnapshot<Object?>> checkBarcode() {
    return FirebaseFirestore.instance
        .collection('Deployment')
        .where('barcode', isEqualTo: barcodeController.text)
        .snapshots();
  }

//query deployment database to fetch details of asset being used
  CollectionReference assetsCaptured =
      FirebaseFirestore.instance.collection('Deployment');

  // Widget scanAssetDetails() {
  //   return Card(
  //     elevation: 8.0,
  //     shadowColor: Colors.black,
  //     child: Container(
  //       height: 100,
  //       width: 90,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(15.0),
  //       ),
  //       child: StreamBuilder<QuerySnapshot>(
  //         stream: countVDIs(),
  //         builder: (context, snapshot) {
  //           if (snapshot.hasData) {
  //             return Container(
  //               child: Center(
  //                 child: ListView(
  //                   children: <Widget>[
  //                     ListTile(
  //                       title: Text(
  //                         "Scan Asset",
  //                         textAlign: TextAlign.center,
  //                       ),
  //                       subtitle: Text(
  //                         snapshot.data!.size.toString(),
  //                         textAlign: TextAlign.center,
  //                         style:
  //                             TextStyle(color: Color(0xff2a0404), fontSize: 30),
  //                       ),
  //                       onTap: () {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                             builder: (BuildContext context) => ViewNoOfVDIs(),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           } else {
  //             return Center(
  //               child: CircularProgressIndicator(
  //                 color: Colors.red[600],
  //                 // value: 0,
  //               ),
  //             );
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }
}
