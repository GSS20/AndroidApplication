import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_ocr_plugin/simple_ocr_plugin.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker _picker = ImagePicker();
  final FlutterTts tts = FlutterTts();
  PickedFile _pickedFile;
  TextEditingController _resultCtrl = TextEditingController();

  MyHomePage() {
    tts.setLanguage('en');
    tts.setSpeechRate(1);
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text recognition'),
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
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            //child: _buildDropDown(c)
            child: Row(
              children: [
                _buildLabel(c),
                _buildCam(c),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
            child: _buildResult(c),
          ),

          Padding(
            padding: EdgeInsets.all(4),
            child: _buildImage(c),
          ),

          Padding(
            padding: EdgeInsets.all(8),
            child: _buildResultArea(c),
          ),
        ],
      ),
    );
  }

  /// Build the label for opening the photo album.
  Widget _buildLabel(BuildContext c) {
    return InkWell(
      onTap: () {
        getImageFromCameraGallery(true);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Row(
          children: [
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(5),
                height: 90,
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.camera, color: Colors.white, size: 30 ),
                    const SizedBox(height: 10),
                    Text(
                      'Camera',
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCam(BuildContext c) {
    return InkWell(
      onTap: () {
        getImageFromCameraGallery(false);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Row(
          children: [
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(5),
                height: 90,
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.fileImage, color: Colors.white, size: 30 ),
                    const SizedBox(height: 10),
                    Text(
                      'Gallery',
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
            )
          ],
        ),
      ),
    );
  }
  /// Build the image preview.
  ///
  /// Displayed image depends on the value of [_filePicked].
  Widget _buildImage(BuildContext c) {
    return _pickedFile!=null?
    Image.asset(_pickedFile.path,
      width: 400,
      fit: BoxFit.contain,
    ):Container(height: 10,);
  }

  /// Build the text-area for displaying recognised results. This widget is read-only.
  Widget _buildResultArea(BuildContext c) {
    return TextField(
      controller: _resultCtrl,
      decoration: InputDecoration(
          hintText: "Recognised results would be displayed here..."
      ),
      minLines: 10,
      maxLines: 1000,
      enabled: false,
    );
  }

  Widget _buildResult(BuildContext c) {
    return InkWell(
        onTap: () {
           _onRecogniseTap();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: GestureDetector(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(5),
                height: 50,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View Text',
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
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            )
      ),
    );
  }

  /// Perform text-recognition and updates the content of the text-area.
  Future<void> _onRecogniseTap() async {
    String _result = await SimpleOcrPlugin.performOCR(_pickedFile.path);
    setState(() {
      String s = _result;
      _result = s.substring(23, s.length-15);
      _resultCtrl.text = _result;
      tts.speak(_resultCtrl.text);
    });
  }

  /// Display photo album for picking or from camera.
  Future getImageFromCameraGallery(bool isCamera) async {
    var image = await _picker.getImage(
        source: (isCamera == true) ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      _pickedFile = image;
    });
  }
}