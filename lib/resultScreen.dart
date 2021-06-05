import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
class Result extends StatefulWidget {
  File image;
  List outputs;
  Result({Key key,@required this.image,this.outputs}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Image.file(widget.image)
          // decoration: BoxDecoration(
          //   image:DecorationImage(
          //     image: Image.file(_image),
          //   )
          //  
          // ),
        ),
      ),
    );
  }
}
