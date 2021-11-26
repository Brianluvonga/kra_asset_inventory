import 'package:asset_inventory/pages/asset/deployment/api/deployment_api.dart';
import 'package:asset_inventory/pages/asset/deployment/feed/deployment2.dart';
import 'package:asset_inventory/pages/asset/deployment/notifier/deploy_notifier.dart';
import 'package:asset_inventory/pages/asset/forms/asset_deployment_form.dart';
import 'package:asset_inventory/pages/asset/records/deployed_details/check_deployment_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeploymentFeed extends StatefulWidget {
  @override
  _DeploymentFeedState createState() => _DeploymentFeedState();
}

class _DeploymentFeedState extends State<DeploymentFeed> {
  @override
  void initState() {
    DeploymentNotifier deploymentNotifier =
        Provider.of<DeploymentNotifier>(context, listen: false);
    getDeploymentDetails(deploymentNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DeploymentNotifier deploymentNotifier =
        Provider.of<DeploymentNotifier>(context);

    Future<void> _refreshList() async {
      getDeploymentDetails(deploymentNotifier);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Deployment Details'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      endDrawer: new Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    'Asset Deployment Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                )),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.red[600]),
              title: Text('Fetch Barcode Details'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => CheckDeploymentDetails(),
                  ),
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
      body: new RefreshIndicator(
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                deploymentNotifier.deploymentList[index].barcode.toString(),
              ),
              subtitle: Text(deploymentNotifier.deploymentList[index].createdAt!
                  .toDate()
                  .toString()
                  .trim()),
              leading: Text(
                  deploymentNotifier.deploymentList[index].userPIN.toString()),
              trailing: Image.network(
                  deploymentNotifier.deploymentList[index].deployedFormImage !=
                          null
                      ? deploymentNotifier
                          .deploymentList[index].deployedFormImage!
                          .toString()
                      : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                  width: 120,
                  fit: BoxFit.fitWidth),
              onTap: () {
                deploymentNotifier.currentDeployment =
                    deploymentNotifier.deploymentList[index];
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return DeploymentDetails2();
                    },
                  ),
                );
              },
            );
          },
          itemCount: deploymentNotifier.deploymentList.length,
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
          deploymentNotifier.currentDeployment == null;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return AssetDeploymentForm(
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
