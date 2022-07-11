import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class CustomFavoriteButton extends StatelessWidget {

  const CustomFavoriteButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size _size = MediaQuery.of(context).size;

    return Container(
      height: _size.height * 0.05,
      width: _size.width * 0.06,
      decoration: BoxDecoration(
        color: ThemeColors.redForBackground,
        borderRadius: BorderRadius.circular(10)
      ),
      child: const Icon(
        Icons.favorite_border_rounded, 
        size: 25, 
        color: ThemeColors.redForText
      ),
    );
  }
}