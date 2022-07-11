import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class ResponsiveUtil{

  late double _height;
  late double _width;
  late double _diagonal;

  // late bool _isTablet;
  // late bool _isPhone;

  late double _bottomPadding;
  late double _topPadding;
  late double _sPadding;

  // Getters
  double get height => _height;
  double get width => _width;

  // Paddings
  double get bPadding => _bottomPadding;
  double get tPadding => _topPadding;
  double get sPadding => _sPadding;

  ResponsiveUtil({
    required BuildContext context
  }){
    final Size size = MediaQuery.of(context).size;

    // set variables values
    _diagonal = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    _width = size.width;
    _height = size.height;

    _bottomPadding = bottomPaddingPercent * _height;
    _topPadding = topPaddingPercent * _height;
    _sPadding = sidesPaddingPercent * _width;
  }

  factory ResponsiveUtil.of(BuildContext context) => ResponsiveUtil(context: context);

  double hp(double percent) => _height * percent / 100;
  double wp(double percent) => _width * percent / 100;
  double dp(double percent) => _diagonal * percent / 100;
}