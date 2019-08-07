import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit
  double myWidth = 120.0;
  double myH1 = 30.0;

  // Method
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
      'ซันนี่ไพแล็บ',
      style: TextStyle(
          fontSize: myH1,
          color: Colors.pink[700],
          fontWeight: FontWeight.bold,
          fontFamily: 'Kanit-Regular'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          showLogo(),
          showAppName(),
        ],
      ),
    );
  }
}