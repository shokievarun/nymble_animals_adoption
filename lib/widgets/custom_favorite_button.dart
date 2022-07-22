import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class CustomFavoriteButton extends StatefulWidget {
  
  final double size;

  const CustomFavoriteButton({
    Key? key,
    required this.size
  }) : super(key: key);

  @override
  State<CustomFavoriteButton> createState() => _CustomFavoriteButtonState();
}

class _CustomFavoriteButtonState extends State<CustomFavoriteButton> {

  bool? _isPressed;

  @override
  void initState() {
    _isPressed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return GestureDetector(
      onTap: (){
        setState(() {
          _isPressed = !_isPressed!;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          color: _isPressed! ? ThemeColors.redForBackground : ThemeColors.lightGray.withOpacity(0.5),
          shape: BoxShape.circle
        ),
        child: Icon(
          Icons.favorite_border_rounded, 
          size: widget.size * 0.70, 
          color: _isPressed! ? ThemeColors.redForText : ThemeColors.lightBlack.withOpacity(0.5)
        ),
      ),
    );
  }
}