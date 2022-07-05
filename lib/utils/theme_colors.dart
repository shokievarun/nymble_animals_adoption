import 'package:flutter/material.dart';


abstract class ThemeColors{

  // Normal Colors
  static const Color lightGray = Color(0xFFC2C3CA);
  static const Color middleDarkGray = Color(0xFFA6A7AD);
  static const Color darkGray = Color(0xFF4B4B4B);
  static const Color accent = Color(0xff548CFF);

  // Gradients
  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF68A9FF), Color(0xff2F80ED)],
  );
}