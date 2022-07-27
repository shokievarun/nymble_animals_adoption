import 'package:animals_adoption_flutter/screens/all_animals/list_of_animals_page.dart';
import 'package:animals_adoption_flutter/utils/animations/fade_animation.dart';
import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';
import 'package:animals_adoption_flutter/widgets/custom_animal_container.dart';
import 'package:animals_adoption_flutter/widgets/custom_bottom_navigator_bar.dart';
import 'package:animals_adoption_flutter/widgets/custom_text_button.dart';

import 'widgets/widgets.dart';

import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/models/category_model.dart';
import 'package:animals_adoption_flutter/constants/constants.dart';

class HomePage extends StatefulWidget {

  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  // Controllers
  PageController? _categoriesController; 
  late FadeAnimationController _fadeAnimationController;

  // Variables
  List<AnimalModel>? _animalsToShow;

  int _currentPage = 1;
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    _fadeAnimationController = FadeAnimationController(
      listener: animationListener, 
      tickerProvider: this
    );
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

  void animationListener(){
    setState(() {
      print(_fadeAnimationController.animation.value);
    });
  }

  @override
  void dispose() {
    _categoriesController!.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);


    Widget _getAnimalList() {

      final int _itemsToShow = _animalsToShow!.length > 6 ? 6 : _animalsToShow!.length;

      return _animalsToShow!.isEmpty
        ? Center(
            child: Text('No animals in this category.', style: TextStyles.lightGreyw600(_responsive.dp(1.5)))
          )
        : Opacity(
          opacity: _fadeAnimationController.animation.value,
          child: SizedBox(
              height: _responsive.hp(15) * _itemsToShow,
              width: _responsive.width,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _itemsToShow + 1,
                scrollDirection: Axis.vertical,
                shrinkWrap: false,
                clipBehavior: Clip.none,
                padding: EdgeInsets.zero,
                separatorBuilder: (_, x) => SizedBox(height: _responsive.hp(2)),
                itemBuilder: (_, x){
                  if(x + 1 < _itemsToShow){
                    return CustomAnimalContainer(
                      animal: _animalsToShow![x],
                      withHeroAnimation: true,
                    );
                  }
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: ((context) => ListOfAnimalsPage(animalsToShow: _animalsToShow!)))
                      );
                    },
                    child: Container(
                      height: _responsive.hp(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ThemeColors.middleDarkGrey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text('Press to see all the animals.', style: TextStyles.blackw700(_responsive.dp(1.5)).copyWith(color: ThemeColors.middleDarkGrey))
                    ),
                  );
                },
              ),
            ),
        );
    }

    return CustomScaffold(
      body: [
          Stack(
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
                      Icon(Icons.notifications_rounded, size: _responsive.dp(3), color: ThemeColors.black)
                    ],
                  ),
                  
                  // Principal announcement
                  SizedBox(height: _responsive.hp(2)),
                  const CustomAnnouncementsGalery(),
                  
                  // Body categories
                  SizedBox(height: _responsive.hp(2.5)),
                  Text('Location:', style: TextStyles.middleDarkGrayw500(_responsive.dp(1.5)).copyWith(color: ThemeColors.darkGrey)),
                  Text('Tijuana, BC MX', style: TextStyles.blackw900(_responsive.dp(2.5))),
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
                        CustomTextButton(
                          text: 'View all', 
                          textColor: ThemeColors.lightGrey,
                          backgroundColor: ThemeColors.middleDarkGrey,
                          textSize: _responsive.dp(1.25),
                          onPressedCallback: () async => await Navigator.of(context).push(
                            MaterialPageRoute(builder: ((context) => ListOfAnimalsPage(animalsToShow: _animalsToShow!)))
                          )
                        )
                      ]
                    ],
                  ),
                  SizedBox(height: _responsive.hp(3.5)),
                  _getAnimalList(),
                  SizedBox(height: _responsive.hp(3.5)),
                ],
              ),
            ],
          ),
        ],
      bottomNavigator: CustomBottomNavigatorBar()
    );
  }
}