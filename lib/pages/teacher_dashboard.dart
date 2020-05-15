import 'package:cucekified/pages/teacher_login.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class TeacherDashboard extends StatefulWidget {
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}


class _TeacherDashboardState extends State<TeacherDashboard> {

  handleLogout(){
    setState(() {
      isAuth = false;
    });
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyApp()),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(onPressed: handleLogout, child: Text("Logout")),
    );
  }
}