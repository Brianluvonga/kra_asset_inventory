import 'package:asset_inventory/pages/asset/deployment/api/deployment_api.dart';
import 'package:asset_inventory/pages/asset/deployment/deployment_model.dart';
import 'package:asset_inventory/pages/asset/deployment/notifier/deploy_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeploymentDetails2 extends StatelessWidget {
  const DeploymentDetails2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeploymentNotifier deploymentNotifier =
        Provider.of<DeploymentNotifier>(context);

    _onDeploymentDetailsDeleted(DeploymentModel deployment) {
      Navigator.pop(context);
      deploymentNotifier.deleteDeploymentDetails(deployment);
    }

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red[600],
        centerTitle: true,
        title: Text(
          deploymentNotifier.currentDeployment.barcode.toString(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Image.network(
                  deploymentNotifier.currentDeployment.deployedFormImage != null
                      ? deploymentNotifier.currentDeployment.deployedFormImage!
                      : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.fitWidth,
                ),
                Divider(),
                Text(
                  'User Department: ${deploymentNotifier.currentDeployment.department.toString()}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Divider(),
                Text(
                  'User Floor: ${deploymentNotifier.currentDeployment.floor.toString()}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Divider(),
                Text(
                  'User Station: ${deploymentNotifier.currentDeployment.station.toString()}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Divider(),
                Text(
                  'UserPin: ${deploymentNotifier.currentDeployment.userPIN.toString()}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Divider(),
                Text(
                  ' Deployed By: ${deploymentNotifier.currentDeployment.ictOfficerName}'
                      .toString(),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Divider(),
                Text(
                  'Date Deployed: ${deploymentNotifier.currentDeployment.createdAt!.toDate().toString().trim()}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
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
          // FloatingActionButton(
          //   heroTag: "Edit",
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(builder: (BuildContext context) {
          //         return AssetEntryDetails(
          //           isUpdating: true,
          //         );
          //       }),
          //     );
          //   },
          //   child: Icon(Icons.edit),
          //   foregroundColor: Colors.white,
          // ),
          SizedBox(height: 20),
          FloatingActionButton(
            heroTag: "Delete",
            onPressed: () => deleteDeploymentDetails(
                deploymentNotifier.currentDeployment,
                _onDeploymentDetailsDeleted),
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
