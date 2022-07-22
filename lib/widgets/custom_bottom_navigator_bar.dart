import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';


class CustomBottomNavigatorBar extends StatelessWidget {

  const CustomBottomNavigatorBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);


    void _moveToNewRoute(final String routeName){
      if(ModalRoute.of(context)?.settings.name == '/$routeName'){
        return;
      }
      Navigator.pushNamed(context, '/$routeName');
    }

    return Padding(
      padding: EdgeInsets.only(top: _responsive.tPadding, bottom: _responsive.bPadding, left: _responsive.sPadding, right: _responsive.sPadding),
      child: Container(
        height: _responsive.hp(10),
        width: _responsive.width,
        decoration: BoxDecoration(
          color: ThemeColors.containerWhite,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.home, size: _responsive.dp(2.5),),
                  color: ThemeColors.accentForText, 
                  onPressed: () => _moveToNewRoute('home')
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.account_circle_rounded, size: _responsive.dp(2.5),),
                  color: ThemeColors.black, 
                  onPressed: () => _moveToNewRoute('profile')
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.location_on_rounded, size: _responsive.dp(2.5),),
                  color: ThemeColors.black, 
                  onPressed: () => _moveToNewRoute('map')
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.message_rounded, size: _responsive.dp(2.5),),
                  color: ThemeColors.black, 
                  onPressed: () => _moveToNewRoute('messages')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}