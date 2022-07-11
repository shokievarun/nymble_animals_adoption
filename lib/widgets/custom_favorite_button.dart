import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class CustomFavoriteButton extends StatelessWidget {

  const CustomFavoriteButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return Container(
      height: _responsive.hp(5),
      width: _responsive.wp(12),
      decoration: BoxDecoration(
        color: ThemeColors.redForBackground,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Icon(
        Icons.favorite_border_rounded, 
        size: _responsive.dp(2.5), 
        color: ThemeColors.redForText
      ),
    );
  }
}