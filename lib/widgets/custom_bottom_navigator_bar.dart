import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/providers/navigator_bar_provider.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:animals_adoption_flutter/widgets/nav_bar_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
  final List<NavBarItem> _items = [
    NavBarItem(
      icon: Icons.home,
      routeName: '',
    ),
    NavBarItem(
      icon: Icons.timer,
      routeName: 'history',
    ),
    // NavBarItem(
    //   icon: Icons.location_on_rounded,
    //   routeName: 'map',
    // ),
    // NavBarItem(
    //   icon: Icons.message_rounded,
    //   routeName: 'messages',
    // ),
  ];

  CustomBottomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);
    final NavigatorBarProvider _navigatorBarProvider =
        Provider.of<NavigatorBarProvider>(context);

    void _moveToNewRoute(final int index) {
      if (ModalRoute.of(context)?.settings.name ==
          '/${_items[index].routeName}') {
        return;
      }
      _navigatorBarProvider.currentRoute = index;
      Navigator.pushNamed(context, '/${_items[index].routeName}');
    }

    return kIsWeb
        ? Padding(
            padding: const EdgeInsets.only(left: 5),
            // padding: EdgeInsets.only(
            //     bottom: _responsive.bPadding / 2,
            //     left: _responsive.sPadding,
            //     right: _responsive.sPadding),
            child: Container(
              height: kIsWeb ? 130 : _responsive.hp(10),
              width: _responsive.width,
              padding: EdgeInsets.symmetric(
                  horizontal: _responsive.wp(3), vertical: _responsive.wp(2)),
              decoration: BoxDecoration(
                  color: ThemeColors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: containerShadows),
              child: Row(
                children: [
                  for (int x = 0; x < _items.length; x++)
                    _items[x]
                      ..isSelected = x == _navigatorBarProvider.currentRoute
                      ..onPressCallback = () => _moveToNewRoute(x)
                ],
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
                bottom: _responsive.bPadding / 2,
                left: _responsive.sPadding,
                right: _responsive.sPadding),
            child: Container(
              height: _responsive.hp(10),
              width: _responsive.width,
              padding: EdgeInsets.symmetric(
                  horizontal: _responsive.wp(3), vertical: _responsive.wp(2)),
              decoration: BoxDecoration(
                  color: ThemeColors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: containerShadows),
              child: Row(
                children: [
                  for (int x = 0; x < _items.length; x++)
                    _items[x]
                      ..isSelected = x == _navigatorBarProvider.currentRoute
                      ..onPressCallback = () => _moveToNewRoute(x)
                ],
              ),
            ),
          );
  }
}
