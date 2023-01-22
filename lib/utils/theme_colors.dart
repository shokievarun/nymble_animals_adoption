import 'package:flutter/material.dart';

abstract class ThemeColors {
  // Normal Colors
  static const Color grey = Color.fromARGB(255, 180, 180, 180);
  static const Color lightGrey = Color.fromARGB(120, 206, 206, 206);
  static const Color black = Color(0xFF242424);
  static const Color lightBlack = Color.fromARGB(255, 87, 87, 87);

  // New colors

  static const Color background = Color(0xfff6f9fd);
  static const Color white = Color(0xfffefeff);
  static const Color accent = Color.fromARGB(255, 155, 158, 220);
  static const Color accentForText = Color(0xff9599E2);
  static const Color redForBackground = Color(0xfff8cfdf);
  static const Color redForText = Color(0xFFFF6078);
  static const Color greenColor = Colors.green;

  // Gradients
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xff8BC6EC), accentForText],
  );

  static const List<List<Color>> gradients = [
    [Color(0xffffc2c2), Color(0xffffd7a8)],
    [Color(0xffeb4174), Color(0xffffe3e3)],
    [Color(0xffc15cff), Color(0xffff5454)],
    [Color(0xff9ef9d8), Color(0xffcaf6bf)],
    [Color(0xff8a2eff), Color(0xffcce0ff)],
    [Color(0xffDAD299), Color(0xff8CA6DB)],
    [Color(0xffCAC531), Color(0xffF3F9A7)],
  ];
}
