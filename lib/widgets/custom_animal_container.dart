import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/screens/animal_details_page.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:flutter/material.dart';

import '../utils/text_styles.dart';
import '../utils/theme_colors.dart';


class CustomAnimalContainer extends StatefulWidget {

  final AnimalModel animal;
  final Color backgroundColor;


  const CustomAnimalContainer({
    Key? key, 
    required this.animal,
    required this.backgroundColor
  }) : super(key: key);

  @override
  State<CustomAnimalContainer> createState() => _CustomAnimalContainerState();
}

class _CustomAnimalContainerState extends State<CustomAnimalContainer> with SingleTickerProviderStateMixin{

  // Animation
  AnimationController? _controller;
  Animation<double>? _fadeValue;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 250)
    )..addListener(() { 
      setState(() {
      });
    })..forward();
    _fadeValue = Tween<double>(begin: 0.15, end: 1).animate(_controller!);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.stop();
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);
    
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => AnimalDetailsPage(animal: widget.animal))
        );
      },
      child: Opacity(
        opacity: _fadeValue!.value,
        child: Container(
          height: _responsive.hp(15),
          width: _responsive.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
              )
            ]
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Hero(
                  tag: widget.animal.imagePath,
                  child: Image.network(
                    widget.animal.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(top: _responsive.hp(2.5), bottom: _responsive.hp(2.5), right: _responsive.wp(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.animal.name, textAlign: TextAlign.center, style: TextStyles.blackw900(_responsive.dp(1.5))),
                      SizedBox(height: _responsive.hp(1)),
                      Text('${widget.animal.location} (${widget.animal.distanceInKm} km)', textAlign: TextAlign.center, style: TextStyles.lightBlackw600(_responsive.dp(1))),
                      const Spacer(),
                      Text('Details', style: TextStyles.middleDarkGrayw500(_responsive.dp(1)).copyWith(color: ThemeColors.accentForText)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}