import 'package:barcode_scan/barcode_scan.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunny_pilab/screens/authen.dart';
import 'package:sunny_pilab/screens/my_service.dart';
import 'package:sunny_pilab/screens/register.dart';
import 'package:permission_handler/permission_handler.dart';
import 'camera.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit
  double myWidth = 120.0;
  double myH1 = 30.0;
  Color primaryColor = Color.fromARGB(255, 251, 192, 45);
  Color lightColor = Color.fromARGB(255, 255, 242, 99);
  Color darkColor = Color.fromARGB(255, 196, 144, 0);
  String barcodeValue = '';

  // Method
  @override // เริ่มก่อนใครในหน้านี้
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      var serviceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context)
          .pushAndRemoveUntil(serviceRoute, (Route<dynamic> route) => false);
    }
  }

  Future<void> getCameraPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.camera]);
  }

  Future<void> getCameraList() async {
    getCameraPermission();
    // final cameras = await availableCameras();
    List<CameraDescription> cameras = await availableCameras();
    final firstCamera = cameras[0];
    var cameraRoute = MaterialPageRoute(
        builder: (BuildContext context) =>
            TakePictureScreen(camera: firstCamera));
    Navigator.of(context).push(cameraRoute);
  }

  // Function 
  Future<void> getScan() async {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        barcodeValue = barcode;
      });
  }

  Widget signUpButton() {
    return Container(
      width: 220.0,
      child: OutlineButton(
        borderSide: BorderSide(
          color: primaryColor,
          width: 2.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          print('click sign in button');
          var registerRoute =
              MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(registerRoute);
        },
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
        color: primaryColor,
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          print('click sign in button');
          var authenRoute =
              MaterialPageRoute(builder: (BuildContext context) => Authen());
          Navigator.of(context).push(authenRoute);
        },
      ),
    );
  }

  Widget cameraButton() {
    return Container(
      width: 220.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.camera,
            ),
            Text(
              'Camera',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        onPressed: () {
          getCameraList();
        },
      ),
    );
  }

  Widget barcodeButton() {
    return Container(
      width: 220.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.scanner,
            ),
            Text(
              'Barcode & QR Code',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        onPressed: () {
          getScan();
        },
      ),
    );
  }

  Widget showLogo() {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: myWidth,
        height: myWidth,
        child: Image.asset('images/logo.png'),
      ),
    );
  }

  Widget showAppName() {
    return Text(
      'ไ ก่ เ เ อ ป',
      style: TextStyle(
        fontSize: myH1,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'Kanit-Regular',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [lightColor, darkColor],
            radius: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showLogo(),
            showAppName(),
            cameraButton(),
            barcodeButton(),
            Text(barcodeValue),
            // signInButton(),
            // signUpButton(),
          ],
        ),
      ),
    );
  }
}
