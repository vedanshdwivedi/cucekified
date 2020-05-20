import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucekified/models/student.dart';
import 'package:cucekified/pages/teacher_dashboard.dart';
import 'package:cucekified/pages/teacher_login.dart';
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
List absent;

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

  markAttendanceInDatabase(String id) async {
    DocumentSnapshot snapshot = await studRef.document(id).get();
    Student stud = Student.fromDocument(snapshot);

    // if roll in absent list then set add 0 to workingHour
    int add = absent.contains(stud.roll) ? 0 : 1;

    // update data on student profile
    studRef.document(id).updateData({
      'workingHour' : stud.workingHour + add,
      'totalHour' : stud.totalHour + 1,
    }); 

    String attendanceId = stud.regNo +"_"+ dateFinal ;
    String mark = add == 0 ? "A" : currentTeacher.username;

    // add this in attendance collection
    attRef.document(stud.regNo).collection("markedAttendance").document(attendanceId).setData(
      {
        'date': dateFinal,
        '$hourFinal': mark,
      },merge: true,
    );
  }

  markAttendance() async {
    setState(() {
      isMarking = true;
    });

    String abs = absentController.text;
    // Prepared a list of absentees
    absent = abs.split(",");
    print(absent);
    absentController.clear();

    studRef
        .where('dept', isEqualTo: "$deptFinal")
        .where('year', isEqualTo: yearFinal)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((DocumentSnapshot doc) {
        markAttendanceInDatabase(doc.documentID);
      });
    });

    setState(() {
      isMarking = false;
      dateFinal = null;
      deptFinal = null;
      yearFinal = null;
      hourFinal = null;
      date = null;
      dept = null;
      year = null;
      hour = null;
    });
    final snackbar = SnackBar(content: Text('Attendance Marked Successfully'));
    AttendanceKey.currentState.showSnackBar(snackbar);
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
