import 'package:animals_adoption_flutter/screens/home_page/home_page.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class HeaderBackButton extends StatelessWidget {
  const HeaderBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return Container(
        height: _responsive.hp(5),
        // width: _responsive.wp(11.5),
        decoration: BoxDecoration(
            color: ThemeColors.lightGrey.withOpacity(0.3),
            shape: BoxShape.circle),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: _responsive.dp(2)),
          splashRadius: _responsive.hp(3.5),
          // color: ThemeColors.lightBlack,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: ThemeColors.lightBlack.withOpacity(0.1),
          splashColor: Colors.transparent,
          disabledColor: Colors.transparent,
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return HomePage();
            }), (e) => false);
          },
        ));
  }
}
