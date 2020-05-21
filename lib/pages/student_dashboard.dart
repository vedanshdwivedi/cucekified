import 'package:cucekified/main.dart';
import 'package:cucekified/pages/view_marked_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'student_login.dart';
import '../models/attendance.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

final List<Attendance> studentAttendance = [];

class _StudentDashboardState extends State<StudentDashboard> {
  int work = currentStudent.workingHour;
  int total = currentStudent.totalHour;
  String perc = '0.00';
  double filler = 0.00;
  Color arc = Colors.red;

  handleLogout() {
    setState(() {
      isStudAuth = false;
      currentStudent = null;
    });
    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    Phoenix.rebirth(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  loadListView() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewMarkedAttendance(), maintainState: true));
  }

  Widget loadCircularAnimator() {
    return Center(
      child: CircularPercentIndicator(
        radius: 130.0,
        backgroundColor: Colors.white,
        lineWidth: 10.0,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: arc,
        center: Text(
          '${currentStudent.workingHour} / ${currentStudent.totalHour}   Hours',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        percent: filler,
      ),
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
          Container(
            child: loadCircularAnimator(),
          ),

          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Hello ${currentStudent.username}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          )),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$perc % Attendance",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black87,
                ),
              ),
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
    if (a == 0 || b == 0) {
      return "0.00";
    }
    double c = a / b;
    c = c * 100;
    setState(() {
      filler = c.ceilToDouble() / 100.0;
      if (filler > 0.74) arc = Colors.green;
    });
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
    return WillPopScope(
        child: Scaffold(
          body: isStudAuth ? createDashboard() : StudentLogin(),
        ),
        onWillPop: () async => false);
  }
}
