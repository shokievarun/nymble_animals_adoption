import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';


import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/screens/animal_details/animal_details_page.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/widgets/custom_favorite_button.dart';
import 'package:animals_adoption_flutter/widgets/custom_text_button.dart';

import '../utils/text_styles.dart';
import '../utils/theme_colors.dart';


class CustomAnimalContainer extends StatefulWidget {

  final AnimalModel animal;
  final bool? showInVertical;
  final bool? withHeroAnimation;

  const CustomAnimalContainer({
    Key? key, 
    required this.animal,
    this.showInVertical,
    this.withHeroAnimation
  }) : super(key: key);

  @override
  State<CustomAnimalContainer> createState() => _CustomAnimalContainerState();
}

class _CustomAnimalContainerState extends State<CustomAnimalContainer> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    Widget getAnimalImages(){
      return CachedNetworkImage(
        imageUrl: widget.animal.imagePath,
        progressIndicatorBuilder: (context, url, downloadProgress) => 
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(value: downloadProgress.progress, color: ThemeColors.accentForText, backgroundColor: ThemeColors.accent.withOpacity(0.5))
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
            child: widget.withHeroAnimation ?? false 
             ? Hero(
              tag: widget.animal.imagePath,
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
              Text(widget.animal.name, textAlign: TextAlign.center, style: TextStyles.blackw900(_responsive.dp(1.5))),
              SizedBox(height: _responsive.hp(1)),
              Text(
                widget.animal.description, 
                textAlign: TextAlign.center, 
                style: TextStyles.lightBlackw600(_responsive.dp(1)), 
                maxLines: widget.showInVertical ?? false ? 3 : 2, 
                overflow: TextOverflow.ellipsis
              ),
              Row(
                children: [
                  Icon(Icons.location_on_sharp, color: ThemeColors.accentForText, size: _responsive.dp(1.25)),
                  Text('${widget.animal.location} (${widget.animal.distanceInKm} km)', textAlign: TextAlign.center, style: TextStyles.lightBlackw600(_responsive.dp(1))),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextButton(
                    text: 'Details', 
                    textColor: ThemeColors.accentForText,
                    backgroundColor: ThemeColors.accent,
                    textSize: _responsive.dp(1),
                    onPressedCallback: () async => await Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => AnimalDetailsPage(animal: widget.animal))
                    ), 
                  ),
                  const Spacer(),
                  CustomFavoriteButton(size: _responsive.dp(3))
                ],
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
            offset: const Offset(0, 1.5)
          )
        ]
      ),
      child: 
        widget.showInVertical ?? false
          ? Column(children: getAnimalInformationWidget())
          : Row(children: getAnimalInformationWidget())
    );
  }
}