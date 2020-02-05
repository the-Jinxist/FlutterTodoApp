import 'package:flutter/material.dart';

class AppUtils {

  static ThemeData appWideTheme(){
    return ThemeData(
        fontFamily: "Montesserat",
        backgroundColor: Colors.white,
        primaryTextTheme: TextTheme(
          title: new TextStyle(
              fontSize: 24.0,
              fontFamily: "Montesserat",
              color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          display1: new TextStyle(
              fontSize: 17.0,
              fontFamily: "Montesserat",
              color: Colors.black,
              fontWeight: FontWeight.normal
          ),
          subtitle: new TextStyle(
              fontSize: 15.0,
              fontFamily: "Montesserat",
              color: Colors.black,
              fontStyle: FontStyle.italic
          ),
        )
    );
  }


}
