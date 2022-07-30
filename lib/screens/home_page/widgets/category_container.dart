import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:animals_adoption_flutter/models/category_model.dart';
import 'package:animals_adoption_flutter/utils/animations/basic_custom_animation.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';

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

  late final BasicCustomAnimation _animator;

  @override
  void initState() {
    _animator = BasicCustomAnimation(
      listener: _animationListener,
      tickerProvider: this,
      statusListener: _animationStatusListener,
      durationInMillisec: 300,
      begin: 0,
      end: 1,
      autoStart: false,
    );

    if (widget.isSelected) _animator.controller.forward();
    super.initState();
  }

  void _animationListener() => setState(() {});

  void _animationStatusListener(final AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animator.controller.reverse();
    } else if (status == AnimationStatus.dismissed && widget.isSelected) {
      _animator.controller.forward();
    }
  }

  @override
  void dispose() {
    _animator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    double elevationQuantity = widget.isSelected
        ? lerpDouble(0, _responsive.hp(0.5), _animator.controller.value)!
        : 0;

    return Transform.translate(
      offset: Offset(0, elevationQuantity),
      child: AnimatedScale(
        scale: widget.scale,
        duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: () {
            widget.onTapFunction(widget.category);
            _animator.controller.forward();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _responsive.wp(2.5),
              vertical: _responsive.hp(2),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: widget.backgroundColors,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Image.asset(
                    widget.category.imagePath,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: _responsive.hp(0.1),
                      horizontal: _responsive.wp(1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.category.name,
                          style: TextStyles.whitew900(_responsive.dp(2)),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                        Text(
                          widget.category.description,
                          style: TextStyles.whitew600(_responsive.dp(1.15)),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
