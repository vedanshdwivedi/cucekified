// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cucekified/models/teacher.dart';
import 'package:cucekified/pages/student_login.dart';
import 'package:cucekified/pages/teacher_dashboard.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class TeacherLogin extends StatefulWidget {
  @override
  _TeacherLoginState createState() => _TeacherLoginState();
}

Teacher currentTeacher;
bool isFacAuth = false;

class _TeacherLoginState extends State<TeacherLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String usermail;
  bool isValidating;

  handleLogin() async {
    if(currentStudent != null){
      currentStudent = null;
      isStudAuth = false;
    }
    String u = emailController.text;
    String p = passwordController.text;
    emailController.clear();
    passwordController.clear();

    setState(() {
      isValidating = true;
    });
    QuerySnapshot snapshot =
        await teacherRef.where("gmail", isEqualTo: u).limit(1).getDocuments();
    snapshot.documents.forEach((DocumentSnapshot doc) {
      currentTeacher = doc.exists ? Teacher.fromDocument(doc) : null;
    });
    if (currentTeacher != null && currentTeacher.password == p && currentTeacher.role == "T") {
      // perform login and load Teacher dashboard
      setState(() {
        isFacAuth = true;
        isValidating = false;
      });
      final snackBar = SnackBar(content: Text('Login Successful'));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        isFacAuth = false;
        isValidating = false;
      });
      // load teh snackbar and reattempt login
      final snackBar = SnackBar(content: Text('Invalid Username/Password'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    if(currentTeacher == null)
      isFacAuth = false;
    else
      isFacAuth = true;
    isValidating = false;
  }

  Widget formLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // get gmail id
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    autovalidate: true,
                    validator: (val) {
                      if (val.trim().length < 6 || val.isEmpty)
                        return "Too short ot be an email";
                      if (!EmailValidator.validate(val))
                        return "Invalid email id";
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "enter your email id",
                      labelStyle: TextStyle(fontSize: 15.0),
                      hintText: "Must be a valid email id",
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // get password
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        autovalidate: true,
                        validator: (val) {
                          if (val.trim().length < 5 || val.isEmpty)
                            return "Password too short";
                          else
                            return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "enter password",
                          labelStyle: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.orange,
                          onPressed: isValidating ? null : handleLogin,
                          child: Text("Login as Teacher"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget loadLoginScreen() {
    return ListView(
      children: <Widget>[
        Container(
          child: isValidating ? keepWaiting() : formLayout(),
        ),
      ],
    );
  }

  Widget keepWaiting() {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  AppBar loginAppBar(){
    return AppBar(
        title: Text('Teacher Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFacAuth ? null : loginAppBar(),
      key: _scaffoldKey,
      body: isFacAuth ? TeacherDashboard() : loadLoginScreen(),
    );
  }
}
