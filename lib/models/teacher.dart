import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher{
  // name, username, dept, password, gmail, role
  final String name;
  final String username;
  final String dept;
  final String password;
  final String gmail;
  final String role = "T"; 
  final String id;

  Teacher({this.id, this.name, this.username, this.dept, this.gmail, this.password});

  factory Teacher.fromDocument(DocumentSnapshot doc){
    return Teacher(
      id: doc.documentID,
      name: doc["name"],
      username: doc["username"],
      dept: doc["dept"],
      password: doc["password"],
      gmail: doc["gmail"],
    );
  }

}