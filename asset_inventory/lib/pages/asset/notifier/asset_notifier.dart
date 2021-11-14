import 'dart:collection';

import 'package:asset_inventory/models/asset_model.dart';
import 'package:flutter/material.dart';

class AssetNotifier with ChangeNotifier {
  List<Assetmodel> _assetList = [];
  late Assetmodel _currentAsset = Assetmodel();

  UnmodifiableListView<Assetmodel> get assetList =>
      UnmodifiableListView(_assetList);

  Assetmodel get currentAsset => _currentAsset;

  set assetList(List<Assetmodel> assetList) {
    _assetList = assetList;
    notifyListeners();
  }

  set currentAsset(Assetmodel asset) {
    _currentAsset = asset;
    notifyListeners();
  }

  addAsset(Assetmodel asset) {
    _assetList.insert(0, asset);
    notifyListeners();
  }

  deleteAsset(Assetmodel asset) {
    _assetList.removeWhere((_asset) => _asset.model == asset.model);
    notifyListeners();
  }
}
