import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';


class CustomBottomNavigatorBar extends StatelessWidget {

  const CustomBottomNavigatorBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return Padding(
      padding: EdgeInsets.only(top: _responsive.tPadding, bottom: _responsive.bPadding, left: _responsive.sPadding, right: _responsive.sPadding),
      child: Opacity(
        opacity: 0.8,
        child: Container(
          height: _responsive.hp(10),
          width: _responsive.width,
          decoration: BoxDecoration(
            color: ThemeColors.infoContainerBackgroundGray,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(Icons.home, color: ThemeColors.accentForText, size: _responsive.dp(2.5)),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.account_circle_rounded, color: ThemeColors.black, size: _responsive.dp(2.5)),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.location_on_rounded, color: ThemeColors.black, size: _responsive.dp(2.5)),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.message_rounded, color: ThemeColors.black, size: _responsive.dp(2.5)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}