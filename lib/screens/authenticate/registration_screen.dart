import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wifi_lock/navigation_screens/main_page.dart';
import 'package:wifi_lock/service/auth.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  final Function toggleView;

  RegistrationScreen({this.toggleView});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String email, password;
  bool showProgress = false;

  @override
  Widget build(BuildContext context) {
    print("im in registration screen");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            'wifi-lock',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: showProgress
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter an email' : null,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (val) => val.length < 6
                            ? 'Enter a password with 6+ char'
                            : null,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                        ),
                      ),
                      FlatButton(
                        color: Colors.grey,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          try {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                showProgress = true;
                              });
                            }
                            AuthResult newUser = await _authService
                                .registerWithEmailAndPassword(email, password);
                            if (newUser != null) {
                              setState(() {
                                showProgress = false;
                              });
                              Navigator.pushNamed(context, MainPage.id);
                            }
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                      ),
                      FlatButton(
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: Text('Login'),
                      )
                    ],
                  ),
                ),
              ));
  }
}
