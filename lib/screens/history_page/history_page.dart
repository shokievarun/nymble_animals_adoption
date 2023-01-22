import 'package:animals_adoption_flutter/bloc/categories/categories_bloc.dart';
import 'package:animals_adoption_flutter/screens/home_page/widgets/widgets.dart';
import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  // Variables

  final int? _selectedCategoryIndex = 1;

  final CategoriesBloc _categoriesBloc = CategoriesBloc(true);

  @override
  void initState() {
    _categoriesBloc.add(GetCategories());

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
              isFromHistory: true,
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
                  //  Text('AdoptMe', style: TextStyles.blackBold(_responsive.dp(4))),

                  // Principal announcement
                  //  SizedBox(height: _responsive.heightSeparator * 2),
                  // AnnouncementsGalery(),

                  // Body categories
                  SizedBox(height: _responsive.heightSeparator * 0.5),
                  // Text('Categories:',
                  //     style: TextStyle(
                  //       fontFamily: 'Montserrat',
                  //       fontSize: _responsive.dp(2),
                  //       fontWeight: FontWeight.w600,
                  //       // color: ThemeColors.black
                  //     )),
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
                                      'Adopted History :',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: _responsive.dp(2),
                                        fontWeight: FontWeight.w600,
                                        // color: ThemeColors.black
                                      ),
                                    )),
                                if (state.animals.isNotEmpty) Container()
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
}
