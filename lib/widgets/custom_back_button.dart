import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';


class CustomBackButton extends StatelessWidget {

  const CustomBackButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return Container(
      height: _responsive.hp(5),
      // width: _responsive.wp(11.5),
      decoration: const BoxDecoration(
        color: ThemeColors.grey,
        shape: BoxShape.circle
      ),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: _responsive.dp(2)
        ), 
        splashRadius: _responsive.hp(3.5),
        color: ThemeColors.middleDarkGrey,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: ThemeColors.grey.withOpacity(0.5),
        splashColor: Colors.transparent,
        disabledColor: Colors.transparent,
        onPressed: Navigator.of(context).pop,
      )
    );
  }
}