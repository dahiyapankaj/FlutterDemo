import 'package:flutter/material.dart';
import 'package:flutterapp/screens/ContactsPage.dart';

import 'TodoPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 20.0);

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      onChanged: (String str) {
        setState(() {
          _email = str;
        });
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      onChanged: (String str) {
        setState(() {
          _password = str;
        });
      },
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginTodoButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(32.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          // function to validate and move to next screen
          if (isDataValid(_email, _password)) {
            // move to next screens
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TodoPage()),
            );
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Email and Password cannot be empty"),
            ));
          }
        },
        child: Text("Login to Todo",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final loginContactsButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(32.0),
      color: Colors.blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          // function to validate and move to next screen
          if (isDataValid(_email, _password)) {
            // move to next screens
            Navigator.push(
              context,
//              MaterialPageRoute(builder: (context) => TodoList()),
              MaterialPageRoute(builder: (context) => ContactsPage()),
            );
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Email and Password cannot be empty"),
            ));
          }
        },
        child: Text("Login to Contacts",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginTodoButton,
                SizedBox(
                  height: 15.0,
                ),
                loginContactsButton,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  /// Method just to check if data is not empty.
  /// returns false if data is empty
  bool isDataValid(String email, String password) {
    return (email.isNotEmpty && password.isNotEmpty) ? true : false;
  }
}
