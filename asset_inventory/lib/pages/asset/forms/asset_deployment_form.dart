import 'dart:io';
import 'package:asset_inventory/pages/asset/deployment/api/deployment_api.dart';
import 'package:asset_inventory/pages/asset/deployment/deployment_model.dart';
import 'package:asset_inventory/pages/asset/deployment/feed/deployment_feed.dart';
import 'package:asset_inventory/pages/asset/deployment/notifier/deploy_notifier.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AssetDeploymentForm extends StatefulWidget {
  final bool isUpdating;
  const AssetDeploymentForm({required this.isUpdating});

  @override
  _AssetDeploymentFormState createState() => _AssetDeploymentFormState();
}

class _AssetDeploymentFormState extends State<AssetDeploymentForm> {
  TextEditingController kraDepartmentsController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController ictOfficerNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController userPinController = TextEditingController();
  TextEditingController stationController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController imgController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static DeploymentModel _deployment = DeploymentModel();

  @override
  void initState() {
    super.initState();
    DeploymentNotifier deploymentNotifier =
        Provider.of<DeploymentNotifier>(context, listen: false);

    getDeploymentDetails(deploymentNotifier);

    // ignore: unnecessary_null_comparison
    if (deploymentNotifier.currentDeployment != null) {
      _deployment = deploymentNotifier.currentDeployment;
    } else {
      _deployment = DeploymentModel();
    }
    _deploymentImageFileUrl = _deployment.deployedFormImage;
  }

  //variable to check if barcode is captured

  //
  //
//method to capture deployment form

  // ignore: unused_field
  File? _deploymentImageFile;
  String? _deploymentImageFileUrl;

  FirebaseStorage deploymentFormStorage = FirebaseStorage.instance;
  final deploymentform = ImagePicker();
//capture image from camera
  void chooseImage() async {
    var deploymentImage =
        (await deploymentform.pickImage(source: ImageSource.camera));
    if (deploymentImage != null) {
      setState(
        () {
          _deploymentImageFile = File(deploymentImage.path);
          print('Image Selected Successfully');
        },
      );
    }
  }

