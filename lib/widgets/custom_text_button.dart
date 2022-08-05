
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:flutter/material.dart';


class CustomTextButton extends StatelessWidget {

  final VoidCallback onPressedCallback;
  final Color textColor;
  final Color backgroundColor;
  final String text;
  final double textSize;

  const CustomTextButton({
    Key? key,
    required this.onPressedCallback,
    required this.textColor,
    required this.backgroundColor,
    required this.text,
    required this.textSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: onPressedCallback,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15)
          ),
          child: Text(text, style: TextStyles.greySemiBold(textSize).copyWith(color: textColor)),
        ),
      ),
    );
  }
}