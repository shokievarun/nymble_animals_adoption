import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';

abstract class TextStyles{

  static const TextStyle titleInformation = TextStyle(
    fontFamily: 'TypoRound',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ThemeColors.middleDarkGray
  );

  static const TextStyle titleData = TextStyle(
    fontFamily: 'TypoRound',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: ThemeColors.darkGray
  );

  static const TextStyle principalContainerTitle = TextStyle(
    fontFamily: 'TypoRound',
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Colors.white
  );

  static const TextStyle bodySubtitle = TextStyle(
    fontFamily: 'TypoRound',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: ThemeColors.darkGray
  );
}