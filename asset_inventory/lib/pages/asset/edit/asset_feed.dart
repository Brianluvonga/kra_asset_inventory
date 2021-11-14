// // import 'package:autopay/api/user_api.dart';
// import 'package:asset_inventory/api/ict_officer_api.dart';
// import 'package:asset_inventory/pages/asset/deployment/deploy2.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ServiceFeed extends StatefulWidget {
//   @override
//   _ServiceFeedState createState() => _ServiceFeedState();
// }

// class _ServiceFeedState extends State<ServiceFeed> {
//   @override
//   void initState() {
//     AssetNotifier assetNotifier =
//         Provider.of<AssetNotifier>(context, listen: false);
//     getAssets(serviceNotifier);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
//     AssetNotifier serviceNotifier = Provider.of<AssetNotifier>(context);

//     // Future<void> _refreshList() async {
//     //   getServices(serviceNotifier);
//     // }

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.lightBlue[800],
//         title: Text(authNotifier.user != null
//             ? authNotifier.user!.displayName.toString()
//             : "Service"),
//         // actions: <Widget>[
//         //   // action button
//         //   // ignore: deprecated_member_use
//         //   FlatButton(
//         //     onPressed: () => signout(authNotifier),
//         //     child: Text(
//         //       "Logout",
//         //       style: TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //   ),
//         // ],
//       ),
//       body: new RefreshIndicator(
//         child: ListView.separated(
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               title: Text(serviceNotifier.serviceList[index].serviceName),
//               subtitle:
//                   Text(serviceNotifier.serviceList[index].serviceAccountNo),
//               onTap: () {
//                 serviceNotifier.currentService =
//                     serviceNotifier.serviceList[index];
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (BuildContext context) {
//                   return ServiceDetail();
//                 }));
//               },
//             );
//           },
//           itemCount: serviceNotifier.serviceList.length,
//           separatorBuilder: (BuildContext context, int index) {
//             return Divider(
//               color: Colors.black,
//             );
//           },
//         ),
//         onRefresh: _refreshList,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           serviceNotifier.currentService = null;
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (BuildContext context) {
//               return ServiceForm(
//                 isUpdating: false,
//               );
//             }),
//           );
//         },
//         child: Icon(Icons.add),
//         foregroundColor: Colors.white,
//         backgroundColor: Colors.lightBlue[800],
//       ),
//     );
//   }
// }
