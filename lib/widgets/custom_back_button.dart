import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';


class CustomBackButton extends StatelessWidget {

  const CustomBackButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size _size = MediaQuery.of(context).size;
    
    return Container(
      height: _size.height * 0.05,
      width: _size.width * 0.115,
      decoration: BoxDecoration(
        color: ThemeColors.redForBackground,
        borderRadius: BorderRadius.circular(10)
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded), 
        color: ThemeColors.redForText,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        disabledColor: Colors.transparent,
        onPressed: Navigator.of(context).pop,
      )
    );
  }
}