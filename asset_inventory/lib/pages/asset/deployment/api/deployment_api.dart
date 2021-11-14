import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:asset_inventory/pages/asset/deployment/deployment_model.dart';
import 'package:asset_inventory/pages/asset/deployment/notifier/deploy_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

uploadDeploymentDetails(
    DeploymentModel deployment, bool isUpdating, deploymentUploaded) async {
  _uploadDeploymentDetails(deployment, isUpdating, deploymentUploaded);
} //push details to firestore

CollectionReference deploymentReference =
    FirebaseFirestore.instance.collection('Deployment');

CollectionReference assetReference =
    FirebaseFirestore.instance.collection('Deployment');

getDeploymentDetails(DeploymentNotifier deploymentNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Deployment')
      .orderBy("createdAt", descending: true)
      .get();

  List<DeploymentModel> _deploymentList = [];

  snapshot.docs.forEach((document) {
    DeploymentModel deployment =
        DeploymentModel.fromMap(document.data() as Map<String, dynamic>);
    _deploymentList.add(deployment);
  });

  deploymentNotifier.deploymentList = _deploymentList;
}

uploadDeploymentDetailsWithImage(DeploymentModel deployment, bool isUpdating,
    File localFileImage, Function deploymentUploaded) async {
  // ignore: unnecessary_null_comparison
  if (localFileImage != null) {
    print("uploading Deployment Image Form");
    var imageUpload = path.extension(localFileImage.path);
    print(imageUpload);
    var uuid = Uuid().v4();

    final Reference imageDeployed =
        FirebaseStorage.instance.ref().child('DeployedForms/$uuid$imageUpload');
    await imageDeployed.putFile(localFileImage).catchError((onError) {
      print(onError);
      return false;
    });
    String? url = await imageDeployed.getDownloadURL();
    print('Download Url is: $url');
    _uploadDeploymentDetails(deployment, isUpdating, deploymentUploaded,
        imgUrl: url);
  } else {
    print('...skipping uploading Deployment Image Form');
    _uploadDeploymentDetails(deployment, isUpdating, deploymentUploaded);
  }
  ;
}

_uploadDeploymentDetails(
    DeploymentModel deployment, bool isUpdating, Function deploymentUploaded,
    {String? imgUrl}) async {
  if (imgUrl != null) {
    deployment.deployedFormImage = imgUrl;
  }
  if (isUpdating) {
    deployment.updatedAt = Timestamp.now();
    await deploymentReference
        .doc(deployment.barcode)
        .update(deployment.toMap());
    deploymentUploaded(deployment);
  } else {
    FirebaseFirestore.instance
        .collection('Deployment')
        .where('barcode', isEqualTo: deployment.barcode)
        .get()
        .then(
      (value) async {
        if (value.docs.isNotEmpty) {
          return "Asset Already Deployed";
        } else {
          deployment.createdAt = Timestamp.now();
          DocumentReference docRef =
              await deploymentReference.add(deployment.toMap());
          deployment.id = docRef.id;
          await docRef.set(deployment.toMap());
          deploymentUploaded(deployment);
        }
      },
    );
  }
}

deleteDeploymentDetails(
    DeploymentModel deployment, Function deployedDetailsDeleted) async {
  if (deployment.deployedFormImage != null) {
    Reference imageReference = await FirebaseStorage.instance
        .refFromURL(deployment.deployedFormImage.toString());
    print(imageReference);
    await imageReference.delete();
    print('Image Deleted');
  }
  await FirebaseFirestore.instance
      .collection('Deployment')
      .doc(deployment.id)
      .delete();
  deployedDetailsDeleted(deployment);
}
