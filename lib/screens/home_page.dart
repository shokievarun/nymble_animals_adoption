import 'dart:math';
import 'package:animals_adoption_flutter/constants/assets_paths.dart';
import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:animals_adoption_flutter/widgets/custom_animal_container.dart';
import 'package:animals_adoption_flutter/widgets/custom_category_container.dart';
import 'package:animals_adoption_flutter/widgets/custom_bottom_navigator_bar.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Controllers
  PageController? _categoriesController; 
  PageController? _petsController; 

  // Variables
  int _currentPage = 1;

  @override
  void initState() {

    _categoriesController = PageController(
      initialPage: _currentPage, 
      viewportFraction: 1 / 3,
    )..addListener(() {
      _currentPage = _categoriesController!.page!.round();
    });
    _petsController = PageController(
      initialPage: _currentPage, 
      viewportFraction: 1 / 2,
    );
    super.initState();
  }

  void _onPageChange(int newIndex){
    if(newIndex == _currentPage){
      return;
    }
    setState(() {
      _currentPage = newIndex;
    });
    newIndex = newIndex + (newIndex == 0 ? 1 : newIndex == categories.length - 1 ? -1 : 0);
    _categoriesController!.animateToPage(newIndex, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: _responsive.tPadding, bottom: _responsive.bPadding, left: _responsive.lPadding, right: _responsive.rPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              // Header
              Text('Location:', style: TextStyles.middleDarkGrayw300(_responsive.dp(1.5))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Tijuana, BC MX', style: TextStyles.blackw700(_responsive.dp(3))),
                  const Spacer(),
                  Icon(Icons.search_rounded, size: _responsive.dp(3), color: ThemeColors.darkGray),
                  SizedBox(width: _responsive.wp(1)),
                  Icon(Icons.notifications_rounded, size: _responsive.dp(3), color: ThemeColors.darkGray)
                ],
              ),
      
              // Principal Image
              SizedBox(height: _responsive.hp(2.5)),
              Container(
                height: _responsive.hp(18),
                width: _responsive.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: ThemeColors.blueGradient
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Check all the pets available in our application.', style: TextStyles.whitew700(_responsive.dp(1.5)))
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          '$animalImagesPath/kitty.png', fit: BoxFit.contain,
                          ),
                      ),
                    ),
                  ],
                )
              ),
              
              // Body categories
              SizedBox(height: _responsive.hp(2.5)),
              Text('Categories:', style: TextStyles.blackw700(_responsive.dp(2))),
              SizedBox(height: _responsive.hp(2.5)),
              SizedBox(
                height: _responsive.hp(17.5),
                width: _responsive.width,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  controller: _categoriesController,
                  clipBehavior: Clip.none,
                  itemBuilder: (_, x){
                    
                    final bool isSelected = _currentPage == x;
                    final double containerScale = isSelected  ? 1.10 : 0.8;
                    
                    return CategoryContainer(
                      onTapFunction: () => _onPageChange(x),
                      backgroundColors: ThemeColors.gradients[x].map((e) => e.withOpacity(0.35)).toList(), 
                      category: categories[x], 
                      scale: containerScale, 
                      isSelected: isSelected
                    );
                  },
                ),
              ),
      
              // Pet list
              SizedBox(height: _responsive.hp(2.5)),
              Text('Pet list:', style: TextStyles.blackw700(_responsive.dp(2))),
              SizedBox(
                height: _responsive.hp(20),
                width: _responsive.width,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _petsController,
                  padEnds: false,
                  itemCount: animals.length,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemBuilder: (_, x){
                    
                    final Color containerColor = ThemeColors.containersBackground[Random().nextInt(ThemeColors.containersBackground.length - 1)].withOpacity(0.25);
                    
                    return CustomAnimalContainer(
                      animal: animals[x], 
                      backgroundColor: containerColor
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigatorBar()
    );
  }
}