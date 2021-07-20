import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:otp_detection/objectDetection/BoundingBox.dart';
import 'package:otp_detection/objectDetection/Camera.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math' as math;

const String ssd = "SSD MobileNet";

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final FlutterTts tts = FlutterTts();

  HomeScreen(this.cameras){
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  loadModel() async {
    String result;

    switch (_model) {
      case ssd:
        result = await Tflite.loadModel(
            labels: "assets/ssd_mobilenet.txt",
            model: "assets/ssd_mobilenet.tflite");
    }
    print(result);
  }

  onSelectModel(model) {
    setState(() {
      _model = model;
    });

    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
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
      body: _model == ""
          ? Container()
          : Stack(
        children: [
          Camera(widget.cameras,
              _model,
              setRecognitions),
          BoundingBox(
              _recognitions == null ? [] : _recognitions,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              screen.width, screen.height, _model
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          onSelectModel(ssd);
        },
        child: Icon(Icons.photo_camera),
      ),
    );
  }
}