import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class TextStyles{


  // w100 ExtraLight
  // w200 Light
  // w300 Regular
  // w400 Medium
  // w500 SemiBold
  // w600 Bold
  // w700 ExtraBold

  // Singleton
  static final TextStyles _textStyles = TextStyles._internal();

  factory TextStyles(){
    return _textStyles;
  }

  TextStyles._internal();

  static TextStyle greySemiBold(final double size){
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: ThemeColors.grey
    );
  }

  static TextStyle greyBold(final double size){
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: size,
      color: ThemeColors.grey,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle lightBlackMedium(final double size){
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: size,
      color: ThemeColors.lightBlack,
      fontWeight: FontWeight.w400,
    );
  }


  static TextStyle blackSemiBold(final double size){
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: ThemeColors.black
    );
  }
  
  static TextStyle blackBold(final double size){
    return TextStyle(
      fontFamily: 'Montserrat',
      fontSize: size,
      fontWeight: FontWeight.w600,
      color: ThemeColors.black
    );
  }

}