import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:flutter/cupertino.dart';

class ScreenUtils{

  late double topPadding;
  late double bottomPadding;
  late double sidesPadding;

  ScreenUtils({required Size screenSize}){
    
    topPadding = screenSize.height * topPaddingPercent;
    bottomPadding = screenSize.height * bottomPaddingPercent;
    sidesPadding = screenSize.width * sidesPaddingPercent;
  }
}