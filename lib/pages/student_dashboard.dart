import 'package:cucekified/main.dart';
import 'package:cucekified/pages/view_marked_attendance.dart';
import 'package:flutter/material.dart';
import 'student_login.dart';
import '../models/attendance.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

final List<Attendance> studentAttendance = [];

class _StudentDashboardState extends State<StudentDashboard> {
  int work = currentStudent.workingHour;
  int total = currentStudent.totalHour;
  String perc = '0.00';

  handleLogout() {
    setState(() {
      isStudAuth = false;
      currentStudent = null;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  loadListView() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ViewMarkedAttendance(), maintainState: true)
    );
  }

  Widget createDashboard() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Hello ${currentStudent.username}', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),),
          )),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$perc % Attendance", style: TextStyle(
              fontSize: 24.0,
              color: Colors.black87,
            ),),
            ),
          ),

          // get a listview
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: RaisedButton.icon(
                  color: Colors.blue[300],
                    onPressed: loadListView,
                    icon: Icon(Icons.linear_scale),
                    label: Text('Show detailed view'))),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(onPressed: handleLogout, child: Text("Logout")),
            ),
          ),
        ],
      ),
    );
  }

  String calcPerc(int a, int b) {
    if (a == 0 || b == 0) return "0.00";
    double c = a / b;
    c = c * 100;
    String ab = c.toStringAsFixed(2);
    return ab;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      perc = calcPerc(work, total);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isStudAuth ? createDashboard() : StudentLogin(),
    );
  }
}
