import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wifi_lock/navigation_screens/main_page.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  final Function toggleView;

  LoginScreen({this.toggleView});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email, password;
  final emailController = TextEditingController(),
      passController = TextEditingController();

  bool isLoggedIn = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _logIn() async {
    print('I\'m in');
    try {
      await _googleSignIn.signIn();
      setState(() {
        isLoggedIn = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _logOut() async {
    _googleSignIn.signOut();
    setState(() {
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Login Page',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
              controller: emailController,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter your password',
              ),
              controller: passController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () async {
                    print(email + " " + password);
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.pushNamed(context, MainPage.id);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.grey,
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      email = "";
                      password = "";
                      emailController.clear();
                      passController.clear();
                    });
                  },
                  child: Text('Clear'),
                )
              ],
            ),
            FlatButton(
              onPressed: () {
                widget.toggleView();
              },
              child: Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}
