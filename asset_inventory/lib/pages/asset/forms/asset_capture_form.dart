import 'package:asset_inventory/models/asset_model.dart';
import 'package:asset_inventory/pages/asset/api/asset_api.dart';
import 'package:asset_inventory/pages/asset/feed/asset_feed.dart';
import 'package:asset_inventory/pages/asset/notifier/asset_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

class AssetEntryDetails extends StatefulWidget {
  final bool isUpdating;
  const AssetEntryDetails({required this.isUpdating});

  @override
  _AssetEntryDetailsState createState() => _AssetEntryDetailsState();
}

class _AssetEntryDetailsState extends State<AssetEntryDetails> {
  TextEditingController barcodeController = TextEditingController();
  TextEditingController manufacturerController = TextEditingController();
  TextEditingController serialController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController assetTypeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController assetConditionController = TextEditingController();

  final CollectionReference addAssetToFirebase =
      FirebaseFirestore.instance.collection('Assets');

  Assetmodel _asset = Assetmodel();

  String _noresultAfterScan = ""; // barcode result after scan

  @override
  void dispose() {
    barcodeController.dispose();
    manufacturerController.dispose();
    serialController.dispose();
    modelController.dispose();
    assetTypeController.dispose();
    assetConditionController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    AssetNotifier assetNotifier =
        Provider.of<AssetNotifier>(context, listen: false);
    getAssets(assetNotifier);
    super.initState();
  }

  //
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
    });
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
          hintText: 'Barcode',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Scan Barcode',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      // initialValue: _asset.barcode,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.black,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _asset.barcode = value!;
      },
      controller: barcodeController,
      // initialValue: _currentAsset.barcode,
      onTap: () {
        scanBarcode();
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
  }

  Widget _manufacturerField() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          hintText: 'Manufacturer',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Name of Manufacturer',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      // initialValue: _asset.manufacturer,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.white,
      controller: manufacturerController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (String? value) {
        _asset.manufacturer = value!;
      },
    );
  }

  Widget _assetSerialNoField() {
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
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          hintText: 'Serial No',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Serial No',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      // initialValue: _asset.serialNo,
      controller: serialController,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.white,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (value) {
        _asset.serialNo = value!;
      },
    );
  }

  Widget _assetModelField() {
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
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          hintText: 'Model',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Model',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.white,
      controller: modelController,
      // initialValue: _asset.model,
      onSaved: (String? value) {
        _asset.model = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
    );
  }

  String? dropdownValue;

  Widget _assetTypeField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.black),
          hintText: "Select Type",
          labelStyle: TextStyle(color: Colors.black)),
      itemHeight: 50.0,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      // elevation: 16,
      onSaved: (String? value) {
        _asset.type = value!;
      },
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          assetTypeController.text = dropdownValue!;
        });
      },
      items: <String>[
        'Monitor',
        'VDI',
        'Laptop',
        'WiFi Router',
        'Tablet',
        'Printer',
        'Projector',
        'CPU',
        'IP Phone',
        'Switch',
      ].map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ),
          );
        },
      ).toList(),
    );
  }

  // asset condition widget
  String? assetConditionValue;

  Widget assetCondition() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.black),
          hintText: "Asset Condition",
          labelStyle: TextStyle(color: Colors.black)),
      itemHeight: 50.0,
      value: assetConditionValue,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'times'),
      // elevation: 16,
      onSaved: (String? value) {
        _asset.condition = value!;
      },
      onChanged: (String? newValue) {
        setState(() {
          assetConditionValue = newValue!;
          assetConditionController.text = assetConditionValue!;
        });
      },
      items: <String>[
        'In Use',
        'Faulty',
        'Obsolete',
      ].map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ),
          );
        },
      ).toList(),
    );
  }

  final CollectionReference duplicates =
      FirebaseFirestore.instance.collection('Assets');

  _onAssetUploaded(Assetmodel asset) {
    AssetNotifier assetNotifier =
        Provider.of<AssetNotifier>(context, listen: false);
    assetNotifier.addAsset(asset);
    Navigator.pop(context);
  }

  Future<void> _saveAsset() async {
    print('Save Asset Initialized');
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _formKey.currentState!.save();
      uploadAsset(_asset, widget.isUpdating, _onAssetUploaded);
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(seconds: 5),
      //     backgroundColor: Colors.red[600],
      //     content: Text("Asset Added Successfully", style: TextStyle()),
      //   ),
      // );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return AssetFeed();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Asset Entry Details"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Form(
          // ignore: deprecated_member_use
          autovalidate: true,
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 16),
                  Text(
                    widget.isUpdating ? "Edit Asset" : "",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 20),
                  _barcodeField(),
                  SizedBox(height: 10),
                  _manufacturerField(),
                  SizedBox(height: 10),
                  _assetSerialNoField(),
                  SizedBox(height: 10),
                  _assetModelField(),
                  SizedBox(height: 10),
                  _assetTypeField(),
                  SizedBox(height: 10),
                  assetCondition(),
                  SizedBox(height: 36),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.red[600],
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                      minWidth: 200,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _saveAsset();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return AssetFeed();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
