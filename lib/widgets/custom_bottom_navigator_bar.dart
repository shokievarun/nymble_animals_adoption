import 'package:animals_adoption_flutter/utils/screen_utils.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';


class CustomBottomNavigatorBar extends StatelessWidget {

  const CustomBottomNavigatorBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size _size = MediaQuery.of(context).size;
    final ScreenUtils _screenUtils = ScreenUtils(screenSize: _size);

    return Padding(
      padding: EdgeInsets.only(bottom: _screenUtils.bottomPadding, left: _screenUtils.sidesPadding, right: _screenUtils.sidesPadding, top: _screenUtils.topPadding),
      child: Opacity(
        opacity: 0.8,
        child: Container(
          height: _size.height * 0.1,
          width: _size.width,
          decoration: BoxDecoration(
            color: ThemeColors.infoContainerBackgroundGray,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Expanded(
                  flex: 1,
                  child: Icon(Icons.home, color: ThemeColors.accentForText, size: 25),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.account_circle_rounded, color: ThemeColors.black, size: 25),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.location_on_rounded, color: ThemeColors.black, size: 25),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(Icons.message_rounded, color: ThemeColors.black, size: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}