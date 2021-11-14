import 'package:cloud_firestore/cloud_firestore.dart';

class DeploymentModel {
  String? id;
  String? barcode;
  String? deployedFormImage;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  String? userPIN;
  String? department;
  String? station;
  String? floor;
  String? ictOfficerName;

  DeploymentModel();

  DeploymentModel.fromMap(Map<String, dynamic> assetData) {
    id = assetData['id'];
    barcode = assetData['barcode'];
    deployedFormImage = assetData['deployedFormImage'];
    createdAt = assetData['createdAt'];
    updatedAt = assetData['updatedAt'];
    userPIN = assetData['userPIN'];
    department = assetData['department'];
    station = assetData['station'];
    floor = assetData['floor'];
    ictOfficerName = assetData['ictOfficerName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'deployedFormImage': deployedFormImage,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'userPIN': userPIN,
      'department': department,
      'station': station,
      'floor': floor,
      'ictOfficerName': ictOfficerName,
    };
  }
}
