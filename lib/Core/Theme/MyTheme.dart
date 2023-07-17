import 'package:flutter/material.dart';

class MyTheme {

  static const Color white = Color(0xFFFFFFFF);
  static const Color blue = Color(0xFF3598DB);
  static const Color gray = Color(0xFFBDBDBD);
  static const Color black = Color(0xFF303030);

  static ThemeData light = ThemeData(
    primaryColor: white,
    hintColor: blue,

    scaffoldBackgroundColor: Colors.transparent,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24 ,
        fontWeight: FontWeight.bold ,
        color: Color(0xFF303030),
      ),
      displayMedium: TextStyle(
        fontSize: 18,
        color: Color(0xFF303030),
      ),
      displaySmall: TextStyle(
        fontSize: 12,
        color: Color(0xFF303030),
      ),
      bodyMedium: TextStyle(fontSize: 14,),
    ),
  );

}