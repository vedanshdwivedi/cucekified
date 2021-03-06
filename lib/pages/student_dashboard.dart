import 'package:cucekified/main.dart';
import 'package:cucekified/pages/view_marked_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'student_login.dart';
import '../models/attendance.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'student_login.dart';

class StudentDashboard extends StatefulWidget {

  final int work;
  final int sum;

  StudentDashboard({this.work, this.sum});
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

final List<Attendance> studentAttendance = [];

class _StudentDashboardState extends State<StudentDashboard> {
  String perc = '0.00';
  double filler = 0.00;
  int a;
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
    if(pres + abs == 0){
      filler = 0.0; 
    }else{
      filler = pres / (pres + abs) ;
      if(filler > 0.74){
        arc = Colors.green;
      }
      filler = filler * 100;
      perc = filler.toStringAsFixed(2);
    }
    return Center(
      child: CircularPercentIndicator(
        radius: 130.0,
        backgroundColor: Colors.white,
        lineWidth: 10.0,
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: arc,
        center: Text(
          '$pres / ${pres + abs}   Hours',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        percent: pres + abs ==0 ? 0.0 : pres / (pres + abs) ,
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: isStudAuth ? createDashboard() : StudentLogin(),
        ),
        onWillPop: () async => false);
  }
}
