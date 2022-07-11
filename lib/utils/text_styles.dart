import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class TextStyles{

  static TextStyle middleDarkGrayw300(final double size){
    return TextStyle(
      fontFamily: 'SimplyRounded',
      fontSize: size,
      fontWeight: FontWeight.w300,
      color: ThemeColors.middleDarkGray
    );
  }

  static TextStyle lightGrayw400(final double size){
    return TextStyle(
      fontFamily: 'SimplyRounded',
      fontSize: size,
      color: ThemeColors.lightGray,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle blackw700(final double size){
    return TextStyle(
      fontFamily: 'SimplyRounded',
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: ThemeColors.black
    );
  }

  static TextStyle blackw500(final double size){
    return TextStyle(
      fontFamily: 'SimplyRounded',
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: ThemeColors.lightBlack
    );
  }

  static TextStyle whitew700(final double size){
    return TextStyle(
      fontFamily: 'SimplyRounded',
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: Colors.white
    );
  }

  static TextStyle whitew400(final double size){
    return TextStyle(
      fontFamily: 'SimplyRounded',
      fontSize: size,
      fontWeight: FontWeight.w400,
      color: Colors.white
    );
  }

  static TextStyle lightBlackw400(final double size){
    return TextStyle(
      fontFamily: 'SimplyRounded',
      fontSize: size,
      fontWeight: FontWeight.w400,
      color: ThemeColors.lightBlack
    );
  }
}