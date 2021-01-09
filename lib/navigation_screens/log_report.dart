import 'package:flutter/material.dart';

class LogReport extends StatefulWidget {
  static String id = 'log_report';

  @override
  _LogReportState createState() => _LogReportState();
}

class _LogReportState extends State<LogReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log report'),
      ),
      body: Center(child: Text('This is where you show log report')),
    );
  }
}
