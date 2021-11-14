import 'package:asset_inventory/pages/asset/notifier/asset_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAssetInfo extends StatefulWidget {
  const ViewAssetInfo({Key? key}) : super(key: key);

  @override
  _ViewAssetInfoState createState() => _ViewAssetInfoState();
}

class _ViewAssetInfoState extends State<ViewAssetInfo> {
  @override
  Widget build(BuildContext context) {
    AssetNotifier assetNotifier = Provider.of<AssetNotifier>(context);

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Text(
            assetNotifier.currentAsset.barcode.toString(),
            style: TextStyle(fontSize: 30, fontFamily: 'times'),
          ),
          Divider(),
          Text(
            'assetSerialNo: ${assetNotifier.currentAsset.serialNo}',
            style: TextStyle(
                fontSize: 18, fontStyle: FontStyle.italic, fontFamily: 'times'),
          ),
          Divider(),
          Text(
            'manufacturer: ${assetNotifier.currentAsset.manufacturer}',
            style: TextStyle(
                fontSize: 18, fontStyle: FontStyle.italic, fontFamily: 'times'),
          ),
          Divider(),
          Text(
            'model: ${assetNotifier.currentAsset.model}',
            style: TextStyle(
                fontSize: 18, fontStyle: FontStyle.italic, fontFamily: 'times'),
          ),
          Divider(),
          Text(
            'type: ${assetNotifier.currentAsset.type}',
            style: TextStyle(
                fontSize: 18, fontStyle: FontStyle.italic, fontFamily: 'times'),
          ),
          Divider(),
          Text(
            'condition: ${assetNotifier.currentAsset.condition}',
            style: TextStyle(
                fontSize: 18, fontStyle: FontStyle.italic, fontFamily: 'times'),
          ),
          Divider(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
