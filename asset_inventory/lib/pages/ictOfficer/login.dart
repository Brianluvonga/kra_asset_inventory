import 'package:asset_inventory/api/ict_officer_api.dart';
import 'package:asset_inventory/models/ictOficer_model.dart';
import 'package:asset_inventory/pages/ictOfficer/notifier/ictOfficer_notifier.dart';
import 'package:asset_inventory/pages/navigation/Navigation.dart';
import 'package:asset_inventory/pages/ictOfficer/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IctOfficer _officer = IctOfficer();
  late String error = '';
  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  //
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);

    // _auth.userChanges().listen((User? user) => setState(() => user = user));
    super.initState();
  }

  void _submitLoginForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    try {
      login(_officer, authNotifier);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red[600],
          content: Text("Login Successful", style: TextStyle()),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigation(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
              "Login Not Successful, invalid credentials or poor internet connection"),
        ),
      );
    }
  }

  Future<void> _loginUserEmailAndPassword() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text))
          .user;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red[600],
          content: Text("Login Successful", style: TextStyle()),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigation(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(
              "Login Not Successful, invalid credentials or poor internet connection"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          "Login",
          style: TextStyle(fontFamily: 'times'),
        ),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      endDrawer: new Drawer(),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Form(
          // ignore: deprecated_member_use
          autovalidate: true,
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  ictOfficerEmailAddress(),
                  SizedBox(height: 10),
                  password(),
                  SizedBox(height: 10),
                  SizedBox(height: 16),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.red[600],
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                      minWidth: 200,
                      onPressed: () async {
                        _formKey.currentState!.save();
                        await _loginUserEmailAndPassword();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  notAccomplished(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ictOfficerEmailAddress() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          suffixIcon: Icon(
            Icons.email,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'ICT Officer Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.black,
      controller: _emailController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Ict Officer email Required';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: (String? value) => _officer.email = value!,
    );
  }

  Widget password() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            borderSide: BorderSide(width: 1, color: Colors.black),
          ),
          suffixIcon: Icon(
            Icons.lock_open,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.black,
      controller: _passwordController,
      obscureText: true,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 5 || value.length > 20) {
          return 'Password must be betweem 5 and 20 characters';
        }

        return null;
      },
    );
  }

  Widget notAccomplished() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Register()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: 'times'),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Colors.red[600],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'times'),
            ),
          ],
        ),
      ),
    );
  }
}
