

import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/screens/all_animals/list_of_animals_page.dart';
import 'package:animals_adoption_flutter/utils/animations/basic_custom_animation.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:animals_adoption_flutter/widgets/custom_animal_container.dart';
import 'package:flutter/material.dart';


class CustomAnimalsListOrGrid extends StatefulWidget {

  final List<AnimalModel> animals;
  final bool isListView;

  final int? animalsToShow;
  final double? gridViewHeight;
  final double? listViewHeight;

  const CustomAnimalsListOrGrid({
    Key? key,
    required this.animals,
    required this.isListView,
    this.animalsToShow,
    this.gridViewHeight,
    this.listViewHeight
  }) : super(key: key);

  @override
  State<CustomAnimalsListOrGrid> createState() => _CustomAnimalsListOrGridState();
}

class _CustomAnimalsListOrGridState extends State<CustomAnimalsListOrGrid> with SingleTickerProviderStateMixin{

  late BasicCustomAnimation _animator;

  @override
  void initState() {
    _animator = BasicCustomAnimation(listener: _animationListener, tickerProvider: this);
    super.initState();
  }

  void _animationListener() => setState(() {});

  @override
  Widget build(BuildContext context) {
    
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    // List view widget
    Widget _getListView(){
      return SizedBox(
        height: widget.listViewHeight! * widget.animalsToShow!,
        width: _responsive.width,
        child: ListView.separated(
          shrinkWrap: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.animalsToShow!,
          clipBehavior: Clip.none,
          padding: EdgeInsets.zero,
          separatorBuilder: (_, x) => SizedBox(height: _responsive.hp(2)),
          itemBuilder: (_, x){
            if(x < widget.animalsToShow! - 1){
              return CustomAnimalContainer(
                animal: widget.animals[x],
                withHeroAnimation: true,
              );
            }
            return GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => ListOfAnimalsPage(animalsToShow: widget.animals)))
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

    // GridView builder
    Widget _getGridView(){

      const int containersInRow = 2;
      return SizedBox(
        height: widget.gridViewHeight,
        width: _responsive.width,
        child: GridView.builder(
          shrinkWrap: false,
          clipBehavior: Clip.none,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: _responsive.hp(3.5)),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: containersInRow,
            crossAxisSpacing: _responsive.wp(2.5),
            mainAxisSpacing: _responsive.hp(1),
            childAspectRatio: 0.65
          ),
          itemCount: widget.animals.length,
          itemBuilder: (_, x) {

            final bool isModuleOfTwo = (x + 1) % containersInRow == 0;
            final int direction = isModuleOfTwo ? 1 : -1;

            final double sideStartPosition = _responsive.width * direction;
            final double sideCurrentPosition = sideStartPosition * (1 - _animator.animation.value);

            return Transform(
              transform: Matrix4.identity()..translate(sideCurrentPosition),
              child: CustomAnimalContainer(
                animal: widget.animals[x],
                showInVertical: true,
              ),
            );
          },
        ),
      );
    }

    return Opacity(
      opacity: _animator.animation.value,
      child: widget.isListView ? _getListView() : _getGridView(),
    );
  }
}