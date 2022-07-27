import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';
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

  late AnimationController _infoContainerAnimationController;
  late Animation<double> _infoContainerAnimation;

  late AnimationController _textInformationAnimationController;
  late Animation<double> _textContainerAnimation;


  @override
  void initState() {
    
    _textInformationAnimationController = AnimationController(duration: const Duration(milliseconds: 250), vsync: this);
    _infoContainerAnimationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    _textContainerAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _textInformationAnimationController, 
        curve: Curves.ease
      ))
      ..addListener(() {
        setState(() {
        });
      });
    _infoContainerAnimation = Tween<double>(begin: 1, end: 0).animate(_infoContainerAnimationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed){
          _textInformationAnimationController.forward();
        }
      });
    _infoContainerAnimationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _infoContainerAnimation.removeListener(() { });
    _textInformationAnimationController.removeListener(() { });
    _infoContainerAnimationController.dispose();
    _textInformationAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    final double targetAnimationValue = _responsive.hp(45);
    final double dataContainerHeightValue = lerpDouble(targetAnimationValue, _responsive.height, _infoContainerAnimation.value)!;
    final double dataContainerScaleValue = lerpDouble(1, 0.7, _infoContainerAnimation.value)!;

    final double textPosition = _responsive.wp(50) * _textContainerAnimation.value;

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

                  SizedBox(height: _responsive.hp(2.5)),

                  // Animal images
                  Hero(
                    tag: widget.animal.imagePath,
                    transitionOnUserGestures: false,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: _responsive.hp(40),
                        width: _responsive.wp(100),
                        child: CachedNetworkImage(
                          imageUrl: widget.animal.imagePath,
                          progressIndicatorBuilder: (context, url, downloadProgress) => 
                            CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.fill,
                        )
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
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                    ),
                    child: Opacity(
                      opacity: 1 - _textContainerAnimation.value,
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
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Description:', style: TextStyles.blackw700(_responsive.dp(1.5))),
                                  Text('Vaccinations up to date, spayed / neutered.', style: TextStyles.middleDarkGrayw500(_responsive.dp(1.25))),
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