import 'package:asset_inventory/pages/asset/deployment/notifier/deploy_notifier.dart';
import 'package:asset_inventory/pages/asset/notifier/asset_notifier.dart';
import 'package:asset_inventory/pages/ictOfficer/login.dart';
import 'package:asset_inventory/pages/ictOfficer/notifier/ictOfficer_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthNotifier()),
        ChangeNotifierProvider(create: (_) => AssetNotifier()),
        ChangeNotifierProvider(create: (_) => DeploymentNotifier()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Login()),
    );
  }
}
