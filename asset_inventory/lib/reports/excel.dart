// import 'package:excel/excel.dart';
// import 'package:path/path.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// // var excelDocument = Excel.createExcel(); //create an excel sheet
// // Sheet sheetObject = excelDocument['Assets']; //sheet object

// // var cell = sheetObject.cell(CellIndex.indexByString('A1'));
// // cell.value = ;

// Future<void> createAssetInventoryExcelSheet() async {
//   var assetExcelSheet = FirebaseFirestore.instance.collection('Assets');
//   var querySnap = await assetExcelSheet.get();
//   for (var queryDocSnap in querySnap.docs) {
//     Map<String, dynamic> data = queryDocSnap.data as Map<String, dynamic>;
//     var barcode = data['barcode'];
//     var manufacturer = data['manufacturer'];
//     var serialNo = data['serialNo'];
//     var model = data['model'];
//     var type = data['type'];
//     var condition = data['condition'];
//     var createdAt = data['createdAt'];
//   }
//   final excelDocument = Excel.createExcel();
//   Sheet sheetObject = excelDocument['Assets']; //sheet object
// }
