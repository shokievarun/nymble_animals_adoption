import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatefulWidget {
  
  final double size;

  const FavoriteButton({
    Key? key,
    required this.size
  }) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {

  late bool _isPressed;

  @override
  void initState() {
    _isPressed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        setState(() => _isPressed = !_isPressed);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          color: _isPressed ? ThemeColors.redForBackground : ThemeColors.lightGrey,
          shape: BoxShape.circle
        ),
        child: Icon(
          Icons.favorite_border_rounded, 
          size: widget.size * 0.65, 
          color: _isPressed ? ThemeColors.redForText : ThemeColors.lightBlack,
        ),
      ),
    );
  }
}