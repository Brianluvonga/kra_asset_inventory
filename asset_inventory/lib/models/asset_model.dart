import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: import_of_legacy_library_into_null_safe
class Assetmodel {
  String? id;
  String? barcode;
  String? manufacturer;
  String? serialNo;
  String? model;
  String? type;
  String? condition;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  Assetmodel();

  // Assetmodel.fromMap(Map<String, dynamic> assetData) {
  //   barcode
  // }

  Assetmodel.fromMap(Map<String, dynamic> assetData) {
    id = assetData['id'];
    barcode = assetData['barcode'];
    manufacturer = assetData['manufacturer'];
    serialNo = assetData['serialNo'];
    createdAt = assetData['createdAt'];
    model = assetData['model'];
    type = assetData['type'];
    condition = assetData['condition'];
    updatedAt = assetData['updatedAt'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'manufacturer': manufacturer,
      'serialNo': serialNo,
      'model': model,
      'type': type,
      'condition': condition,
      'createdAt': createdAt!.toDate(),
      'updatedAt': updatedAt
    };
  }
}
