import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchController extends ChangeNotifier {
  Future retrieveData(String collection) async {
    final FirebaseFirestore dataFromFirestore = FirebaseFirestore.instance;
    QuerySnapshot snap = await dataFromFirestore.collection('Assets').get();
    return snap.docs;
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('Assets')
        .where('barcode', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
