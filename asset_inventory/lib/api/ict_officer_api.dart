import 'package:asset_inventory/models/ictOficer_model.dart';
import 'package:asset_inventory/pages/ictOfficer/login.dart';
import 'package:asset_inventory/pages/ictOfficer/notifier/ictOfficer_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';

signup(IctOfficer officer, AuthNotifier authNotifier) async {
  UserCredential? authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: officer.email!, password: officer.password!)
      // ignore: return_of_invalid_type_from_catch_error
      .catchError((error) => print(error.code));

  // ignore: unnecessary_null_comparison
  if (authResult != null) {
    await FirebaseAuth.instance.currentUser!
        .updateDisplayName(officer.displayName);

    User? ictOfficer = authResult.user;

    if (ictOfficer != null) {
      await ictOfficer.reload();

      print("Sign up: $ictOfficer");

      User currentUser = await FirebaseAuth.instance.currentUser!;
      authNotifier.setUser(currentUser);
    }
  }
}

login(IctOfficer officer, AuthNotifier authNotifier) async {
  UserCredential authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
          email: officer.email.toString(),
          password: officer.password.toString())
      // ignore: return_of_invalid_type_from_catch_error
      .catchError((error) => print(error.code));

  // ignore: unnecessary_null_comparison
  if (authResult != null) {
    User? firebaseUser = authResult.user;

    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }
}

initializeCurrentUser(AuthNotifier? authNotifier) async {
  User? ictOfficer = await FirebaseAuth.instance.currentUser;

  print(ictOfficer);
  authNotifier!.setUser(ictOfficer!);
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance.signOut().catchError(
        (error) => print(error.code),
      );

  return Login();
}
