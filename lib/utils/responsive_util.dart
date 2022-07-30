import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class ResponsiveUtil{
  
  final double _heightBetweenWidgetsPerc = 2.5;

  double? _height;
  double? _width;
  double? _diagonal;

  // late bool _isTablet;
  // late bool _isPhone;

  double? _bottomPadding;
  double? _topPadding;
  double? _sPadding;

  double? _heightBetweenWidgets;

  // Getters
  double get height => _height!;
  double get width => _width!;

  // Paddings
  double get bPadding => _bottomPadding!;
  double get tPadding => _topPadding!;
  double get sPadding => _sPadding!;
  double get heightSeparator => _heightBetweenWidgets!;

  ResponsiveUtil({
    required BuildContext context
  }){
    final Size size = MediaQuery.of(context).size;

    // set variables values
    _diagonal = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    _width = size.width;
    _height = size.height;

    _bottomPadding = bottomPaddingPercent * _height!;
    _topPadding = topPaddingPercent * _height!;
    _sPadding = sidesPaddingPercent * _width!;

    _heightBetweenWidgets = (_heightBetweenWidgetsPerc / 100) * _height!;
  }

  factory ResponsiveUtil.of(BuildContext context) => ResponsiveUtil(context: context);

  double hp(double percent) => _height! * percent / 100;
  double wp(double percent) => _width! * percent / 100;
  double dp(double percent) => _diagonal! * percent / 100;
}