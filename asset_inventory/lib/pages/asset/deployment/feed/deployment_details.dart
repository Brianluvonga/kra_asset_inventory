import 'package:asset_inventory/pages/asset/deployment/api/deployment_api.dart';
import 'package:asset_inventory/pages/asset/deployment/deployment_model.dart';
import 'package:asset_inventory/pages/asset/deployment/notifier/deploy_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeploymentDetails extends StatelessWidget {
  const DeploymentDetails({Key? key}) : super(key: key);

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
                SizedBox(height: 50),
                DataTable(
                  columns: [
                    DataColumn(
                        label: Text('Barcode', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('UserPin', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label:
                            Text('Department', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('Station', style: TextStyle(fontSize: 10))),
                    DataColumn(
                        label: Text('Floor', style: TextStyle(fontSize: 10))),
                    DataColumn(
                      label: Text(
                        'DateDeployed',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    DataColumn(
                        label:
                            Text('DeployedBy', style: TextStyle(fontSize: 10))),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text(
                            deploymentNotifier.currentDeployment.barcode
                                .toString(),
                            style: TextStyle(fontSize: 8))),
                        DataCell(Text(
                            deploymentNotifier.currentDeployment.userPIN
                                .toString(),
                            style: TextStyle(fontSize: 8))),
                        DataCell(Text(
                            deploymentNotifier.currentDeployment.department
                                .toString(),
                            style: TextStyle(fontSize: 8))),
                        DataCell(Text(
                            deploymentNotifier.currentDeployment.station
                                .toString(),
                            style: TextStyle(fontSize: 8))),
                        DataCell(Text(
                            deploymentNotifier.currentDeployment.floor
                                .toString(),
                            style: TextStyle(fontSize: 8))),
                        DataCell(Text(
                            deploymentNotifier.currentDeployment.createdAt!
                                .toDate()
                                .toString(),
                            style: TextStyle(fontSize: 8))),
                        DataCell(Text(
                            deploymentNotifier.currentDeployment.ictOfficerName
                                .toString(),
                            style: TextStyle(fontSize: 8))),
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
