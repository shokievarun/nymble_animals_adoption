import 'package:animals_adoption_flutter/utils/animations/basic_custom_animation.dart';
import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';
import 'package:animals_adoption_flutter/widgets/custom_text_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';

import 'package:animals_adoption_flutter/models/animal_model.dart';

import 'package:animals_adoption_flutter/screens/animal_details/widgets/widgets.dart';
import 'package:animals_adoption_flutter/widgets/custom_favorite_button.dart';


class AnimalDetailsPage extends StatefulWidget {

  final AnimalModel animal;

  const AnimalDetailsPage({
    Key? key,
    required this.animal,
  }) : super(key: key);

  @override
  State<AnimalDetailsPage> createState() => _AnimalDetailsPageState();
}

class _AnimalDetailsPageState extends State<AnimalDetailsPage> with TickerProviderStateMixin{


  late final BasicCustomAnimation _infoContainerAnimationController;
  late final BasicCustomAnimation _textInformationAnimationController;

  @override
  void initState() {

    _infoContainerAnimationController = BasicCustomAnimation(
      listener: _animationListener, 
      tickerProvider: this,
      begin: 1,
      end: 0,
      durationInMillisec: 500,
      statusListener: _animationStatusListener
    );

    _textInformationAnimationController = BasicCustomAnimation(
      listener: _animationListener, 
      tickerProvider: this,
      durationInMillisec: 250,
      begin: 1,
      end: 0,
      autoStart: false
    );
    
    super.initState();
  }

  void _animationListener() => setState(() {});

  void _animationStatusListener(final AnimationStatus status) {
    if(status == AnimationStatus.completed) _textInformationAnimationController.controller.forward();
  }

  @override
  void dispose() {
    _infoContainerAnimationController.dispose();
    _textInformationAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    final double targetAnimationValue = _responsive.hp(45);
    final double dataContainerHeightValue = lerpDouble(targetAnimationValue, _responsive.height, _infoContainerAnimationController.getValue)!;
    final double dataContainerScaleValue = lerpDouble(1, 0.7, _infoContainerAnimationController.getValue)!;

    final double textPosition = _responsive.wp(50) * _textInformationAnimationController.getValue;

    return CustomScaffold(
      title: 'Details',
      withBackButton: true,
      body: [
        SizedBox(
          height: _responsive.height - (_responsive.tPadding * 2) - _responsive.hp(5),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Animal images
                  Hero(
                    tag: widget.animal.imagePath,
                    transitionOnUserGestures: false,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        height: _responsive.hp(40),
                        width: _responsive.width,
                        imageUrl: widget.animal.imagePath,
                        progressIndicatorBuilder: (context, url, downloadProgress) => 
                          CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),

              // Data container
              Transform.scale(
                scale: dataContainerScaleValue,
                child: Transform.translate(
                  offset: Offset(0, dataContainerHeightValue),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: _responsive.sPadding, vertical: _responsive.tPadding / 2),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 1,
                          blurRadius: 3.5,
                        )
                      ]
                    ),
                    child: Opacity(
                      opacity: 1 - _textInformationAnimationController.getValue,
                      child: Transform(
                        transform: Matrix4.identity()..translate(
                          textPosition
                        ),
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
                                            Text(widget.animal.location, style: TextStyles.middleDarkGrayw500(_responsive.dp(1.25))),
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
                                children: 
                                  // Get and show props 
                                  widget.animal.dataToShow.entries.map((e) 
                                          => CustomAnimalInfoContainer(dataValue: e.value.toString(), dataName: e.key)).toList()
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
                                        Text('${widget.animal.name} owner.', style: TextStyles.middleDarkGrayw500(_responsive.dp(1.25))),
                                      ],
                                    ),
                                  ),
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
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Description:', style: TextStyles.blackw700(_responsive.dp(1.5))),
                                  Text('Vaccinations up to date, spayed / neutered.', style: TextStyles.middleDarkGrayw500(_responsive.dp(1.25))),
                                ],
                              )
                            ),
                            CustomTextButton(
                              onPressedCallback: () => {},
                              textColor: ThemeColors.accentForText, 
                              backgroundColor: ThemeColors.accent, 
                              text: 'Send message', 
                              textSize: _responsive.dp(1.25)
                            ),
                            const Expanded(
                              flex: 15,
                              child: SizedBox(),
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
        ),
      ],
    );
  }
}