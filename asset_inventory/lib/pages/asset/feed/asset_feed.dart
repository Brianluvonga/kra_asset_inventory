// import 'package:asset_inventory/api/ict_officer_api.dart';
import 'package:asset_inventory/models/asset_model.dart';
import 'package:asset_inventory/pages/asset/feed/asset_detail.dart';
import 'package:asset_inventory/pages/asset/forms/asset_capture_form.dart';
import 'package:asset_inventory/pages/asset/notifier/asset_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:asset_inventory/pages/asset/api/asset_api.dart';
import 'package:search_page/search_page.dart';

class AssetFeed extends StatefulWidget {
  @override
  _AssetFeedState createState() => _AssetFeedState();
}

class _AssetFeedState extends State<AssetFeed> {
  @override
  void initState() {
    AssetNotifier assetNotifier =
        Provider.of<AssetNotifier>(context, listen: false);
    getAssets(assetNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AssetNotifier assetNotifier = Provider.of<AssetNotifier>(context);

    Future<void> _refreshList() async {
      getAssets(assetNotifier);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Assets'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: SearchPage<Assetmodel>(
                items: assetNotifier as List<Assetmodel>,
                searchLabel: 'Search Asset',
                // suggestion: Center(
                //   child: Text('Filter people by name, surname or age'),
                // ),
                failure: Center(
                  child: Text('No Asset Found'),
                ),
                filter: (assetNotifier) => [
                  assetNotifier.barcode,
                ],
                builder: (assetNotifier) => ListTile(
                  title: Text(assetNotifier.barcode!),
                ),
              ),
            ),
          ),
        ],
      ),
      body: new RefreshIndicator(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(assetNotifier.assetList[index].barcode.toString()),
              subtitle: Text(assetNotifier.assetList[index].model.toString()),
              leading: Text(assetNotifier.assetList[index].type.toString()),
              trailing:
                  Text(assetNotifier.assetList[index].manufacturer.toString()),
              onTap: () {
                assetNotifier.currentAsset = assetNotifier.assetList[index];
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return AssetDetails();
                    },
                  ),
                );
              },
            );
          },
          itemCount: assetNotifier.assetList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.black,
            );
          },
        ),
        onRefresh: _refreshList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ignore: unnecessary_null_comparison
          assetNotifier.currentAsset == null;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return AssetEntryDetails(
                  isUpdating: false,
                );
              },
            ),
          );
        },
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red[600],
      ),
    );
  }
}
