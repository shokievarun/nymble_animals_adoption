import 'package:flutter/material.dart';


abstract class ThemeColors{

  // Normal Colors
  static const Color lightGray = Color(0xFFC2C3CA);
  static const Color middleDarkGray = Color(0xFFA6A7AD);
  static const Color darkGray = Color(0xFF4B4B4B);
  static const Color black = Color(0xFF242424);
  static const Color lightBlack = Color(0xFF424242);
  static const Color containerWhite = Color(0xFFFFFFFF);
  static const Color containersGray = Color(0xB6FFFFFF);

  // Animals data containers
  static const Color containerBackground1 = Color(0xffd4e8c1);
  static const Color containerBackground2 = Color(0xfffee8c2);
  static const Color containerBackground3 = Color(0xffc2ebfe);

  // New colors
  static const Color infoContainerBackgroundGray = Color.fromARGB(255, 226, 226, 226);
  static const Color accent = Color(0xff8cbaf0);
  static const Color accentForText = Color(0xFF4A9BF8);
  static const Color redForBackground = Color(0xfff8cfdf);
  static const Color redForText = Color(0xFFFF6078);

  // Gradients
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [accent, accentForText],
  );

  static const List<List<Color>> gradients = [
    [Color(0xffff9966), Color(0xffff5e62)],
    [Color(0xffff512f), Color(0xfff09819)],
    [Color(0xff8E2DE2), Color(0xff4A00E0)],
    [Color(0xff16a085), Color(0xfff4d03f)],
    [Color(0xff4e54c8), Color(0xff8f94fb)],
    [Color(0xffDAD299), Color(0xff8CA6DB)],
    [Color(0xffCAC531), Color(0xffF3F9A7)],
  ];

  static const List<Color> containersBackground = [
    Color(0xff898AA6),
    Color(0xff6E85B7),
    Color(0xffB2C8DF),
    Color(0xff66BFBF),
    Color(0xffC9BBCF),
    Color(0xff8879B0),
    Color(0xff9CB4CC),
    Color(0xff54BAB9),
    Color(0xffFF7396),
    Color(0xff774360),
    Color(0xff51557E),
    Color(0xffDF7861),
    Color(0xffF2D1D1),
    Color(0xffF5DF99),
    Color(0xffEF9F9F),
  ];
}