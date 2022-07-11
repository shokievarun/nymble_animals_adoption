import 'package:animals_adoption_flutter/models/category_model.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:flutter/material.dart';


class CategoryContainer extends StatefulWidget {

  final VoidCallback onTapFunction;
  final List<Color> backgroundColors;
  final CategoryModel category;

  final double scale;
  final bool isSelected;

  const CategoryContainer({
    Key? key, 
    required this.onTapFunction,
    required this.backgroundColors,
    required this.category,
    required this.scale,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> with SingleTickerProviderStateMixin {

  Animation<double>? animation;
  AnimationController? controller;
  
  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: 0, end: 10).animate(controller!)
    ..addListener(() {
      setState(() {
      });
    })
    ..addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller!.reverse();
      }
      else if(status == AnimationStatus.dismissed && widget.isSelected){
        controller!.forward();
      }
    });
    if(widget.isSelected){
      controller!.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);
    
    return GestureDetector(
      onTap: (){
        widget.onTapFunction();
        controller!.forward();
      },
      child: AnimatedScale(
        scale: widget.scale,
        duration: const Duration(milliseconds: 250),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.backgroundColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomRight
            ),
            borderRadius: BorderRadius.circular(25)
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.category.name, style: TextStyles.whitew700(_responsive.dp(2))),
                Text(widget.category.description, style: TextStyles.whitew400(_responsive.dp(0.9))),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: Row(
                    children: [
                      const Spacer(),
                      Image.asset(
                        widget.category.imagePath, 
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}