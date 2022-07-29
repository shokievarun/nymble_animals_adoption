import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

class BasicCustomAnimation{

  late final AnimationController controller;
  late final Animation<double> _animation;

  final VoidCallback listener; 
  final TickerProvider tickerProvider; 

  final void Function(AnimationStatus)? statusListener;
  

  BasicCustomAnimation({
    required this.listener,
    required this.tickerProvider,
    this.statusListener,
    final double? begin,
    final double? end,
    final bool? autoStart,
    final int? durationInMillisec,
  }){
    controller = AnimationController(
      vsync: tickerProvider, 
      duration: Duration(milliseconds: durationInMillisec ?? 450)
    )..addListener(listener);
    if(statusListener != null) controller.addStatusListener(statusListener!);
    if(autoStart ?? true) controller.forward();
    _animation = Tween<double>(begin: begin ?? 0.5, end: end ?? 1).animate(controller);
  }

  double get getValue => _animation.value;

  void dispose(){
    controller.stop();
    if(statusListener != null) controller.removeStatusListener(statusListener!);
    controller.removeListener(listener);
    controller.dispose();
  }
}