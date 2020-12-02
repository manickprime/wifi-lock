import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wifi_lock/models/user.dart';
import 'package:wifi_lock/screens/home/wrapper.dart';
import 'package:wifi_lock/service/auth.dart';

class WrapperHome extends StatelessWidget {
  static String id = 'wrapper';

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
