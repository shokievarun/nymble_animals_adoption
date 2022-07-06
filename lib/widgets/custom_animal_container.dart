import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:flutter/material.dart';


class CustomAnimalContainer extends StatelessWidget {

  final AnimalModel animal;
  final Color backgroundColor;

  const CustomAnimalContainer({
    Key? key, 
    required this.animal,
    required this.backgroundColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: backgroundColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(animal.name, textAlign: TextAlign.center, style: TextStyles.petTitleList),
                      Text('${animal.location} (${animal.distanceInKm} km)', textAlign: TextAlign.center, style: TextStyles.petSubtitleList),
                    ],
                  ),
                ),
              ),
              Divider(color: backgroundColor),
              Expanded(
                flex: 3,
                child: Image.network(
                  animal.imagePath, 
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}