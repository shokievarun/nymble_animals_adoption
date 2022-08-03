import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
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
      child: Container(
        decoration: BoxDecoration(
          color: isSelected! ? ThemeColors.accent.withOpacity(0.35) : Colors.transparent,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: _responsive.dp(2.5),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(icon),
              color: isSelected! ? ThemeColors.accentForText : ThemeColors.lightBlack, 
              onPressed: onPressCallback!
            ),
            Text(
              routeName.isEmpty ? 'Home' : routeName[0].toUpperCase() + routeName.substring(1), 
              style: TextStyles.greyBold(_responsive.dp(1)).copyWith(color: isSelected! ? ThemeColors.accentForText : ThemeColors.lightBlack)
            ),
          ],
        ),
      ),
    );
  }
}