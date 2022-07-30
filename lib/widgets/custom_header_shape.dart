import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';


class CustomHeaderShape extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {

  Paint paint0 = Paint()
      ..color = ThemeColors.accent
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
     
         
    Path path0 = Path();
    path0.moveTo(0,0);
    path0.lineTo(0,size.height * 0.2740000);
    path0.quadraticBezierTo(size.width * 0.2582375, size.height * 0.4181600, size.width * 0.4701500, size.height * 0.2402200);
    path0.quadraticBezierTo(size.width * 0.7344875, size.height * 0.4001600, size.width, size.height * 0.1740000);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width * 0.4125000, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
