import 'package:cucekified/pages/mark_attendance.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetParameters extends StatefulWidget {
  @override
  _SetParametersState createState() => _SetParametersState();
}

String date;
String dept;
int year;
String hour;

class _SetParametersState extends State<SetParameters> {

  final _snackbarKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    date = null;
    dept = null;
    year = null;
    hour = null;
  }

  DropDownFormField deptPicker() {
    return DropDownFormField(
      titleText: 'Department',
      hintText: 'Please choose one',
      value: dept,
      onSaved: (value) {
        setState(() {
          dept = value;
        });
      },
      onChanged: (value) {
        setState(() {
          dept = value;
          print(dept);
        });
      },
      dataSource: [
        {
          "display": "CS",
          "value": "CS",
        },
        {
          "display": "CE",
          "value": "CE",
        },
        {
          "display": "ECE",
          "value": "ECE",
        },
        {
          "display": "EEE",
          "value": "EEE",
        },
        {
          "display": "IT",
          "value": "IT",
        },
        {
          "display": "ME",
          "value": "ME",
        },
        {
          "display": "MCA",
          "value": "MCA",
        },
      ],
      textField: 'display',
      valueField: 'value',
    );
  }

  DropDownFormField yearPicker() {
    return DropDownFormField(
      titleText: 'Year',
      hintText: 'Please choose one',
      value: year,
      onSaved: (value) {
        setState(() {
          if (dept == "MCA" && value == 4)
            year = 3;
          else
            year = value;
        });
      },
      onChanged: (value) {
        setState(() {
          year = value;
          print(year);
        });
      },
      dataSource: [
        {
          "display": "1",
          "value": 1,
        },
        {
          "display": "2",
          "value": 2,
        },
        {
          "display": "3",
          "value": 3,
        },
        {
          "display": "4",
          "value": 4,
        },
      ],
      textField: 'display',
      valueField: 'value',
    );
  }

  DropDownFormField hourPicker() {
    return DropDownFormField(
      titleText: 'Hour',
      hintText: 'Please choose one',
      value: hour,
      onSaved: (value) {
        setState(() {
          hour = value;
        });
      },
      onChanged: (value) {
        setState(() {
          hour = value;
          print(hour);
        });
      },
      dataSource: [
        {
          "display": "1",
          "value": "hour1",
        },
        {
          "display": "2",
          "value": "hour2",
        },
        {
          "display": "3",
          "value": "hour3",
        },
        {
          "display": "4",
          "value": "hour4",
        },
        {
          "display": "5",
          "value": "hour5",
        },
        {
          "display": "6",
          "value": "hour6",
        },
      ],
      textField: 'display',
      valueField: 'value',
    );
  }


  handleParameters(){
    if(date != null && dept != null && year != null && hour != null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MarkAttendance()));
    }else{
      final snackBar = SnackBar(content: Text('Please fill in all the details before proceeding'));
      _snackbarKey.currentState.showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _snackbarKey,
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Set the following parameters : "),
                ),
              ),
              // Date Picker
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 90.0, left: 8.0, right: 8.0, bottom: 8.0),
                  child: RaisedButton(
                    color: Colors.redAccent,
                    child: date == null ? Text('Pick a date') : Text("Selected Date: $date"),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(Duration(days: 3)),
                              lastDate: DateTime.now())
                          .then((value) {
                        var formatter = new DateFormat('yyyy-MM-dd');
                        setState(() {
                          date = formatter.format(value);
                        });
                        // date = formatter.format(value);
                        print(date);
                      });
                    },
                  ),
                ),
              ),

              // dept picker
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: deptPicker(),
                ),
              ),

              // year picker
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: yearPicker(),
                ),
              ),

              // hour picker
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: hourPicker(),
                ),
              ),

              // Mark Attendance
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton.icon(
                      onPressed: handleParameters,
                      icon: Icon(Icons.save),
                      label: Text('Mark Attendance')),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
