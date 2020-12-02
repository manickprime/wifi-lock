import 'package:flutter/material.dart';
import 'package:wifi_lock/screens/authenticate/login_screen.dart';
import 'package:wifi_lock/screens/authenticate/registration_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = false;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("im here $showSignIn");
    if (showSignIn) {
      return LoginScreen(toggleView: toggleView);
    } else {
      print("going to registration screen");
      return RegistrationScreen(toggleView: toggleView);
    }
  }
}
