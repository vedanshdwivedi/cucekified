import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucekified/models/attendance.dart';
import 'package:cucekified/pages/student_login.dart';
import 'package:cucekified/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'home.dart';

final markedRef =
    attRef.document(currentStudent.regNo).collection('markedAttendance');
bool isCalculating = false;

class ViewMarkedAttendance extends StatefulWidget {
  @override
  _ViewMarkedAttendanceState createState() => _ViewMarkedAttendanceState();
}

class _ViewMarkedAttendanceState extends State<ViewMarkedAttendance> {
  List<Attendance> id = [];

  @override
  void initState() {
    super.initState();
    markedRef.orderBy('date').getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((DocumentSnapshot doc) {
        Attendance attn = Attendance.fromDocument(doc);
        setState(() {
          id.add(attn);
        });
      });
    });
  }

  processHourAttendance(String chk) {
    if (chk == "A") return "A";
    if (chk == null) return "-";
    if (chk != null && chk != "A") return "P";
  }

  Widget loadListView() {
    return ListView.builder(
      itemCount: id.length,
      itemBuilder: (BuildContext context, int index) {
        Attendance att = id[index];
        String h1 = processHourAttendance(att.hour1);
        String h2 = processHourAttendance(att.hour2);
        String h3 = processHourAttendance(att.hour3);
        String h4 = processHourAttendance(att.hour4);
        String h5 = processHourAttendance(att.hour5);
        String h6 = processHourAttendance(att.hour6);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListTile(
              
              title: Text(
                att.date,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              subtitle: Container(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          '1',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        )),
                        Expanded(
                            child: Text(
                          '2',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        )),
                        Expanded(
                            child: Text(
                          '3',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        )),
                        Expanded(
                            child: Text(
                          '4',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        )),
                        Expanded(
                            child: Text(
                          '5',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        )),
                        Expanded(
                            child: Text(
                          '6',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        )),
                      ],
                    ),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Text(h1)),
                        Expanded(child: Text(h2)),
                        Expanded(child: Text(h3)),
                        Expanded(child: Text(h4)),
                        Expanded(child: Text(h5)),
                        Expanded(child: Text(h6)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hi ${currentStudent.username}'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: id.length == 0 ? circularProgress() : loadListView(),
      ),
    );
  }
}
