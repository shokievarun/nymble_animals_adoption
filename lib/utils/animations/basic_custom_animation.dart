import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

class BasicCustomAnimation{

  late AnimationController controller;
  late Animation<double> animation;

  final VoidCallback listener; 
  final TickerProvider tickerProvider; 

  final void Function(AnimationStatus)? statusListener;
  final double? begin;
  final double? end;
  final int? durationInMillisec;
  final bool? autoStart;

  BasicCustomAnimation({
    required this.listener,
    required this.tickerProvider,
    this.statusListener,
    this.begin,
    this.end,
    this.durationInMillisec,
    this.autoStart
  }){
    controller = AnimationController(
      vsync: tickerProvider, 
      duration: Duration(milliseconds: durationInMillisec ?? 450)
    )..addListener(listener);
    if(statusListener != null) controller.addStatusListener(statusListener!);
    if(autoStart ?? true) controller.forward();
    animation = Tween<double>(begin: begin ?? 0.5, end: end ?? 1).animate(controller);
  }

  void dispose(){
    controller.stop();
    if(statusListener != null) controller.removeStatusListener(statusListener!);
    controller.removeListener(listener);
    controller.dispose();
  }
}