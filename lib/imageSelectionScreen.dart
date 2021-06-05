import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class SelectorPage extends StatefulWidget {

  @override
  _SelectorPageState createState() => _SelectorPageState();
}

class _SelectorPageState extends State<SelectorPage> {
  List _outputs;
  File _image;
  final picker = ImagePicker();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _loading=true;
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    classifyImage(_image);
  }

  Future getImageFromGallery() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _loading=true;
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        body:Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // _loading ? Container(
            //   height: 300,
            //   width: 300,
            // ):
            // Container(
            //   margin: EdgeInsets.all(20),
            //   width: MediaQuery.of(context).size.width,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       _image == null ? Container(
            //         child: Text('Select a Photo',style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 50.0))
            //       ) : Image.file(_image),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       _image == null ? Container() : _outputs != null ?
            //       Text(_outputs[0]["label"],style: TextStyle(color: Colors.deepOrange,fontSize: 20),
            //       ) : Container(child: Text(""))
            //     ],
            //   ),
            // ),
          Center(
            child: _image == null
                ? Text('Select a Photo',style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 50.0))
                : Image.file(_image),
          ),
           Container(
             child:
                   _image == null ? Container() : _outputs != null ?
                   Text(_outputs[0]["label"],style: TextStyle(color: Colors.deepOrange,fontSize: 20),
                   ) : Container(child: Text("No Feeling",style:TextStyle(color: Colors.deepOrange,fontSize: 20) ,)) ,
           ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(onPressed: getImageFromCamera,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.white10,
                child: Text('Take Photo',style: TextStyle(color: Colors.deepOrangeAccent),),
                ),
                MaterialButton(onPressed: getImageFromGallery,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.white10,
                  child: Text('Select Photo',style: TextStyle(color: Colors.deepOrangeAccent),),
                )
              ],
            ),

          ],
        )

      ),
    );
  }
}
