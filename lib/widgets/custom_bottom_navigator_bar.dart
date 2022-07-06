import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';


class CustomBottomNavigatorBar extends StatelessWidget {

  const CustomBottomNavigatorBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: _size.height * 0.1,
        width: _size.width,
        transform: Matrix4.identity()..translate(0, -_size.height * 0.025),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(25)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Expanded(
                flex: 1,
                child: Icon(Icons.home, color: ThemeColors.lightBlack, size: 30),
              ),
              Expanded(
                flex: 1,
                child: Icon(Icons.account_circle_rounded, color: ThemeColors.lightBlack, size: 30),
              ),
              Expanded(
                flex: 1,
                child: Icon(Icons.location_on_rounded, color: ThemeColors.lightBlack, size: 30),
              ),
              Expanded(
                flex: 1,
                child: Icon(Icons.message_rounded, color: ThemeColors.lightBlack, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}