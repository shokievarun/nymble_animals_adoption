import 'package:animals_adoption_flutter/bloc/categories/categories_bloc.dart';
import 'package:animals_adoption_flutter/main.dart';
import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Variables

  final int? _selectedCategoryIndex = 1;
  late bool isLightTheme;
  var box = Hive.box('isLightTheme');

  final CategoriesBloc _categoriesBloc = CategoriesBloc(false);

  @override
  void initState() {
    _categoriesBloc.add(GetCategories());

    var themeValue = box.get('isLightTheme');
    if (themeValue != null) {
      isLightTheme = themeValue;
    } else {
      box.put('isLightTheme', true);
      isLightTheme = true;
    }

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (!isLightTheme) {
    //     MyApp.of(context).changeTheme(ThemeMode.dark);
    //     box.put('isLightTheme', false);
    //   } else {
    //     MyApp.of(context).changeTheme(ThemeMode.light);
    //     box.put('isLightTheme', true);
    //   }
    // });

    super.initState();
  }

  // void _onPageChange(final CategoryModel category, final int newIndex) {
  //   _selectedCategoryIndex = newIndex;
  //   _categoriesBloc
  //       .add(OnCategorySelected(index: newIndex, category: category));
  //   setState(() {});
  // }

  void animationListener() => {};

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    Widget _getAnimalList() {
      return BlocBuilder(
        bloc: _categoriesBloc,
        builder: (_, state) {
          if (state is CategoriesLoaded) {
            if (state.animals.isEmpty) {
              return Center(
                child: Text(
                  'No animals in this category.',
                  style: TextStyles.lightBlackMedium(_responsive.dp(1.5)),
                ),
              );
            }
            final int animalsToShow = state.animals.length;
            return AnimalsListOrGrid(
              animals: state.animals,
              isListView: true,
              animalsToShow: animalsToShow,
              listViewHeight: _responsive.hp(15),
              isFromHistory: false,
            );
          }
          return Container();
        },
      );
    }

    return SafeArea(
      child: BaseScaffold(
        withBottomNavigator: true,
        body: [
          BlocBuilder(
            bloc: _categoriesBloc,
            builder: (_, state) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Nymble Pet Adoption',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: _responsive.dp(3),
                            fontWeight: FontWeight.w600,
                            // color: ThemeColors.black
                          ),
                          // style: TextStyles.blackBold(_responsive.dp(4))
                        ),
                      ),
                      Switch(
                        value: isLightTheme,
                        onChanged: (val) {
                          switchOnChanged(val, context);

                          //  Hive.box(themeBox).put('darkMode', !value);
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: _responsive.heightSeparator * 0.5),

                  SizedBox(height: _responsive.heightSeparator * 0.5),
                  // // Body categories
                  // SizedBox(height: _responsive.heightSeparator),
                  // Text(
                  //   'Categories:',
                  //   style: TextStyle(
                  //     fontFamily: 'Montserrat',
                  //     fontSize: _responsive.dp(2),
                  //     fontWeight: FontWeight.w600,
                  //     // color: ThemeColors.black
                  //   ),
                  // ),
                  // SizedBox(height: _responsive.heightSeparator),
                  // SizedBox(
                  //     height: _responsive.hp(20),
                  //     width: _responsive.width,
                  //     child: CategoryListView(
                  //       categories: categories,
                  //       onPageChangeCallBack: _onPageChange,
                  //       currentIndex:
                  //           state is CategoriesLoaded ? state.index : 1,
                  //     )),

                  // Pet list
                  SizedBox(height: _responsive.heightSeparator),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: state is CategoriesLoaded
                        ? SizedBox(
                            key: Key(_selectedCategoryIndex.toString()),
                            height: _responsive.hp(5),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                      'Pet List:',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: _responsive.dp(2),
                                        fontWeight: FontWeight.w600,
                                        // color: ThemeColors.black
                                      ),
                                    )),
                                // GestureDetector(
                                //   onTap: () {
                                //     Hive.box('isLightTheme').clear();
                                //     Hive.box('animalBox').clear();
                                //  //   setState(() {});
                                //     Navigator.pushAndRemoveUntil(context,
                                //         MaterialPageRoute(
                                //             builder: (BuildContext context) {
                                //       return HomePage();
                                //     }), (e) => false);
                                //   },
                                //   child: AnimatedContainer(
                                //     duration: const Duration(milliseconds: 250),
                                //     height: 40,
                                //     width: 40,
                                //     decoration: const BoxDecoration(
                                //         color: ThemeColors.lightGrey,
                                //         shape: BoxShape.circle),
                                //     child: const Icon(
                                //       Icons.clear_all_sharp,
                                //       size: 25,
                                //       color: ThemeColors.lightBlack,
                                //     ),
                                //   ),
                                // )
                                // if (state.animals.isNotEmpty) Container()
                                // CustomTextButton(
                                //   text: 'View all',
                                //   textColor: ThemeColors.lightBlack,
                                //   backgroundColor: ThemeColors.lightGrey,
                                //   textSize: _responsive.dp(1.25),
                                //   onPressedCallback: () async =>
                                //       await Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //       builder: ((context) => ListOfAnimalsPage(
                                //           animalsToShow: state.animals)),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                  SizedBox(height: _responsive.heightSeparator),
                  _getAnimalList(),
                  SizedBox(height: _responsive.heightSeparator * 2),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  void switchOnChanged(bool val, BuildContext context) {
    isLightTheme = val;
    if (!isLightTheme) {
      MyApp.of(context).changeTheme(ThemeMode.dark);
      box.put('isLightTheme', false);
    } else {
      MyApp.of(context).changeTheme(ThemeMode.light);
      box.put('isLightTheme', true);
    }
  }
}
