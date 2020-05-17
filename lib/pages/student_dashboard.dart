import 'package:cucekified/main.dart';
import 'package:flutter/material.dart';
import 'student_login.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {

  int work = currentStudent.workingHour;
  int total = currentStudent.totalHour;
  String perc = '0.00';

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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Current Attendance Percentage is : $perc"),
            ),
          ),
          
          // get a listview

          // change password

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

  String calcPerc(int a, int b){
    if(a==0 || b==0)
      return "0.00";
    double c = a/b;
    c = c*100;
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
      body: isAuth ? createDashboard() : StudentLogin(),
    );
  }
}