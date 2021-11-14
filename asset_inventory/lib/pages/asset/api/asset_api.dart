import 'package:asset_inventory/models/asset_model.dart';

import 'package:asset_inventory/pages/asset/notifier/asset_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

uploadAsset(Assetmodel asset, bool isUpdating, onAssetUploaded) async {
  _uploadAsset(asset, isUpdating, onAssetUploaded);
}

CollectionReference assetReference =
    FirebaseFirestore.instance.collection('Assets');

getAssets(AssetNotifier assetNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Assets')
      .orderBy("createdAt", descending: true)
      .get();

  List<Assetmodel> _assetList = [];

  snapshot.docs.forEach((document) {
    Assetmodel asset =
        Assetmodel.fromMap(document.data() as Map<String, dynamic>);
    _assetList.add(asset);
  });

  assetNotifier.assetList = _assetList;
}

//check barcode in asset List

Assetmodel? checkBarcodeInList(AssetNotifier assetNotifier, String? barcode) {
  getAssets(assetNotifier);
  List<Assetmodel> ass = _assets!;
  for (var as in ass) {
    if (as.barcode == barcode) {}
  }
  return null;
}

List<Assetmodel>? _assets = [];



String check(AssetNotifier assetNotifier, String barcode) {
  getAssets(assetNotifier);

  String type = "";

  List<Assetmodel>? asses = _assets;
  for (var as in asses!) {
    if (as.barcode == barcode) {
      type = as.type!;
    }
  }
  if (type == "") {
    return "No Record With This Barcode Found";
  }
  return type;
}

_uploadAsset(Assetmodel asset, bool isUpdating, Function assetUploaded) async {
  if (isUpdating) {
    asset.updatedAt = Timestamp.now();
    await assetReference.doc(asset.id).update(asset.toMap());
    assetUploaded(asset);
  } else {
    FirebaseFirestore.instance
        .collection('Assets')
        .where('barcode', isEqualTo: asset.barcode)
        .get()
        .then(
      (value) async {
        if (value.docs.isNotEmpty) {
          return "Asset Already Exists";
        } else {
          asset.createdAt = Timestamp.now();
          DocumentReference docRef = await assetReference.add(asset.toMap());
          asset.id = docRef.id;
          await docRef.set(asset.toMap());
          assetUploaded(asset);
        }
      },
    );
  }
}

deleteAsset(Assetmodel asset, Function assetDeleted) async {
  await FirebaseFirestore.instance.collection('Assets').doc(asset.id).delete();
  assetDeleted(asset);
}

surrenderAsset(Assetmodel asset, Function assetSurrendered) async {
  await FirebaseFirestore.instance
      .collection('Deployment')
      .doc(asset.id)
      .delete();
  assetSurrendered(asset);
}
