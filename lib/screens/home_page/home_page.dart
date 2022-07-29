import 'package:animals_adoption_flutter/bloc/categories/categories_bloc.dart';

import 'package:animals_adoption_flutter/screens/all_animals/list_of_animals_page.dart';

import 'package:animals_adoption_flutter/utils/animations/basic_custom_animation.dart';
import 'package:animals_adoption_flutter/widgets/custom_button.dart';

import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';
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
  late final BasicCustomAnimation _animator;

  // Variables
  final CategoriesBloc _categoriesBloc = CategoriesBloc();

  @override
  void initState() {

    _categoriesBloc.add(GetCategories());

    // Animation controllers
    _animator = BasicCustomAnimation(
      listener: animationListener, 
      tickerProvider: this,
      durationInMillisec: 800
    );

    super.initState();
  }

  void _onPageChange(final CategoryModel category, final int newIndex){
    _categoriesBloc.add(OnCategorySelected(index: newIndex, category: category));
    _animator.controller.reset();
    setState(() {
    });
  }

  void animationListener() => setState(() {});

  @override
  void dispose() {
    _animator.dispose();
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


            if(state.animals.isEmpty){
              return Center(
                child: Text('No animals in this category.', style: TextStyles.lightGreyw600(_responsive.dp(1.5)))
              );
            }
            final int animalsToShow = state.animals.length > 5 ? 6 : state.animals.length;
            return CustomAnimalsListOrGrid(
              animals: state.animals, 
              isListView: true,
              animalsToShow: animalsToShow,
              listViewHeight: _responsive.hp(15),
            );
          }
          return Container();
        },
      );
    }

    return CustomScaffold(
      withBottomNavigator: true,
      body: [
        BlocBuilder(
          bloc: _categoriesBloc,
          builder: (_, state){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('AdoptMe', style: TextStyles.blackw900(_responsive.dp(4))),
                    const Spacer(),
                    CustomButton(
                      icon: Icons.notifications,
                      size: _responsive.dp(4),
                    )
                  ],
                ),
          
                // Principal announcement
                SizedBox(height: _responsive.hp(2)),
                CustomAnnouncementsGalery(),
                
                // Body categories
                SizedBox(height: _responsive.hp(2.5)),
                Text('Location:', style: TextStyles.blackw700(_responsive.dp(1.5)).copyWith(color: ThemeColors.darkGrey)),
                Text('Tijuana, BC MX', style: TextStyles.blackw900(_responsive.dp(2.25))),
                SizedBox(height: _responsive.hp(2.5)),
                Text('Categories:', style: TextStyles.blackw700(_responsive.dp(2))),
                SizedBox(height: _responsive.hp(2.5)),
                SizedBox(
                  height: _responsive.hp(15),
                  width: _responsive.width,
                  child: state is CategoriesLoading
                        ? Skeleton(
                            isLoading: true,
                            skeleton: SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                height: _responsive.hp(15),
                                width: _responsive.width
                              ),
                            ),
                            child: Container(),
                          )
                        : state is CategoriesLoaded 
                        ? CustomCategoryListView(
                            categories: categories, 
                            onPageChangeCallBack: _onPageChange, 
                            currentIndex: state.index
                          )
                        : Container()
                ),
                
                // Pet list
                SizedBox(height: _responsive.hp(3.5)),
                state is CategoriesLoaded
                    ? SizedBox(
                      height: _responsive.hp(5),
                      child: Row(
                        children: [
                          Text('Pet list:', style: TextStyles.blackw700(_responsive.dp(2))),
                          if(state.animals.isNotEmpty)...[
                            const Spacer(),
                            CustomTextButton(
                              text: 'View all', 
                              textColor: ThemeColors.middleDarkGrey,
                              backgroundColor: ThemeColors.grey,
                              textSize: _responsive.dp(1.25),
                              onPressedCallback: () async => await Navigator.of(context).push(
                                MaterialPageRoute(builder: ((context) => ListOfAnimalsPage(animalsToShow: state.animals)))
                              )
                            )
                          ]
                        ],
                      ),
                    )
                  : Container(),
                SizedBox(height: _responsive.hp(3.5)),
                _getAnimalList(),
                SizedBox(height: _responsive.hp(3.5)),
              ],
            );
          },
        )
      ],
    );
  }
}