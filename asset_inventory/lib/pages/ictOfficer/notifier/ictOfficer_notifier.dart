import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthNotifier with ChangeNotifier {
  User? _ictOfficer;

  User? get ictOfficer => _ictOfficer;

  void setUser(User? ictOfficer) {
    _ictOfficer = ictOfficer!;
    notifyListeners();
  }
}
