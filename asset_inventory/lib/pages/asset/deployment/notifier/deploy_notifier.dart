import 'dart:collection';

import 'package:asset_inventory/pages/asset/deployment/deployment_model.dart';
import 'package:flutter/material.dart';

class DeploymentNotifier with ChangeNotifier {
  List<DeploymentModel> _deploymentList = [];

  DeploymentModel _currentDeployment = DeploymentModel();

  UnmodifiableListView<DeploymentModel> get deploymentList =>
      UnmodifiableListView(_deploymentList);

  DeploymentModel get currentDeployment => _currentDeployment;

  set deploymentList(List<DeploymentModel> deploymentList) {
    _deploymentList = deploymentList;
    notifyListeners();
  }

  set currentDeployment(DeploymentModel deployment) {
    _currentDeployment = deployment;
    notifyListeners();
  }

  addDeploymentDetails(DeploymentModel deployment) {
    _deploymentList.insert(0, deployment);
    notifyListeners();
  }

  deleteDeploymentDetails(DeploymentModel deployment) {
    _deploymentList.removeWhere(
        (_deployment) => _deployment.barcode == deployment.barcode);

    notifyListeners();
  }
}
