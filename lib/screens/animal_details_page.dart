import 'dart:ui';
import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:animals_adoption_flutter/widgets/custom_back_button.dart';
import 'package:animals_adoption_flutter/widgets/custom_favorite_button.dart';
import 'package:flutter/material.dart';


class AnimalDetailsPage extends StatefulWidget {

  final AnimalModel animal;

  const AnimalDetailsPage({
    Key? key,
    required this.animal,
  }) : super(key: key);

  @override
  State<AnimalDetailsPage> createState() => _AnimalDetailsPageState();
}

class _AnimalDetailsPageState extends State<AnimalDetailsPage> with SingleTickerProviderStateMixin{

  late AnimationController? _animationController;
  late Animation<double>? _animation;


  @override
  void initState() {
    _animationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
    ..addListener(() {
      setState(() {
      });
    });
    _animationController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    final Size _size = MediaQuery.of(context).size;

    final double targetAnimationValue = (_size.height * 0.45) - _responsive.bPadding;
    final double? dataContainerHeightValue = lerpDouble(_size.height, targetAnimationValue, _animation!.value);
    final double? dataContainerScaleValue = lerpDouble(0.7, 1, _animation!.value);

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.animal.imagePath,
            transitionOnUserGestures: false,
            child: SizedBox(
              height: _responsive.hp(50),
              width: _responsive.width,
              child: Image.network(
                widget.animal.imagePath,
                fit: BoxFit.fill,                
              ),
            ),
          ),

          Positioned(
            left: _responsive.sPadding,
            top: _responsive.tPadding,
            child: const CustomBackButton()
          ),

          // Data container
          Padding(
            padding: EdgeInsets.only(left: _responsive.sPadding, right: _responsive.sPadding),
            child: Transform.scale(
              scale: dataContainerScaleValue!,
              child: Transform.translate(
                offset: Offset(0, dataContainerHeightValue!),
                child: Container(
                  height: _responsive.hp(53),
                  width: _responsive.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: ThemeColors.infoContainerBackgroundGray,
                    border: Border.all(color: ThemeColors.accent, width: _responsive.wp(0.25))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
            
                        // Name, location and favorite button
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget.animal.name, style: TextStyles.blackw700(_responsive.dp(3))),
                                    Text(widget.animal.location, style: TextStyles.middleDarkGrayw300(_responsive.dp(1.5))),
                                  ],
                                ),
                              ),
                              const CustomFavoriteButton()
                            ],
                          ),
                        ),
            
                        // Data containers, sex, age and weight
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Female', style: TextStyles.blackw500(_responsive.dp(2))),
                                    Text('Sex', style: TextStyles.lightGrayw400(_responsive.dp(1))),
                                  ],
                                ),
                              ),
                              SizedBox(height: _responsive.hp(3.5)),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('1 Years', style: TextStyles.blackw500(_responsive.dp(2))),
                                    Text('Age', style: TextStyles.lightGrayw400(_responsive.dp(1))),
                                  ],
                                ),
                                
                              ),
                              SizedBox(height: _responsive.hp(3.5)),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('15 Kg', style: TextStyles.blackw500(_responsive.dp(2))),
                                    Text('Weight', style: TextStyles.lightGrayw400(_responsive.dp(1))),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ),
            
                        // User data
                        Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Francisco', style: TextStyles.blackw500(_responsive.dp(2))),
                                    Text('${widget.animal.name} owner.', style: TextStyles.lightGrayw400(_responsive.dp(1))),
                                  ],
                                ),
                              ),
                              SizedBox(height: _responsive.hp(2.5)),
                              Expanded(
                                flex: 1,
                                child:  Icon(Icons.message_rounded, color: ThemeColors.accent, size: _responsive.dp(2))
                              ),
                            ],
                          )
                        ),
            
                        // Show description
                        SizedBox(height: _responsive.hp(2)),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Description:', style: TextStyles.blackw500(_responsive.dp(2))),
                              Text('Vaccinations up to date, spayed / neutered.', style: TextStyles.lightGrayw400(_responsive.dp(1))),
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}