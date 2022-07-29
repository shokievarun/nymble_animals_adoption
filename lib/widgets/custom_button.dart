import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {

  final IconData icon;
  final double size;

  const CustomButton({
    Key? key,
    required this.icon,
    required this.size,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

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
        decoration: const BoxDecoration(
          color: ThemeColors.grey,
          shape: BoxShape.circle
        ),
        child: Icon(
          widget.icon, 
          size: widget.size * 0.65, 
          color: ThemeColors.black,
        ),
      ),
    );
  }
}