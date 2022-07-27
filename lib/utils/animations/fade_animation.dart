


import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

class FadeAnimationController{

  late AnimationController controller;
  late Animation<double> animation;

  final VoidCallback listener; 
  final TickerProvider tickerProvider; 

  FadeAnimationController({
    required this.listener,
    required this.tickerProvider
  }){
    controller = AnimationController(
      vsync: tickerProvider, 
      duration: const Duration(milliseconds: 450)
    )..addListener(listener)..forward();
    animation = Tween<double>(begin: 0.05, end: 1).animate(controller);
  }

  void dispose(){
    controller.stop();
    controller.removeListener(listener);
    controller.dispose();
  }
}