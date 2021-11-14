import 'package:asset_inventory/models/asset_model.dart';
import 'package:asset_inventory/pages/asset/api/asset_api.dart';
import 'package:asset_inventory/pages/asset/forms/asset_capture_form.dart';
import 'package:asset_inventory/pages/asset/notifier/asset_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssetDetails extends StatelessWidget {
  const AssetDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetNotifier assetNotifier = Provider.of<AssetNotifier>(context);

    _onAssetDeleted(Assetmodel asset) {
      Navigator.pop(context);
      assetNotifier.deleteAsset(asset);
    }

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red[600],
        centerTitle: true,
        title: Text(
          assetNotifier.currentAsset.barcode.toString(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                DataTable(
                  columns: [
                    DataColumn(
                        label: Text('Barcode', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('Manufacturer',
                            style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label:
                            Text('SerialNo', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('Model', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('Type', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label:
                            Text('Condition', style: TextStyle(fontSize: 10))),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text(
                            assetNotifier.currentAsset.barcode.toString(),
                            style: TextStyle(fontSize: 10))),
                        DataCell(Text(
                            assetNotifier.currentAsset.manufacturer.toString(),
                            style: TextStyle(fontSize: 10))),
                        DataCell(Text(
                            assetNotifier.currentAsset.serialNo.toString(),
                            style: TextStyle(fontSize: 10))),
                        DataCell(Text(
                            assetNotifier.currentAsset.model.toString(),
                            style: TextStyle(fontSize: 10))),
                        DataCell(Text(
                            assetNotifier.currentAsset.type.toString(),
                            style: TextStyle(fontSize: 10))),
                        DataCell(Text(
                            assetNotifier.currentAsset.condition.toString(),
                            style: TextStyle(fontSize: 10)))
                      ],
                    ),
                  ],
                ),
                Divider(),
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
            heroTag: "Edit",
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
            heroTag: "Delete",
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
