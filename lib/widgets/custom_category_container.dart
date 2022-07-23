import 'dart:ui';
import 'package:animals_adoption_flutter/models/category_model.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:flutter/material.dart';


class CategoryContainer extends StatefulWidget {

  final Function(CategoryModel) onTapFunction;
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

    double elevationQuantity = 0;
    if(widget.isSelected){
      elevationQuantity = lerpDouble(0, _responsive.hp(0.08), animation!.value)!;
    }
    
    return GestureDetector(
      onTap: (){
        widget.onTapFunction(widget.category);
        controller!.forward();
      },
      child: Transform(
        transform: Matrix4.identity()..translate(
          0,
          elevationQuantity
        ),
        child: AnimatedScale(
          scale: widget.scale,
          duration: const Duration(milliseconds: 250),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Image.asset(
                  widget.category.imagePath, 
                  fit: BoxFit.fill,
                  scale: 1,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.backgroundColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: _responsive.hp(0.1), horizontal: _responsive.wp(1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.category.name, style: TextStyles.whitew700(_responsive.dp(1.5)), textAlign: TextAlign.center, maxLines: 1),
                        Text(widget.category.description, style: TextStyles.whitew600(_responsive.dp(0.9)), textAlign: TextAlign.center, maxLines: 1),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}