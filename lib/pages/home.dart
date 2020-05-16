// Import Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Import Models
import '../models/attendance.dart';
import '../models/student.dart';
import '../models/teacher.dart';

// Import Pages


import 'student_dashboard.dart';
import 'teacher_dashboard.dart';
import 'teacher_marker.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final studRef = Firestore.instance.collection('students');
final teacherRef = Firestore.instance.collection('teachers');
final attRef = Firestore.instance.collection('attendance');



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

    );
  }
}