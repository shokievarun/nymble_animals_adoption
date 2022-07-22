import 'dart:math';

import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/constants/assets_paths.dart';

import 'package:animals_adoption_flutter/widgets/custom_animal_container.dart';
import 'package:animals_adoption_flutter/widgets/custom_category_container.dart';
import 'package:animals_adoption_flutter/widgets/custom_bottom_navigator_bar.dart';

import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/models/category_model.dart';

class HomePage extends StatefulWidget {

  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Controllers
  PageController? _categoriesController; 

  // Variables
  List<AnimalModel>? _animalsToShow;

  int _currentPage = 1;
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    _categoriesController = PageController(
      initialPage: _currentPage, 
      viewportFraction: 1 / 3,
    )..addListener(() {
      _currentPage = _categoriesController!.page!.round();
    });
    _selectedCategory = categories[_currentPage];
    _getAnimalsToShow();
    super.initState();
  }

  void _onPageChange(int newIndex, final CategoryModel category){
    if(newIndex == _currentPage){
      return;
    }
    setState(() {
      _currentPage = newIndex;
      _selectedCategory = category;
      _getAnimalsToShow();
    });
    newIndex = newIndex + (newIndex == 0 ? 1 : newIndex == categories.length - 1 ? -1 : 0);
    _categoriesController!.animateToPage(newIndex, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  void _getAnimalsToShow(){
    _animalsToShow = animals.where((a) => a.category.name == _selectedCategory!.category.name).toList();
  }

  @override
  void dispose() {
    _categoriesController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);


    Widget _getAnimalList() {

      return _animalsToShow!.isEmpty
        ? Center(
            child: Text('No animals in this category.', style: TextStyles.lightGrayw600(_responsive.dp(1.5)))
          )
        : SizedBox(
            height: _responsive.hp(15) * _animalsToShow!.length,
            width: _responsive.width,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _animalsToShow!.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: false,
              clipBehavior: Clip.none,
              padding: EdgeInsets.zero,
              separatorBuilder: (_, x) => SizedBox(height: _responsive.hp(2)),
              itemBuilder: (_, x){
                
                final Color containerColor = ThemeColors.containersBackground[Random().nextInt(ThemeColors.containersBackground.length - 1)].withOpacity(0.25);
                
                return CustomAnimalContainer(
                  animal: _animalsToShow![x], 
                  backgroundColor: containerColor
                );
              },
            ),
          );
    }

    return CustomScaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('AdoptMe', style: TextStyles.blackw900(_responsive.dp(4))),
                  const Spacer(),
                  Icon(Icons.search_rounded, size: _responsive.dp(3), color: ThemeColors.black),
                  SizedBox(width: _responsive.wp(1)),
                  Icon(Icons.notifications_rounded, size: _responsive.dp(3), color: ThemeColors.black)
                ],
              ),
              
              // Principal announcement
              SizedBox(height: _responsive.hp(2)),
              SizedBox(
                height: _responsive.hp(35),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: _responsive.hp(20),
                      width: _responsive.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: ThemeColors.blueGradient
                      ),
                    ),
                    Positioned(
                      bottom: _responsive.hp(6.5),
                      child: Image.asset(
                        '$animalImagesPath/petadoption.png', 
                        fit: BoxFit.contain,
                        height: _responsive.hp(30),
                        width: _responsive.wp(80),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: _responsive.hp(1), vertical: _responsive.wp(2.35)),
                      child: Container(
                        height: _responsive.hp(10),
                        width: _responsive.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: _responsive.hp(1.5), horizontal: _responsive.wp(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Announcement', style: TextStyles.blackw900(_responsive.dp(1.5)), textAlign: TextAlign.center),
                              SizedBox(height: _responsive.hp(1)),
                              Text('Check all the pets available in our application.', style: TextStyles.lightGrayw600(_responsive.dp(1 )), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Body categories
              SizedBox(height: _responsive.hp(2.5)),
              Text('Location:', style: TextStyles.middleDarkGrayw500(_responsive.dp(1.5)).copyWith(color: ThemeColors.darkGray)),
              Text('Tijuana, BC MX', style: TextStyles.blackw900(_responsive.dp(3))),
              SizedBox(height: _responsive.hp(2.5)),
              Text('Categories:', style: TextStyles.blackw900(_responsive.dp(2))),
              SizedBox(height: _responsive.hp(2.5)),
              SizedBox(
                height: _responsive.hp(15),
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
                      onTapFunction: (category) => _onPageChange(x, category),
                      backgroundColors: ThemeColors.gradients[x].map((e) => e.withOpacity(0.5)).toList(), 
                      category: categories[x], 
                      scale: containerScale, 
                      isSelected: isSelected
                    );
                  },
                ),
              ),
              
              // Pet list
              SizedBox(height: _responsive.hp(3.5)),
              Row(
                children: [
                  Text('Pet list:', style: TextStyles.blackw900(_responsive.dp(2))),
                  if(_animalsToShow!.isNotEmpty)...[
                    const Spacer(),
                    TextButton(
                      child: Text('View all', style: TextStyles.middleDarkGrayw500(_responsive.dp(1.5)).copyWith(color: ThemeColors.accentForText)),
                      onPressed: () => Navigator.of(context).pushNamed('/viewAllAnimals'),
                    )
                  ]
                ],
              ),
              SizedBox(height: _responsive.hp(3.5)),

              // ! Implementar carga de solo 6 items

              _getAnimalList()
            ],
          ),
        ],
      ),
      bottomNavigator: const CustomBottomNavigatorBar()
    );
  }
}