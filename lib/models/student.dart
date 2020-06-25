import 'package:cloud_firestore/cloud_firestore.dart';

class Student{
  
  final String username;
  final String dept;
  final String gmail;
  final String role; 
  final String id;
  final String regNo;
  final String roll;
  final int year;
  final int workingHour;
  final int totalHour;
  final String password;
  

  Student({this.id, this.username, this.dept, this.regNo, this.roll, this.year, this.workingHour, this.totalHour,  this.gmail, this.password, this.role});

  factory Student.fromDocument(DocumentSnapshot doc){
    return Student(
      id: doc.documentID,
      username: doc["username"],
      dept: doc["dept"],
      regNo: doc["regNo"],
      roll: doc["roll"],
      year: doc["year"],
      workingHour: doc["workingHour"],
      totalHour: doc["totalHour"],
      gmail: doc["gmail"],
      password: doc["password"],
      role: doc["role"],
    );
  }

}