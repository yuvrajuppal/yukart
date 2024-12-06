import 'package:flutter/material.dart';

class AppWidget{
  static TextStyle boldtextstyle(){
    return TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        );
  }
  static TextStyle lighttextstyle()
  {
    return TextStyle(
color: Colors.black54,
fontSize: 20,
fontWeight: FontWeight.bold,
    );
  }
  static TextStyle semiboldtextfield(){
    return TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20, );
  }
}