import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

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
        body: Stack(
         children: <Widget>[
           Container(
             decoration: BoxDecoration(
               image: DecorationImage(
                 image: FileImage(widget.image),
                 fit: BoxFit.cover,
               )
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(top: 30.0,left: 10.0,right: 10.0),
             child: DraggableScrollableSheet(builder:(context,controller) {
               return Container(
                 padding: EdgeInsets.all(30.0),
                 child: ListView.builder(itemCount: 1,
                 physics: BouncingScrollPhysics(),
                 controller: controller,
                 itemBuilder: (BuildContext context,index){
                   return Column(
                     children: <Widget>[
                       Center(child: Text(widget.outputs[0]["label"],style: TextStyle(color: Colors.black,fontSize: 50.0),)),
                       
                     ],
                   );
                   },
                 ),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))
                 ),
               );
             }
             ),
           )
         ],
        ),
      ),
    );
  }
}
