import 'package:asset_inventory/models/asset_model.dart';
import 'package:asset_inventory/models/ictOficer_model.dart';
import 'package:flutter/material.dart';

//one is able to key in details as soon as a certain is returned to the office for record keeping
class AssetSurrenderForm extends StatefulWidget {
  const AssetSurrenderForm({Key? key}) : super(key: key);

  @override
  _AssetSurrenderFormState createState() => _AssetSurrenderFormState();
}

class _AssetSurrenderFormState extends State<AssetSurrenderForm> {
  late Assetmodel _asset;
  late IctOfficer _officer;

//
  //
  _submitForm() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red[600],
        centerTitle: true,
        title: Text("Asset Surrender Form"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Form(
          // ignore: deprecated_member_use
          autovalidate: true,
          // key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  _ictOfficerReceivingAssetField(),
                  SizedBox(height: 10),
                  _userPIN(),
                  SizedBox(height: 36),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.red[600],
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                      minWidth: 200,
                      onPressed: () => _submitForm(),
                      child: Text(
                        'Receive',
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

  Widget _ictOfficerReceivingAssetField() {
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
            Icons.person_add,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          hintText: 'Name Of ICT Officer',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'ICT Officer Name',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.black,
    );
  }

  Widget _userPIN() {
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
            Icons.person_add,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          hintText: 'Staff PIN',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Staff PIN',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.black,
    );
  }
}
