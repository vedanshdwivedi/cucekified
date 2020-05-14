import 'package:cucekified/main.dart';
import 'package:flutter/material.dart';
import 'student_login.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {


  handleLogout(){
    setState(() {
      isAuth = false;
    });
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyApp()),
  );
  }

  Widget createDashboard(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FlatButton(onPressed: handleLogout, child: Text("Logout")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isAuth ? createDashboard() : StudentLogin(),
    );
  }
}