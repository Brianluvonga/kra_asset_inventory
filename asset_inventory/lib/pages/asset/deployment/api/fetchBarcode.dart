// import 'package:asset_inventory/models/asset_model.dart';
// import 'package:asset_inventory/pages/asset/deployment/deployment_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class GetAssetDetails extends ChangeNotifier {
//   Future<DocumentSnapshot<Map<String, dynamic>>> assetsCaptured =
//       FirebaseFirestore.instance.collection('Assets').doc().get();

//   var doc = assetsCaptured.doc().get();

//   List<Assetmodel> _asset = [];
//   List<DeploymentModel> _deployment = [];

//   int? _selectedAssetIndex;

//   void addAssetFetchedToDeployment(Assetmodel? asset) {
//     _deployment.add(asset);
//   }

//   int? get selectedAssetIndex {
//     return _selectedAssetIndex;
//   }

//   Assetmodel? get selectedAsset {
//     if (selectedAssetIndex == null) {
//       return null;
//     }
//     return _asset[_selectedAssetIndex!];
//   }
// }
