import 'package:flutter/material.dart';
import 'package:wifi_lock/navigation_screens/log_report.dart';
import 'package:wifi_lock/navigation_screens/main_page.dart';
import 'package:wifi_lock/navigation_screens/user_profile.dart';
import 'package:wifi_lock/screens/authenticate/login_screen.dart';
import 'package:wifi_lock/screens/authenticate/registration_screen.dart';
import 'package:wifi_lock/screens/home/wrapper_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WrapperHome.id,
      routes: {
        WrapperHome.id: (context) => WrapperHome(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MainPage.id: (context) => MainPage(),
        LogReport.id: (context) => LogReport(),
        UserProfile.id: (context) => UserProfile(),
      },
    );
  }
}
