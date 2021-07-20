import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:otp_detection/objectDetection/homeScreen.dart';
import 'package:otp_detection/main.dart';
import 'package:otp_detection/ocr/ocr.dart';
import 'package:otp_detection/scanQR/scanQR.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Object detection'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.deepPurpleAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                children: [
                  _objectDetection(c),
                  SizedBox(width: 30),
                  _textRecognition(c),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,

              children: [
                _QRscan(c),
              ],
            ),
          ),

        ],
      ),
    );
  }
  Widget _objectDetection(BuildContext c) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen(cameras)),
        );
      },
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(5),
            height: 110,
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.objectUngroup, color: Colors.white, size: 30 ),
                const SizedBox(height: 10),
                Text(
                  'Object',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ],
            ),

            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
    );
  }

  Widget _textRecognition(BuildContext c) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      },
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(5),
            height: 110,
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.newspaper, color: Colors.white, size: 30 ),
                const SizedBox(height: 10),
                Text(
                  'Text',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
    );
  }

  Widget _QRscan(BuildContext c) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ScanQR()));
      },
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(5),
          height: 110,
          width: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.qrcode, color: Colors.white, size: 30 ),
              const SizedBox(height: 10),
              Text(
                'QR Scan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ],
          ),

          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}