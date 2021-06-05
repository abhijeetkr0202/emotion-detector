import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:[
                Colors.green,
                Colors.greenAccent
              ]
            )
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/home.jpg'),
                        fit: BoxFit.cover,
                    // colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken)
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.0)),
                ),
              ),
              MaterialButton(
                child: Text("Take Photo",style: TextStyle(color: Colors.deepOrange,fontSize: 25.0),),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.greenAccent,

              ),
              MaterialButton(
                child: Text("Select Photo",style: TextStyle(color: Colors.deepOrange,fontSize: 25.0),),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.greenAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
