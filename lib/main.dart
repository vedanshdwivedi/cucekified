import 'package:cucekified/pages/home.dart';
import 'package:cucekified/pages/student_login.dart';
import 'package:cucekified/pages/teacher_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cucekified',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.orange,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  gotoStudentLogin(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => StudentLogin()));
  }

  gotoFacultyLogin(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => FacultyLogin()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Logo
            SvgPicture.asset(
              'images/logo.svg',
              height: 160,
            ),
            // Title
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('CUCEKIFIED', style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),),
                ],
              ),
            ),
            // Teacher and Student Navigator
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Select Role", style: TextStyle(
                    fontSize: 25.0,
                  ),),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: FlatButton.icon(onPressed: gotoStudentLogin, icon: Icon(Icons.assignment_ind), label: Text('Student')),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Expanded(
                      child: FlatButton.icon(onPressed: gotoFacultyLogin, icon: Icon(Icons.account_balance), label: Text('Faculty')),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
