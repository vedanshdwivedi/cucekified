import 'package:cucekified/pages/student_login.dart';
import 'package:cucekified/pages/teacher_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../main.dart';
import './set_parameters.dart';

class TeacherDashboard extends StatefulWidget {
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}
 final AttendanceKey = GlobalKey<ScaffoldState>();

class _TeacherDashboardState extends State<TeacherDashboard> {
  handleLogout() {
    setState(() {
      isFacAuth = false;
      currentTeacher = null;
    });
    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    Phoenix.rebirth(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
      key: AttendanceKey,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Faculty Dashboard"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('Hello ${currentTeacher.name}')),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: RaisedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SetParameters()));
                    },
                    icon: Icon(Icons.access_alarms),
                    label: Text('Mark Attendance'),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: RaisedButton.icon(
                    onPressed: handleLogout,
                    icon: Icon(Icons.account_circle),
                    label: Text('Logout'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
