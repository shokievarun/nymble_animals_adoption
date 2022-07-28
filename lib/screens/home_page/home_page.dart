
import 'package:animals_adoption_flutter/bloc/categories/categories_bloc.dart';


import 'package:animals_adoption_flutter/screens/all_animals/list_of_animals_page.dart';
import 'package:animals_adoption_flutter/screens/home_page/widgets/custom_category_list_view.dart';

import 'package:animals_adoption_flutter/utils/animations/fade_animation.dart';

import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';
import 'package:animals_adoption_flutter/widgets/custom_animal_container.dart';
import 'package:animals_adoption_flutter/widgets/custom_bottom_navigator_bar.dart';
import 'package:animals_adoption_flutter/widgets/custom_text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

import 'widgets/widgets.dart';

import 'package:animals_adoption_flutter/models/category_model.dart';

import 'package:animals_adoption_flutter/constants/constants.dart';

class HomePage extends StatefulWidget {

  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  // Controllers
  late FadeAnimationController _fadeAnimationController;

  // Variables

  final CategoriesBloc _categoriesBloc = CategoriesBloc();

  @override
  void initState() {

    _categoriesBloc.add(GetCategories());

    // Animation controllers
    _fadeAnimationController = FadeAnimationController(
      listener: animationListener, 
      tickerProvider: this
    );

    super.initState();
  }

  void _onPageChange(final CategoryModel category, final int newIndex){
    _categoriesBloc.add(OnCategorySelected(index: newIndex, category: category));
    _fadeAnimationController.controller.reset();
    _fadeAnimationController.controller.forward();
    setState(() {
    });
  }

  void animationListener() => setState(() {});

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    Widget _getAnimalList() {

      return BlocBuilder(
        bloc: _categoriesBloc,
        builder: (_, state){
          if(state is CategoriesLoaded){

            if(state.animals == []){
              return Center(
                child: Text('No animals in this category.', style: TextStyles.lightGreyw600(_responsive.dp(1.5)))
              );
            }
            final int animalsToShow = state.animals.length > 5 ? 6 : state.animals.length;
            return SizedBox(
              height: _responsive.hp(15) * animalsToShow,
              width: _responsive.width,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: animalsToShow,
                clipBehavior: Clip.none,
                padding: EdgeInsets.zero,
                separatorBuilder: (_, x) => SizedBox(height: _responsive.hp(2)),
                itemBuilder: (_, x){
                  if(x < animalsToShow - 1){
                    return CustomAnimalContainer(
                      animal: state.animals[x],
                      withHeroAnimation: true,
                    );
                  }
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: ((context) => ListOfAnimalsPage(animalsToShow: state.animals)))
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
            );
          }
          return Container();
        },
      );
    }

    return CustomScaffold(
      body: [
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
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              bloc: _categoriesBloc,
              builder: ((_, state) {
                
                if(state is CategoriesLoading){
                  return Skeleton(
                    isLoading: true,
                    skeleton: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        height: _responsive.hp(15),
                        width: _responsive.width
                      ),
                    ),
                    child: Container(),
                  );
                }
                else if(state is CategoriesLoaded){
                  return CustomCategoryListView(
                    categories: categories, 
                    onPageChangeCallBack: _onPageChange, 
                    currentIndex: state.index
                  );
                }
                return Container();
              }),
            ),
          ),
          
          // Pet list
          SizedBox(height: _responsive.hp(3.5)),
          BlocBuilder<CategoriesBloc, CategoriesState>(
            bloc: _categoriesBloc,
            builder: (_, state){
              if(state is CategoriesLoaded){
                return Row(
                  children: [
                    Text('Pet list:', style: TextStyles.blackw900(_responsive.dp(2))),
                    if(state.animals.isNotEmpty)...[
                      const Spacer(),
                      CustomTextButton(
                        text: 'View all', 
                        textColor: ThemeColors.lightGrey,
                        backgroundColor: ThemeColors.middleDarkGrey,
                        textSize: _responsive.dp(1.25),
                        onPressedCallback: () async => await Navigator.of(context).push(
                          MaterialPageRoute(builder: ((context) => ListOfAnimalsPage(animalsToShow: state.animals)))
                        )
                      )
                    ]
                  ],
                );
              }
              else{
                return Container();
              }
            },
          ),
          SizedBox(height: _responsive.hp(3.5)),
          Opacity(
            opacity: _fadeAnimationController.animation.value,
            child: _getAnimalList()
          ),
          SizedBox(height: _responsive.hp(3.5)),
        ],
      bottomNavigator: CustomBottomNavigatorBar()
    );
  }
}