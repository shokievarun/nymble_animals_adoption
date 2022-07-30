import 'package:animals_adoption_flutter/bloc/categories/categories_bloc.dart';

import 'package:animals_adoption_flutter/screens/all_animals/list_of_animals_page.dart';

import 'package:animals_adoption_flutter/widgets/circle_button.dart';

import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';
import 'package:animals_adoption_flutter/widgets/custom_text_button.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

import 'widgets/widgets.dart';

import 'package:animals_adoption_flutter/models/category_model.dart';

import 'package:animals_adoption_flutter/constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  // Variables

  int? _selectedCategoryIndex = 1;

  final CategoriesBloc _categoriesBloc = CategoriesBloc();

  @override
  void initState() {
    _categoriesBloc.add(GetCategories());

    super.initState();
  }

  void _onPageChange(final CategoryModel category, final int newIndex) {
    _selectedCategoryIndex = newIndex;
    _categoriesBloc.add(OnCategorySelected(index: newIndex, category: category));
    setState(() {});
  }

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
                  style: TextStyles.lightGreyw600(_responsive.dp(1.5)),
                ),
              );
            }
            final int animalsToShow =
                state.animals.length > 5 ? 6 : state.animals.length;
            return AnimalsListOrGrid(
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

    return BaseScaffold(
      withBottomNavigator: true,
      body: [
        BlocBuilder(
          bloc: _categoriesBloc,
          builder: (_, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AdoptMe', style: TextStyles.blackw900(_responsive.dp(4))),

                // Principal announcement
                SizedBox(height: _responsive.heightSeparator),
                AnnouncementsGalery(),

                // Body categories
                SizedBox(height: _responsive.heightSeparator),
                Text(
                  'Categories:',
                  style: TextStyles.lightBlackw600(_responsive.dp(2)),
                ),
                SizedBox(height: _responsive.heightSeparator),
                SizedBox(
                  height: _responsive.hp(20),
                  width: _responsive.width,
                  child: CategoryListView(
                    categories: categories,
                    onPageChangeCallBack: _onPageChange,
                    currentIndex: state is CategoriesLoaded ? state.index : 1,
                  )
                ),

                // Pet list
                SizedBox(height: _responsive.heightSeparator),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: state is CategoriesLoaded
                  ? SizedBox(
                      key: Key(_selectedCategoryIndex.toString()),
                      height: _responsive.hp(5),
                      child: Row(
                        children: [
                          Text(
                            'Pet list:',
                            style:
                                TextStyles.lightBlackw600(_responsive.dp(2)),
                          ),
                          if (state.animals.isNotEmpty) ...[
                            const Spacer(),
                            CustomTextButton(
                              text: 'View all',
                              textColor: ThemeColors.middleDarkGrey,
                              backgroundColor: ThemeColors.grey,
                              textSize: _responsive.dp(1.25),
                              onPressedCallback: () async =>
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) => ListOfAnimalsPage(
                                      animalsToShow: state.animals)),
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    )
                  : Container(),
                ),
                SizedBox(height: _responsive.heightSeparator),
                _getAnimalList(),
                SizedBox(height: _responsive.heightSeparator),
              ],
            );
          },
        )
      ],
    );
  }
}
