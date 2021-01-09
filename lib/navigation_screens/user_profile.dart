import 'package:flutter/material.dart';
import 'package:wifi_lock/models/online_user.dart';
import 'package:wifi_lock/service/database.dart';

class UserProfile extends StatefulWidget {
  static String id = 'user_profile';

  final String uid;
  const UserProfile({this.uid});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService(uid: widget.uid);
    Future user = db.getUser(uid: widget.uid);

    return Scaffold(
      body: Column(
        children: [
          Text('$user.name'),
        ],
      ),
    );
  }
}
