import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';

abstract class TextStyles{

  static const TextStyle titleInformation = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: ThemeColors.middleDarkGray
  );

  static const TextStyle titleData = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 25,
    fontWeight: FontWeight.w700,
    color: ThemeColors.black
  );

  static const TextStyle principalContainerTitle = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Colors.white
  );

  static const TextStyle bodySubtitle = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: ThemeColors.darkGray
  );

  static const TextStyle categoryTitle = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: ThemeColors.containerWhite
  );

  static const TextStyle categorySubtitle = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: ThemeColors.containersGray
  );


  // Pet list styles
  static const TextStyle petTitleList = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: ThemeColors.black
  );

  static const TextStyle petSubtitleList = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 8,
    fontWeight: FontWeight.w400,
    color: ThemeColors.lightBlack
  );

  static const TextStyle lightBlack18size = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: ThemeColors.lightBlack
  );


  static const TextStyle animalDataSubtitle = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: ThemeColors.lightBlack
  );

  // New styles format
  
  static const TextStyle lightBlack16size = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ThemeColors.lightBlack
  );

  static const TextStyle lightGray14size = TextStyle(
    fontFamily: 'SimplyRounded',
    fontSize: 12,
    color: ThemeColors.lightGray,
    fontWeight: FontWeight.w400,
  );
}