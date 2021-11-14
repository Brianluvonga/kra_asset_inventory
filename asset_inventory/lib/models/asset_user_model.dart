// import 'package:cloud_firestore/cloud_firestore.dart';

class AssetUser {
  String? userPIN;
  String? department;
  String? station;
  String? floor;

  AssetUser();

  AssetUser.fromMap(Map<String, dynamic> userData) {
    userPIN = userData['userPIN'];
    department = userData['department'];
    station = userData['station'];
    floor = userData['floor'];
  }
  Map<String, dynamic> toMap() {
    return {
      'userPIN': userPIN,
      'department': department,
      'station': station,
      'floor': floor,
    };
  }
}
