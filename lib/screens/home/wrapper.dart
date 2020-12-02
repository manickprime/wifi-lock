import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wifi_lock/models/user.dart';
import 'package:wifi_lock/navigation_screens/main_page.dart';
import 'package:wifi_lock/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      print("register");
      return Authenticate();
    } else {
      return MainPage();
    }
  }
}
