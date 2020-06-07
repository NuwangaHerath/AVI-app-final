import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
  Navigator.of(context).pushReplacementNamed('/imagePicker');
}

@override
void initState() {
  super.initState();
  startTime();
}

@override
  Widget build(BuildContext context) {
  return new Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Colors.yellow[50],
          ),
      child:Center(
        child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 155.0,
          child: Image.asset(
            'assets/logo1.png',
            fit: BoxFit.contain,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
        ),
        Container(
        child:Center(
          child:Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("This application is only for the use of Sri Lanka Police",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.normal
        ),
        ),
          ]
        ),
        ),
        ),
      ]
  ) ,
        ),
      ),
    );
  }
}