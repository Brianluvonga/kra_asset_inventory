import 'package:asset_inventory/api/ict_officer_api.dart';
import 'package:asset_inventory/models/ictOficer_model.dart';
import 'package:asset_inventory/pages/ictOfficer/login.dart';
import 'package:asset_inventory/pages/ictOfficer/notifier/ictOfficer_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IctOfficer _officer = IctOfficer();

  final _usernameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _emailController = TextEditingController();

  late bool _isRegistering = false;

  Future<void> ictofficerregister(_officer) async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;
    if (user != null) {
      setState(
        () {
          _isRegistering = true;
        },
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } else {
      _isRegistering = false;
    }
  }

  // void submitRegistration() {
  //   if (!_formKey.currentState!.validate()) {
  //     return;
  //   }
  //   _formKey.currentState!.save();

  //   AuthNotifier authNotifier2 =
  //       Provider.of<AuthNotifier>(context, listen: false);

  //   signup(_officer, authNotifier2);
  // }

  FirebaseAuth _auth = FirebaseAuth.instance; // create instance of firebase

  //
  @override
  void dispose() {
    AuthNotifier authNotifier2 =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier2);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          centerTitle: true,
          backgroundColor: Colors.red[600],
        ),
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
                    ictOfficerIDNO(),
                    SizedBox(height: 10),
                    ictOfficerName(),
                    SizedBox(height: 10),
                    ictOfficerEmailAddress(),
                    SizedBox(height: 10),
                    password(),
                    SizedBox(height: 10),
                    confirmPassword(),
                    SizedBox(height: 32),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.red[600],
                      child: MaterialButton(
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10),
                        minWidth: 200,
                        onPressed: () => ictofficerregister(_officer),
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(_isRegistering == false
                          ? ''
                          : (_isRegistering
                              ? 'User Successfully registered '
                              : 'Registration Denied')),
                    ),
                    notAccomplished()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ictOfficerIDNO() {
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
            Icons.pin,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: '25489**',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'ID Number',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.black,
      controller: _idNumberController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Username is required';
        }

        if (value.length < 4 || value.length > 10) {
          return 'Username must be betweem 5 and 20 characters';
        }

        return null;
      },
      onSaved: (String? value) => _officer.idNumber = value!,
    );
  }

  Widget ictOfficerName() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
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
            Icons.person,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'ICT Officer UserName',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Officer UserName',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.black,
      controller: _usernameController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Username is required';
        }

        if (value.length < 4 || value.length > 10) {
          return 'Username must be betweem 5 and 20 characters';
        }

        return null;
      },
      onSaved: (String? value) => _officer.displayName = value!,
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
          hintText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.black)),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.black,
      controller: _emailController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Email is required';
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
            Icons.lock,
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
      obscureText: true,
      controller: _passwordController,
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

  Widget confirmPassword() {
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
          suffixIcon: Icon(Icons.lock, color: Colors.black),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Confirm Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: 'Confirm Password',
          labelStyle: TextStyle(color: Colors.black)),
      obscureText: true,
      validator: (String? value) {
        if (_passwordController.text != value) {
          return 'Passwords do not match';
        }

        return null;
      },
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'times'),
      cursorColor: Colors.white,
    );
  }

  Widget notAccomplished() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
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
              'Login',
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
