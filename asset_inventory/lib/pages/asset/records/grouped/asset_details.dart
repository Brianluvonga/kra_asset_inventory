import 'package:asset_inventory/models/asset_model.dart';
import 'package:asset_inventory/pages/asset/api/asset_api.dart';
import 'package:asset_inventory/pages/asset/forms/asset_capture_form.dart';
import 'package:asset_inventory/pages/asset/notifier/asset_notifier.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AssetDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetNotifier assetNotifier = Provider.of<AssetNotifier>(context);

    _onAssetDeleted(Assetmodel asset) {
      Navigator.pop(context);
      assetNotifier.deleteAsset(asset);
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(assetNotifier.currentAsset.barcode.toString()),
          centerTitle: true,
          backgroundColor: Colors.red[600]),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  assetNotifier.currentAsset.manufacturer.toString(),
                  style: TextStyle(fontSize: 28, fontFamily: 'times'),
                ),
                Text(
                  'assetModel: ${assetNotifier.currentAsset.model}',
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'times'),
                ),
                Text(
                  'assetSerialNo: ${assetNotifier.currentAsset.serialNo}',
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'times'),
                ),
                Text(
                  'assetType: ${assetNotifier.currentAsset.type}',
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'times'),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return AssetEntryDetails(
                    isUpdating: true,
                  );
                }),
              );
            },
            child: Icon(Icons.edit),
            foregroundColor: Colors.white,
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () =>
                deleteAsset(assetNotifier.currentAsset, _onAssetDeleted),
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
