import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wifi_lock/models/user.dart';
import 'package:wifi_lock/service/auth.dart';

class MainPage extends StatefulWidget {
  static String id = 'main_page';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthService _auth = AuthService();
  // final FirebaseUser user = _auth.user;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'wifi-lock',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text('hi, your user id is ${user.uid}'),
              FlatButton(
                child: Text('Open'),
                onPressed: () {},
              ),
              FlatButton(
                child: Text('Close'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
