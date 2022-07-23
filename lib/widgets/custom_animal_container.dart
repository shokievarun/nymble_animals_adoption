import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/screens/animal_details_page.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/widgets/custom_favorite_button.dart';
import 'package:animals_adoption_flutter/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

import '../utils/text_styles.dart';
import '../utils/theme_colors.dart';


class CustomAnimalContainer extends StatefulWidget {

  final AnimalModel animal;


  const CustomAnimalContainer({
    Key? key, 
    required this.animal,
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
    
    return Opacity(
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
              spreadRadius: 2.5,
              blurRadius: 3.5,
              offset: const Offset(0, 7)
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
                  loadingBuilder: (_, child, loadingProgress){
                    if (loadingProgress == null){
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(top: _responsive.hp(1.5), bottom: _responsive.hp(1.5), right: _responsive.wp(2.5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.animal.name, textAlign: TextAlign.center, style: TextStyles.blackw900(_responsive.dp(1.5))),
                    Row(
                      children: [
                        Icon(Icons.location_on_sharp, color: ThemeColors.accentForText, size: _responsive.dp(1.25)),
                        Text('${widget.animal.location} (${widget.animal.distanceInKm} km)', textAlign: TextAlign.center, style: TextStyles.lightBlackw600(_responsive.dp(1))),
                      ],
                    ),
                    SizedBox(height: _responsive.hp(1)),
                    Text(widget.animal.description, textAlign: TextAlign.center, style: TextStyles.lightBlackw600(_responsive.dp(1)), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextButton(
                          text: 'Details', 
                          textColor: ThemeColors.accentForText,
                          backgroundColor: ThemeColors.accent,
                          textSize: _responsive.dp(1),
                          onPressedCallback: () => Navigator.push(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}