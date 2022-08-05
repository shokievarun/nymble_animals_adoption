import 'package:animals_adoption_flutter/constants/assets_paths.dart';
import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/utils/animations/basic_custom_animation.dart';
import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';
import 'package:animals_adoption_flutter/widgets/custom_text_button.dart';
import 'package:animals_adoption_flutter/widgets/favorite_button.dart';
import 'dart:ui';

import 'package:animals_adoption_flutter/models/animal_model.dart';

import 'package:animals_adoption_flutter/screens/animal_details/widgets/widgets.dart';
import 'package:animals_adoption_flutter/widgets/get_network_image.dart';


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


  BasicCustomAnimation? _infoContainerAnimationController;
  BasicCustomAnimation? _textInformationAnimationController;

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
    if(status == AnimationStatus.completed) _textInformationAnimationController!.controller!.forward();
  }

  @override
  void dispose() {
    _infoContainerAnimationController!.dispose();
    _textInformationAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    final double targetAnimationValue = _responsive.hp(55);
    final double dataContainerHeightValue = lerpDouble(targetAnimationValue, _responsive.height, _infoContainerAnimationController!.getValue)!;
    final double dataContainerScaleValue = lerpDouble(1, 0.7, _infoContainerAnimationController!.getValue)!;

    final double textPosition = _responsive.wp(50) * _textInformationAnimationController!.getValue;

    return BaseScaffold(
      title: 'Details',
      withBackButton: true,
      body: [
        SizedBox(
          height: _responsive.hp(120) - (_responsive.tPadding * 2) - _responsive.hp(5),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Animal images
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: _responsive.hp(50),
                      width: _responsive.width,
                      decoration: BoxDecoration(
                        color: ThemeColors.white,
                        boxShadow: containerShadows
                      ),
                      child: Hero(
                        tag: widget.animal.imagePath,
                        transitionOnUserGestures: false,
                        child: GetNetworkImage(url: widget.animal.imagePath),
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
                      color: ThemeColors.white,
                      boxShadow: containerShadows
                    ),
                    child: Opacity(
                      opacity: 1 - _textInformationAnimationController!.getValue,
                      child: Transform(
                        transform: Matrix4.identity()..translate(
                          textPosition
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                                  
                            // Name, location and favorite button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget.animal.name, style: TextStyles.blackBold(_responsive.dp(3))),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_sharp, color: ThemeColors.accentForText, size: _responsive.dp(1.25)),
                                        Text(widget.animal.location, style: TextStyles.greySemiBold(_responsive.dp(1.25))),
                                      ],
                                    )
                                  ],
                                ),
                                const Spacer(),
                                FavoriteButton(size: _responsive.dp(4))
                              ],
                            ),
                            SizedBox(height: _responsive.heightSeparator),
                                  
                            // Data containers, sex, age and weight
                            Row(
                              children: 
                                // Get and show props 
                                widget.animal.dataToShow.entries.map((e) 
                                        => Expanded(
                                            child: TextDetailsInfo(
                                              centered: true,
                                              title: e.value.toString(), 
                                              subTitle: e.key
                                            )
                                          )).toList()
                            ),
                            SizedBox(height: _responsive.heightSeparator),
                                  
                            // User data
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextDetailsInfo(title: 'Francisco', subTitle: '${widget.animal.name} owner.'),
                                const  Spacer(),
                                Icon(Icons.message_rounded, color: ThemeColors.accentForText, size: _responsive.dp(2)),
                              ],
                            ),
                            SizedBox(height: _responsive.heightSeparator),
                                  
                            // Show description
                            const TextDetailsInfo(title: 'Description', subTitle: 'Vaccinations up to date, spayed / neutered.'),
                            SizedBox(height: _responsive.heightSeparator),

                            // Location
                            Text('Location:', style: TextStyles.blackSemiBold(_responsive.dp(1.5))),
                            SizedBox(height: _responsive.heightSeparator),
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox(
                                  width: _responsive.width,
                                  child: Image.asset(
                                    '$illustrationsPath/map_test.png',
                                    fit: BoxFit.fitWidth,
                                  )
                                ),
                              ),
                            ),
                            SizedBox(height: _responsive.heightSeparator),
                            
                            CustomTextButton(
                              onPressedCallback: () => {},
                              textColor: ThemeColors.accentForText, 
                              backgroundColor: ThemeColors.accent, 
                              text: 'Send message', 
                              textSize: _responsive.dp(1.25)
                            ),
                            const Expanded(
                              flex: 8,
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