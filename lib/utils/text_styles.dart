import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class TextStyles{

  // Singleton
  static final TextStyles _textStyles = TextStyles._internal();

  factory TextStyles(){
    return _textStyles;
  }

  TextStyles._internal();

  static TextStyle middleDarkGrayw500(final double size){
    return TextStyle(
      fontFamily: 'Rocko',
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: ThemeColors.middleDarkGrey
    );
  }

  static TextStyle lightGreyw600(final double size){
    return TextStyle(
      fontFamily: 'Rocko',
      fontSize: size,
      color: ThemeColors.lightGrey,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle blackw900(final double size){
    return TextStyle(
      fontFamily: 'Rocko',
      fontSize: size,
      fontWeight: FontWeight.w900,
      color: ThemeColors.black
    );
  }

  static TextStyle blackw700(final double size){
    return TextStyle(
      fontFamily: 'Rocko',
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: ThemeColors.lightBlack
    );
  }

  static TextStyle whitew700(final double size){
    return TextStyle(
      fontFamily: 'Rocko',
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: Colors.white
    );
  }

  static TextStyle whitew600(final double size){
    return TextStyle(
      fontFamily: 'Rocko',
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: Colors.white
    );
  }

  static TextStyle lightBlackw600(final double size){
    return TextStyle(
      fontFamily: 'Rocko',
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: ThemeColors.lightBlack
    );
  }
}