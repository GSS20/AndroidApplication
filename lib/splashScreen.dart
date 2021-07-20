import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:otp_detection/homeScreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: Text('Welcome!'),
      seconds: 6,
      navigateAfterSeconds: HomePage(),
      backgroundColor: Colors.teal,
      useLoader: true,
      loaderColor: Colors.white,
      loadingText: Text(
        "Welcome!...",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}