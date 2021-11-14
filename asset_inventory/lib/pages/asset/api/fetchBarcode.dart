import 'package:asset_inventory/models/asset_model.dart';
import 'package:asset_inventory/models/asset_user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class getAssetDetails {
  Assetmodel asset = Assetmodel();
  List<Assetmodel> _asset = [];
  List<AssetUser> _user = [];

  final dbref = FirebaseDatabase.instance.reference();

  final CollectionReference barcodeFromAsset =
      FirebaseFirestore.instance.collection('Assets');

  void fetchAssetInfoFromFirestore() {
    final List<Assetmodel> fetchedAsset = [];
    dbref.child('Assets').once().then(
      (DataSnapshot snapshot) {
        var keys = snapshot.value.keys();
        var data = snapshot.value;
        for (var key in keys) {
          Assetmodel newAsset = Assetmodel();
          fetchedAsset.add(newAsset);
        }
        _asset = fetchedAsset;
      },
    );
  }

//checks if barcode matches database
  String checkBarcode(String barcode) {
    fetchAssetInfoFromFirestore();
    String name = "";
    List<Assetmodel> ass = _asset;
    for (var as in ass) {
      if (as.barcode == barcode) {
        name = name;
      }
    }
    if (name == "") {
      return "No Results Found";
    }
    return name;
  }

  getbarcode() async {
    await barcodeFromAsset.where('barcode', isEqualTo: asset.barcode);
    if (barcodeFromAsset == true) {
      return {
        TextFormField(initialValue: asset.barcode),
        TextFormField(initialValue: asset.condition),
        TextFormField(initialValue: asset.manufacturer),
        TextFormField(initialValue: asset.model),
        TextFormField(initialValue: asset.serialNo),
        TextFormField(initialValue: asset.type),
      };
    }
  }
}
