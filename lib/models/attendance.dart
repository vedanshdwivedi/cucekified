import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance{
  // name, username, dept, password, gmail, role
  final String date;
  final String hour1;
  final String hour2;
  final String hour3;
  final String hour4;
  final String hour5;
  final String hour6;

  Attendance({this.date, this.hour1, this.hour2, this.hour3, this.hour4, this.hour5, this.hour6});

  factory Attendance.fromDocument(DocumentSnapshot doc){
    return Attendance(
      date: doc["date"],
      hour1: doc["hour1"],
      hour2: doc["hour2"],
      hour3: doc["hour3"],
      hour4: doc["hour4"],
      hour5: doc["hour5"],
      hour6: doc["hour6"],
    );
  }

}