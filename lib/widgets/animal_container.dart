import 'package:animals_adoption_flutter/widgets/favorite_button.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';


import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/screens/animal_details/animal_details_page.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/widgets/custom_text_button.dart';

import '../utils/text_styles.dart';
import '../utils/theme_colors.dart';


class AnimalContainer extends StatelessWidget {

  final AnimalModel animal;
  final bool? showInVertical;
  final bool? withHeroAnimation;

  const AnimalContainer({
    Key? key, 
    required this.animal,
    this.showInVertical,
    this.withHeroAnimation
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    Widget getAnimalImages(){
      return CachedNetworkImage(
        imageUrl: animal.imagePath,
        progressIndicatorBuilder: (context, url, downloadProgress) => 
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: downloadProgress.progress, 
                color: ThemeColors.accentForText, 
                backgroundColor: ThemeColors.accent.withOpacity(0.5)
              )
            ]
          ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }

    List<Widget> getAnimalInformationWidget(){
      return [
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: withHeroAnimation ?? false 
             ? Hero(
              tag: animal.imagePath,
              child: getAnimalImages()
            ) : getAnimalImages(),
          )
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(animal.name, textAlign: TextAlign.center, style: TextStyles.lightBlackw600(_responsive.dp(1.5))),
              Row(
                children: [
                  Icon(Icons.location_on_sharp, color: ThemeColors.accentForText, size: _responsive.dp(1.25)),
                  Text('${animal.location} (${animal.distanceInKm} km)', textAlign: TextAlign.center, style: TextStyles.lightGreyw600(_responsive.dp(1))),
                ],
              ),
              SizedBox(height: _responsive.hp(1)),
              Text(
                animal.description, 
                textAlign: TextAlign.center, 
                style: TextStyles.lightGreyw600(_responsive.dp(1)), 
                maxLines: showInVertical ?? false ? 3 : 2, 
                overflow: TextOverflow.ellipsis
              ),
              const Spacer(),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      text: 'Details', 
                      textColor: ThemeColors.accentForText,
                      backgroundColor: ThemeColors.accent,
                      textSize: _responsive.dp(1),
                      onPressedCallback: () async => await Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => AnimalDetailsPage(animal: animal))
                      ), 
                    ),
                    const Spacer(),
                    FavoriteButton(
                      size: _responsive.dp(3)
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ];
    }
    
    return Container(
      height: _responsive.hp(15),
      padding: EdgeInsets.symmetric(vertical: _responsive.hp(1), horizontal: _responsive.wp(2.5)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2.5,
            blurRadius: 3.5,
          )
        ]
      ),
      child: 
        showInVertical ?? false
          ? Column(children: getAnimalInformationWidget())
          : Row(children: getAnimalInformationWidget())
    );
  }
}