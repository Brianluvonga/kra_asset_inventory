import 'dart:html';

class Deployment {
  File? deploymentForm;
  String? barcode;
  String? createdAt;
  String? userPIN;
  String? department;
  String? station;
  String? floor;
  String? ictOfficerName;

  Deployment();

  Map<String, dynamic> toMap() {
    return {
      'barcode': barcode,
      'createdAt': createdAt,
      'deploymentForm': deploymentForm,
      'userPIN': userPIN,
      'department': department,
      'station': station,
      'floor': floor,
    };
  }
}
