import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:animals_adoption_flutter/models/category_model.dart';
import 'package:animals_adoption_flutter/utils/animations/basic_custom_animation.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';

class CategoryContainer extends StatefulWidget {
  final Function(CategoryModel) onTapFunction;
  final CategoryModel category;

  final double scale;
  final bool isSelected;

  const CategoryContainer({
    Key? key,
    required this.onTapFunction,
    required this.category,
    required this.scale,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer>
    with SingleTickerProviderStateMixin {
  BasicCustomAnimation? _animator;

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

    if (widget.isSelected) _animator!.controller!.forward();
    super.initState();
  }

  void _animationListener() => setState(() {});

  void _animationStatusListener(final AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animator!.controller!.reverse();
    } else if (status == AnimationStatus.dismissed && widget.isSelected) {
      _animator!.controller!.forward();
    }
  }

  @override
  void dispose() {
    _animator!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    double elevationQuantity = widget.isSelected
        ? lerpDouble(0, _responsive.hp(0.5), _animator!.controller!.value)!
        : 0;

    return Transform.translate(
      offset: Offset(0, elevationQuantity),
      child: AnimatedScale(
        scale: widget.scale,
        duration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: () {
            widget.onTapFunction(widget.category);
            _animator!.controller!.forward();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _responsive.wp(2.25),
              vertical: _responsive.hp(1),
            ),
            decoration: BoxDecoration(
                color: ThemeColors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: containerShadows),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      widget.category.imagePath,
                      fit: BoxFit.cover,
                      cacheWidth: 260,
                      cacheHeight: 260,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.category.name,
                            style:
                                TextStyles.blackSemiBold(_responsive.dp(1.75)),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                        Text(
                          widget.category.description,
                          style: TextStyles.greySemiBold(_responsive.dp(1.15)),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
