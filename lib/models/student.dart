import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucekified/models/attendance.dart';

class Student{
  // name, username, dept, password, gmail, role
  final String name;
  final String dept;
  final String gmail;
  final String role = "S"; 
  final String id;
  final String regNo;
  final String roll;
  final int year;
  final int workingHour;
  final int totalHour;
  final String password;
  

  Student({this.id, this.name, this.dept, this.regNo, this.roll, this.year, this.workingHour, this.totalHour,  this.gmail, this.password});

  factory Student.fromDocument(DocumentSnapshot doc){
    return Student(
      id: doc.documentID,
      name: doc["name"],
      dept: doc["dept"],
      regNo: doc["regNo"],
      roll: doc["roll"],
      year: doc["year"],
      workingHour: doc["workingHour"],
      totalHour: doc["totalHour"],
      gmail: doc["gmail"],
      password: doc["password"],
    );
  }

}