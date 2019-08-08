import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sunny_pilab/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please fill name in blank';
        }
      },
      onSaved: (String value) {
        nameString = value;
      },
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
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please keep format email';
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
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
      validator: (String value) {
        if (value.length < 6) {
          return 'Password more 6 characters';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  Widget groupText() {
    return Form(
      key: formKey,
      child: ListView(
        padding:
            EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0, left: 16.0),
        children: <Widget>[
          nameText(),
          emailText(),
          passwordText(),
        ],
      ),
    );
  }

  Widget registerButton() {
    return IconButton(
      tooltip: 'Register Firebase',
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'name = $passwordString, email = $emailString, password = $passwordString');
          uploadValueToFirebase();
        }
      },
    );
  }

  Future<void> uploadValueToFirebase() async {
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register success');
      setUpDisplayName();
    }).catchError((response) {
      print('response = ${response.toString()}');
      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }

  Future<void> setUpDisplayName() async {
    await firebaseAuth.currentUser().then((response) {
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nameString;
      response.updateProfile(userUpdateInfo);
      var myServiceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context)
          .pushAndRemoveUntil(myServiceRoute, (Route<dynamic> route) => false);
    });
  }

  void myAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[registerButton()],
        backgroundColor: Color.fromARGB(255, 109, 76, 65),
        title: Text('Register'),
      ),
      body: groupText(),
    );
  }
}
