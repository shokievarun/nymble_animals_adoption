import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:flutter/material.dart';

import '../utils/theme_colors.dart';


class NavBarItem extends StatelessWidget {

  final IconData icon;
  final String routeName;

  VoidCallback? onPressCallback;
  bool? isSelected;

  NavBarItem({
    Key? key,
    required this.icon,
    required this.routeName,
    this.onPressCallback,
    this.isSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return Expanded(
      flex: 1,
      child: IconButton(
        icon: Icon(icon, size: isSelected! ? _responsive.dp(3.5) : _responsive.dp(2.5)),
        color: isSelected! ? ThemeColors.accentForText : ThemeColors.black, 
        onPressed: onPressCallback!
      ),
    );
  }
}