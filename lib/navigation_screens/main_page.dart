import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wifi_lock/models/user.dart';
import 'package:wifi_lock/navigation_screens/log_report.dart';
import 'package:wifi_lock/navigation_screens/user_profile.dart';
import 'package:wifi_lock/service/auth.dart';
import 'package:wifi_lock/service/database.dart';

class MainPage extends StatefulWidget {
  static String id = 'main_page';
  static String name;
  // void getName(){
  //   Firestore.instance
  //       .collection('userData')
  //       .document(user.uid);
  //       .get()
  //       .then((value) {
  //
  //     name = value.data['username'];
  //
  //     print("im from database and inside $name");
  //     // return value.data['username'];
  //   });
  // }

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthService _auth = AuthService();
  // final FirebaseUser user = _auth.user;
  int status = 0;
  DateTime lastActivity;
  String formatedDate;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    DatabaseService dbService = DatabaseService(uid: user.uid);
    String name;

    //0-open;1-close

    // String name = dbService.getUserName(uid: user.uid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          'wifi-lock',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.arrow_back_ios),
        //     onPressed: () async {
        //       await _auth.signOut();
        //     },
        //   )
        // ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text(
                'Welcome ${user.name}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('User profile'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new UserProfile(
                              uid: user.uid,
                            )));
              },
            ),
            ListTile(
              title: Text('Log report'),
              onTap: () async {
                print('hello');
                // setState(() {
                await Firestore.instance
                    .collection('userData')
                    .document(user.uid)
                    .get()
                    .then((value) {
                  setState(() {
                    name = value.data['username'];
                  });
                  print("im from database and inside $name");
                  // return value.data['username'];
                });
                // name = dbService.getUserName(uid: user.uid);
                print("im from main page $name");
                // });
                // Navigator.pushNamed(context, LogReport.id);
              },
            ),
            ListTile(
              title: Text('Log out'),
              onTap: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text('hi, your user id is ${user.uid}'),
              FlatButton(
                child: Text('Open'),
                onPressed: () async {
                  DateTime now = DateTime.now();
                  await dbService.openLog(uid: user.uid, currentTime: now);
                  setState(() {
                    status = 0;
                    print(now);
                    lastActivity = now;
                    // formatedDate = lastActivity.toString().substring(0 - 10);
                  });
                },
              ),
              FlatButton(
                child: Text('Close'),
                onPressed: () async {
                  DateTime now = DateTime.now();
                  await dbService.closeLog(uid: user.uid, currentTime: now);
                  setState(() {
                    status = 1;
                    lastActivity = now;
                    // formatedDate = lastActivity.toString().substring(0 - 10);
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                status == 0 ? 'Status : Open' : 'Status : Close',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                lastActivity != null ? 'Last activity on $lastActivity' : "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
