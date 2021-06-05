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
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
                onPressed: (){},
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
                  onPressed: (){},
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
