import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit

  // Method
  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          size: 36.0,
          // color: Colors.green,
        ),
        labelText: 'Name: ',
        // labelStyle: TextStyle(color: Colors.green),
        helperText: 'Type your name',
        helperStyle: TextStyle(color: Colors.yellow[700]),
        hintText: 'English only',
      ),
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          size: 36.0,
          // color: Colors.green,
        ),
        labelText: 'Email: ',
        // labelStyle: TextStyle(color: Colors.green),
        helperText: 'Type your email',
        helperStyle: TextStyle(color: Colors.yellow[700]),
        hintText: 'you@emai.com',
      ),
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          size: 36.0,
          // color: Colors.green,
        ),
        labelText: 'Password: ',
        // labelStyle: TextStyle(color: Colors.green),
        helperText: 'Type your password',
        helperStyle: TextStyle(color: Colors.yellow[700]),
        hintText: 'More 6 characters',
      ),
    );
  }

  Widget groupText() {
    return ListView(
      padding:
          EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0, left: 16.0),
      children: <Widget>[
        nameText(),
        emailText(),
        passwordText(),
      ],
    );
  }

  Widget registerButton() {
    return IconButton(
      tooltip: 'Register Firebase',
      icon: Icon(Icons.cloud_upload),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[registerButton()],
        // backgroundColor: Color.fromARGB(a, r, g, b),
        title: Text('Register'),
      ),
      body: groupText(),
    );
  }
}
