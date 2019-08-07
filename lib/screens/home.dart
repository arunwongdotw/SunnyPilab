import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit
  double myWidth = 120.0;
  double myH1 = 30.0;
  Color myColor = Colors.brown[400];

  // Method

  Widget signUpButton() {
    return Container(
      width: 220.0,
      child: OutlineButton(
        borderSide: BorderSide(color: myColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(color: myColor),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget signInButton() {
    return Container(
      width: 220.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: myColor,
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget showLogo() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: myWidth,
        height: myWidth,
        child: Image.asset('images/deer.png'),
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'ซั น นี่ ไ พ แ ล็ บ',
      style: TextStyle(
          fontSize: myH1,
          color: Colors.brown[700],
          fontWeight: FontWeight.bold,
          fontFamily: 'Kanit-Regular'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, Colors.brown],
            radius: 1.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showLogo(),
            showAppName(),
            signInButton(),
            signUpButton(),
          ],
        ),
      ),
    );
  }
}
