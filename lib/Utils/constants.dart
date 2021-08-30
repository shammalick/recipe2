import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
const Color kPrimaryColor = Color(0xFF27AE60);
Color whitee = Colors.white;
Color blackk = Colors.black;
 const Color myColor = Color(0xff00bfa5);
 final db = FirebaseFirestore.instance;
BoxShadow kBoxShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  spreadRadius: 2,
  blurRadius: 8,
  offset: Offset(0, 0),
);



numberConvert(var number){
    double convert;
    double convert2;
    if(number>=1000 && number<=1000000)
    
    {
      convert = number/1000;
       convert2  = double.parse((convert).toStringAsFixed(1));
      return Text("$convert2 k");
    }
    else if(number>=1000000)
    {
       convert= number/1000000;
     convert2  = double.parse((convert).toStringAsFixed(1));

    
      return Text("$convert2 m");
    }
    else{
      return Text("$number ");
    }
  }
