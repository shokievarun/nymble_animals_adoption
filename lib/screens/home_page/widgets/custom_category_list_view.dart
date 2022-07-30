import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/models/category_model.dart';
import 'package:animals_adoption_flutter/screens/home_page/widgets/custom_category_container.dart';
import 'package:animals_adoption_flutter/utils/animations/basic_custom_animation.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';


class CustomCategoryListView extends StatefulWidget {

  final List<CategoryModel> categories;
  final void Function(CategoryModel, int) onPageChangeCallBack;
  final int currentIndex;

  const CustomCategoryListView({
    Key? key,
    required this.categories,
    required this.onPageChangeCallBack,
    required this.currentIndex
    }) : super(key: key);

  @override
  State<CustomCategoryListView> createState() => _CustomCategoryListViewState();
}

class _CustomCategoryListViewState extends State<CustomCategoryListView> with SingleTickerProviderStateMixin{

  late BasicCustomAnimation animator;
  late PageController pageViewController;

  @override
  void initState() {

    animator = BasicCustomAnimation(listener: _animationListener, tickerProvider: this);
    pageViewController = PageController(
      initialPage: widget.currentIndex, 
      viewportFraction: 1 / 3,
    );
    
    super.initState();
  }

  void _onPageChange(int newIndex, final CategoryModel category){

    if(newIndex == widget.currentIndex){
      return;
    }
    widget.onPageChangeCallBack(category, newIndex);
    newIndex = newIndex + (newIndex == 0 ? 1 : newIndex == categories.length - 1 ? -1 : 0);
    animator.controller.reset();
    pageViewController.animateToPage(newIndex, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  void _animationListener() => setState(() {});

  @override
  void dispose() {
    animator.dispose();
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.categories.length,
      controller: pageViewController,
      clipBehavior: Clip.none,
      itemBuilder: (_, x){
        
        // print('Debug in list view index ${widget.currentIndex}');
        final bool isSelected = widget.currentIndex == x;
        final double containerScale = isSelected  ? 1.10 : 0.8;
        
        double elevation = 0; 
        if(isSelected) elevation = -_responsive.hp(1.5) * animator.getValue;
        
        return Transform.translate(
          offset: Offset(0, elevation),
          child: CategoryContainer(
            onTapFunction: (category) => _onPageChange(x, category),
            backgroundColors: ThemeColors.gradients[x].map((e) => e.withOpacity(0.5)).toList(), 
            category: categories[x], 
            scale: containerScale, 
            isSelected: isSelected
          ),
        );
      },
    );
  }
}