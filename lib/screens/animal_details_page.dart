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
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);


    final double targetAnimationValue = (_responsive.hp(60));
    final double? dataContainerHeightValue = lerpDouble(_responsive.height, targetAnimationValue, _animation!.value);
    final double? dataContainerScaleValue = lerpDouble(0.7, 1, _animation!.value);

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: _responsive.tPadding, bottom: _responsive.bPadding, left: _responsive.sPadding, right: _responsive.sPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Back button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _responsive.hp(5),
                      width: _responsive.wp(33) - _responsive.sPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          CustomBackButton(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _responsive.hp(5),
                      width: _responsive.wp(33),
                      child: Center(
                        child: Text('Details', style: TextStyles.blackw700(_responsive.dp(2)))
                      )
                    ),
                  ],
                ),

                SizedBox(height: _responsive.hp(5)),

                // Animal images
                Hero(
                  tag: widget.animal.imagePath,
                  transitionOnUserGestures: false,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: _responsive.hp(40),
                      width: _responsive.wp(100),
                      child: Image.network(
                        widget.animal.imagePath,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

          // Data container
          Padding(
            padding: EdgeInsets.only(left: _responsive.sPadding, right: _responsive.sPadding, bottom: _responsive.bPadding),
            child: Transform.scale(
              scale: dataContainerScaleValue!,
              child: Transform.translate(
                offset: Offset(0, dataContainerHeightValue!),
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
                                Text(widget.animal.name, style: TextStyles.blackw900(_responsive.dp(3))),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_sharp, color: ThemeColors.accentForText, size: _responsive.dp(1.25)),
                                    Text(widget.animal.location, style: TextStyles.middleDarkGrayw500(_responsive.dp(1.25)).copyWith(color: ThemeColors.accentForText)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          CustomFavoriteButton(size: _responsive.dp(4))
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
                                Text('Female', style: TextStyles.blackw700(_responsive.dp(1.5))),
                                Text('Sex', style: TextStyles.lightGrayw600(_responsive.dp(1.25))),
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
                                Text('1 Years', style: TextStyles.blackw700(_responsive.dp(1.5))),
                                Text('Age', style: TextStyles.lightGrayw600(_responsive.dp(1.25))),
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
                                Text('15 Kg', style: TextStyles.blackw700(_responsive.dp(1.5))),
                                Text('Weight', style: TextStyles.lightGrayw600(_responsive.dp(1.25))),
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
                                Text('Francisco', style: TextStyles.blackw700(_responsive.dp(1.5))),
                                Text('${widget.animal.name} owner.', style: TextStyles.lightGrayw600(_responsive.dp(1.25))),
                              ],
                            ),
                          ),
                          SizedBox(height: _responsive.hp(2.5)),
                          Expanded(
                            flex: 1,
                            child:  Icon(Icons.message_rounded, color: ThemeColors.accentForText, size: _responsive.dp(2))
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
                          Text('Description:', style: TextStyles.blackw700(_responsive.dp(1.5))),
                          Text('Vaccinations up to date, spayed / neutered.', style: TextStyles.lightGrayw600(_responsive.dp(1.25))),
                        ],
                      )
                    ),
                    const Expanded(
                      flex: 15,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}