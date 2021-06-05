import 'dart:io';
import 'resultScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File _image;
  List _outputs;
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Result(image: _image,outputs: _outputs,)));
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
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Result(image: _image,outputs: _outputs[0]["label"],)),);
  }

  Future getImageFromGallery() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _loading=true;
        _image = File(pickedFile.path);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Result(image: _image)));
      } else {
        print('No image selected.');
      }
    });
    classifyImage(_image);
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Result(image: _image,outputs: _outputs[0]["label"],)),);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Home2.jpg'),
                        fit: BoxFit.cover,
                    // colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.0)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              MaterialButton(
                onPressed:getImageFromCamera,
                  elevation: 10.0,
                  focusColor: Colors.amber,
                color: Colors.deepOrangeAccent,
                child: Container(child: Text("Take Photo",style: TextStyle(color: Colors.white,fontSize: 25.0),
                ),
                  padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 10.0,bottom: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple,
                        Colors.deepOrangeAccent
                      ]
                    )
                  ),
               ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.all(0.0)
              ),
              SizedBox(
                height:50,
              ),
              MaterialButton(
                  onPressed:getImageFromGallery,
                  elevation: 10.0,
                  focusColor: Colors.amber,
                  color: Colors.deepOrangeAccent,
                  child: Container(child: Text("Select Photo",style: TextStyle(color: Colors.white,fontSize: 25.0),
                  ),
                    padding: EdgeInsets.only(left: 40.0,right: 40.0,top: 10.0,bottom: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple,
                              Colors.deepOrangeAccent
                            ]
                        )
                    ),
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.all(0.0)
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
