import 'package:animals_adoption_flutter/providers/navigator_bar_provider.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/widgets/bottom_navigator_bar_item.dart';
import 'package:flutter/material.dart';


class CustomBottomNavigatorBar extends StatelessWidget {

  final List<NavBarItem> items = [
    NavBarItem(
      icon: Icons.home,
      routeName: 'home',
    ),
    NavBarItem(
      icon: Icons.account_circle_rounded,
      routeName: 'profile',
    ),
    NavBarItem(
      icon: Icons.location_on_rounded,
      routeName: 'map',
    ),
    NavBarItem(
      icon: Icons.message_rounded,
      routeName: 'messages',
    ),
  ];

  CustomBottomNavigatorBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);
    final NavigatorBarProvider _navigatorBarProvider = Provider.of<NavigatorBarProvider>(context);


    void _moveToNewRoute(final int index){
      if(ModalRoute.of(context)?.settings.name == '/${items[index].routeName}'){
        return;
      }
      _navigatorBarProvider.currentRoute = index;
      Navigator.pushNamed(context, '/${items[index].routeName}');
    }

    return Padding(
      padding: EdgeInsets.only(top: _responsive.tPadding, bottom: _responsive.bPadding, left: _responsive.sPadding, right: _responsive.sPadding),
      child: Container(
        height: _responsive.hp(10),
        width: _responsive.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3)
            )
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            children: [
               for(int x = 0; x < items.length; x++) 
                items[x]..isSelected = x == _navigatorBarProvider.currentRoute
                        ..onPressCallback = () => _moveToNewRoute(x)
            ],
          )
        ),
      ),
    );
  }
}