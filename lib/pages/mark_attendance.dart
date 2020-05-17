import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucekified/models/student.dart';
import 'package:cucekified/pages/teacher_dashboard.dart';
import 'package:cucekified/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'set_parameters.dart';

class MarkAttendance extends StatefulWidget {
  @override
  _MarkAttendanceState createState() => _MarkAttendanceState();
}

final GoogleSignIn googleSignIn = GoogleSignIn();
final studRef = Firestore.instance.collection('students');
final teacherRef = Firestore.instance.collection('teachers');
final attRef = Firestore.instance.collection('attendance');

class _MarkAttendanceState extends State<MarkAttendance> {
  String dateFinal;
  String deptFinal;
  int yearFinal;
  String hourFinal;
  bool isMarking = false;
  final absentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateFinal = date;
    deptFinal = dept;
    yearFinal = year;
    hourFinal = hour;
    isMarking = false;
    if (dateFinal == null ||
        deptFinal == null ||
        yearFinal == null ||
        hourFinal == null) {
      // not supposed to be on this page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TeacherDashboard()),
      );
    }
  }

  getUserById(String id) async {
    Student stud;
    DocumentSnapshot snapshot = await studRef.document(id).get();
    stud = Student.fromDocument(snapshot);
    print(stud.username);
  }

  markAttendance() async {
    setState(() {
      isMarking = true;
    });

    String abs = absentController.text;
    // Prepared a list of absentees
    List absent = abs.split(",");
    print(absent);
    absentController.clear();

    //int add;
    // fetched the students list of the class
    // QuerySnapshot snapshot = await studRef
    //     .where("dept", isEqualTo: deptFinal)
    //     .where("year", isEqualTo: yearFinal)
    //     .getDocuments();
    studRef
        .where('dept', isEqualTo: "$deptFinal")
        .where('year', isEqualTo: yearFinal)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((DocumentSnapshot doc) {
        getUserById(doc.documentID);
      });
    });

    print("Fetched all students");

    // perform operations for updating each student's profile
    // snapshot.documents.forEach((DocumentSnapshot doc) {

    //   print('Student $doc.exits Name : $doc["name"]');
    //   // Perform Actions
    //   Student stud = Student.fromDocument(doc);
    //   if (absent.contains(stud.roll))
    //     add = 0;
    //   else
    //     add = 1;

    //   print("Name : $stud.name");
    //   // update student profile.
    //   Firestore.instance.collection('students').document(stud.id).updateData({
    //     "dept": stud.dept,
    //     "gmail": stud.gmail,
    //     "name": stud.name,
    //     "password": stud.password,
    //     "regNo": stud.regNo,
    //     "role": "S",
    //     "roll": stud.roll,
    //     "totalHour": stud.totalHour + 1,
    //     "workingHour": stud.workingHour + add,
    //     "year": stud.year
    //   });
    //   print("Updated for $stud.name");

    //   // update attendance of the student
    // });

    setState(() {
      isMarking = false;
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TeacherDashboard()));
  }

  ListView loadForm() {
    return ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Give a Heading
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Mark Attendance for $deptFinal, $yearFinal year, $hourFinal",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Get list of absentees
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: absentController,
                  decoration: InputDecoration(
                    hintText: 'Ex. 1,4,2,12',
                    labelText:
                        'Enter roll number of absent students (Separated by commas)',
                    filled: true,
                    fillColor: Color(0xFFDBEDFF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty)
                      return "Enter 0 to mark all present";
                    else
                      return null;
                  },
                  autovalidate: true,
                ),
              ),
            ),

            // Mark Attendance
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton.icon(
                    onPressed: markAttendance,
                    icon: Icon(Icons.access_alarm),
                    label: Text("Submit Attendance")),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mark Attendance'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
        child: isMarking ? circularProgress() : loadForm(),
      ),
    );
  }
}