  _showImage() {
    if (_deploymentImageFile == null && _deploymentImageFileUrl == null) {
      return Text("image placeholder");
      // ignore: unnecessary_null_comparison
    } else if (_deploymentImageFile == true) {
      // print('showing image from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(_deploymentImageFile as File),
          TextButton(
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => chooseImage(),
          )
        ],
      );
    } else if (_deploymentImageFileUrl == 0) {
      // print('showing image from url');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _deploymentImageFileUrl!,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            height: 250,
          ),
          TextButton(
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => chooseImage(),
          )
        ],
      );
    }
  }

  _onDeployedDetailsUploaded(DeploymentModel deployment) {
    DeploymentNotifier deploymentNotifier =
        Provider.of<DeploymentNotifier>(context, listen: false);
    deploymentNotifier.addDeploymentDetails(deployment);
    Navigator.pop(context);
  }

  Future<void> _deployDetails() async {
    print('Deployment Initialized');
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      _formKey.currentState!.save();
      print('Deployment Details Saved');
      uploadDeploymentDetailsWithImage(_deployment, widget.isUpdating,
          _deploymentImageFile!, _onDeployedDetailsUploaded);

      print("_imageFile ${_deploymentImageFile.toString()}");
      print("_imageUrl $_deploymentImageFileUrl");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red[600],
          content: Text("Asset Deployed Successfully", style: TextStyle()),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => DeploymentFeed(),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController datecontroller = TextEditingController();
  Future _staffDateOfIssue() async {
    DateTime dateOfIssue = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateOfIssue,
        firstDate: DateTime(2021),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Colors.black,
                surface: Colors.red,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: Colors.red[600],
            ),
            child: child!,
          );
        },
        lastDate: DateTime(2022));
    if (picked != null && picked != dateOfIssue)
      setState(() {
        dateOfIssue = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        datecontroller.text = date;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Colors.red[600],
        centerTitle: true,
        title: Text("Asset Deployment Form"),
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
                  // _showImage(),
                  SizedBox(height: 10),
                  // _deploymentImageFile == null &&
                  //         _deploymentImageFileUrl == null
                  //     ?
                  ButtonTheme(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () => chooseImage(),
                      child: Text(
                        'Add Deployment Image',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                  // :
                  ,
                  SizedBox(height: 0),
                  _barcodeField(),
                  // SizedBox(height: 10),
                  // _secondbarcodeField(),
                  SizedBox(height: 10),
                  _dateOfIssue(),
                  SizedBox(height: 10),
                  userPIN(),
                  SizedBox(height: 10),
                  depart(),
                  SizedBox(height: 10),
                  station(),
                  SizedBox(height: 10),
                  userFloor(),
                  SizedBox(height: 10),
                  _ictOfficerField(),
                  SizedBox(height: 10),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff2a0404),
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                      minWidth: 200,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _deployDetails();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => DeploymentFeed(),
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

  Widget _ictOfficerField() {
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
          suffixIcon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          hintText: 'Name Of ICT Officer Deploying Asset',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'ICT Officer',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.black,
      controller: ictOfficerNameController,
      onSaved: (String? value) {
        _deployment.ictOfficerName = value;
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
    );
  }

  Widget _dateOfIssue() {
    //department of user of the asset
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
            Icons.date_range,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Select Date Of Deployment',
          labelStyle: TextStyle(color: Colors.black)),
      controller: datecontroller,
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      onTap: () {
        _staffDateOfIssue();
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      onSaved: (String? value) {
        value = _deployment.createdAt.toString();
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
    );
  }

  CollectionReference deployRef =
      FirebaseFirestore.instance.collection('Deployment');

// department dropdown variable
  String? dropdownValue;

  Widget depart() {
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
        fillColor: Colors.white,
        filled: true,
        hintText: "Select User Department",
      ),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      iconSize: 20,
      elevation: 16,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue;
          kraDepartmentsController.text = dropdownValue!;
        });
      },
      onSaved: (String? value) {
        _deployment.department = value;
      },
      // validator: (String? value) {
      //   if (value!.isEmpty) {
      //     return "This field is required";
      //   }
      //   return null;
      // },
      items: <String>[
        'RC',
        'DTD',
        'Facilities & Logistics',
        'ICT',
        'Customs',
        'Finance',
        'Security',
        'SIRM',
        'Procurement',
        'HR',
        'Marketting',
        'Investigations',
        'I&SO',
        'Ushuru Sacco',
        'Legal Services'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  //user widgets

  Widget userPIN() {
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
          suffixIcon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          hintText: 'User Pin',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'User PIN',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.black,
      controller: userPinController,
      onSaved: (String? value) {
        _deployment.userPIN = value;
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
    );
  }

  TextEditingController userController = TextEditingController();

  // asset condition widget
  String? userStationDropdownValue;

  Widget station() {
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
        fillColor: Colors.white,

        // hintStyle: TextStyle(color: Colors.black),
        hintText: "Station",
      ),
      value: userStationDropdownValue,
      icon: const Icon(Icons.arrow_drop_down_outlined),
      iconSize: 20,
      elevation: 16,
      onChanged: (String? newValue) {
        setState(() {
          userStationDropdownValue = newValue!;
          stationController.text = userStationDropdownValue!;
        });
      },
      onSaved: (String? value) {
        _deployment.station = value;
      },
      // validator: (String? value) {
      //   if (value!.isEmpty) {
      //     return "This field is required";
      //   }
      //   return null;
      // },
      items: <String>[
        'Kiptagich',
        'Airport',
        'KPC',
        'Eldoret',
        'Kitale',
        'SUAM',
        'Baringo',
        'Kapsabet',
        'Loki',
        'Lodwar',
      ].map<DropdownMenuItem<String>>((String? value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value!),
        );
      }).toList(),
    );
  }

  // end of asset condition widget

  Widget userFloor() {
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
          suffixIcon: Icon(
            Icons.person,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          hintText: 'User Floor',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'User Floor',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.black,
      controller: floorController,
      onSaved: (String? value) {
        _deployment.floor = value;
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
    );
  }

  //check barcode in asset List

  //

  String? serialNo;
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
      }
      _showNoBarcodeDialog();
    });
  }

  // stream barcode details

  Stream<QuerySnapshot<Object?>> checkBarcode() {
    return FirebaseFirestore.instance
        .collection('Assets')
        .where('barcode', isEqualTo: barcodeController.text)
        .snapshots();
  }

  // static String? getbarcode;

  Widget barcodeDetails() {
    return Container(
      child: StreamBuilder(
        stream: checkBarcode(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return DataTable(
              columns: [
                DataColumn(
                    label: Text('Condition', style: TextStyle(fontSize: 8))),
                DataColumn(label: Text('Man', style: TextStyle(fontSize: 8))),
                DataColumn(
                    label: Text('SerialNo', style: TextStyle(fontSize: 8))),
                DataColumn(label: Text('Type', style: TextStyle(fontSize: 8))),
              ],
              rows: snapshot.data!.docs
                  .map((e) => DataRow(cells: [
                        DataCell(Text(e['condition'],
                            style: TextStyle(fontSize: 8))),
                        DataCell(Text(e['manufacturer'],
                            style: TextStyle(fontSize: 8))),
                        DataCell(
                            Text(e['serialNo'], style: TextStyle(fontSize: 8))),
                        DataCell(
                            Text(e['type'], style: TextStyle(fontSize: 8))),
                      ]))
                  .toList(),
            );
          } else {
            return Text('No Assets In Use Recorded');
          }
        },
      ),
    );
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
          content: Text("No Asset With This Barcode Present"),
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

//
//
// asset widgets
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
      onSaved: (String? value) {
        _deployment.barcode = value;
      },
      controller: barcodeController,
      onTap: () {
        scanBarcode();
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
  }

  // Widget _secondbarcodeField() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(32.0)),
  //           borderSide: BorderSide(width: 1, color: Colors.black),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(32.0)),
  //           borderSide: BorderSide(width: 1, color: Colors.black),
  //         ),
  //         suffixIcon: Icon(
  //           Icons.photo_camera,
  //           color: Colors.black,
  //         ),
  //         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
  //         filled: true,
  //         hintText: 'Scan Second Asset Barcode',
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
  //         labelStyle: TextStyle(color: Colors.white)),
  //     keyboardType: TextInputType.name,
  //     style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
  //     cursorColor: Colors.white,
  //     onSaved: (String? value) {
  //       _deployment.second_barcode = value;
  //     },
  //     controller: barcodeController,
  //     onTap: () {
  //       scanBarcode();
  //       FocusScope.of(context).requestFocus(new FocusNode());
  //     },
  //   );
  // }
}
