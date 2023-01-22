import 'package:animals_adoption_flutter/db/pet.dart';
import 'package:flutter/material.dart';
import 'package:animals_adoption_flutter/utils/animations/basic_custom_animation.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/widgets/animal_container.dart';

class AnimalsListOrGrid extends StatefulWidget {
  final List<AnimalModel> animals;
  final bool isListView;

  final int? animalsToShow;
  final double? gridViewHeight;
  final double? listViewHeight;
  final bool isFromHistory;

  const AnimalsListOrGrid(
      {Key? key,
      required this.animals,
      required this.isListView,
      this.animalsToShow,
      this.gridViewHeight,
      this.listViewHeight,
      required this.isFromHistory})
      : super(key: key);

  @override
  State<AnimalsListOrGrid> createState() => _AnimalsListOrGridState();
}

class _AnimalsListOrGridState extends State<AnimalsListOrGrid>
    with SingleTickerProviderStateMixin {
  BasicCustomAnimation? _animator;

  @override
  void initState() {
    _animator = BasicCustomAnimation(
        listener: _animationListener,
        tickerProvider: this,
        durationInMillisec: 700,
        begin: 0);
    super.initState();
  }

  @override
  void dispose() {
    _animator!.dispose();
    super.dispose();
  }

  void _animationListener() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    // List view widget
    Widget _getListView() {
      return SizedBox(
        height: widget.listViewHeight! * widget.animalsToShow!,
        width: _responsive.width,
        child: ListView.separated(
          shrinkWrap: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.animalsToShow!,
          clipBehavior: Clip.none,
          padding: EdgeInsets.zero,
          separatorBuilder: (_, x) =>
              SizedBox(height: _responsive.heightSeparator),
          itemBuilder: (_, x) {
            if (!widget.isFromHistory) {
              return widget.animals[x].isAdopted
                  ? Container()
                  : AnimalContainer(
                      animal: widget.animals[x],
                      withHeroAnimation: true,
                      index: x,
                    );
            }
            return !widget.animals[x].isAdopted
                ? Container()
                : AnimalContainer(
                    animal: widget.animals[x],
                    withHeroAnimation: true,
                    index: x,
                  );
            // }
            // return SizedBox(
            //   height: widget.listViewHeight! / 2,
            //   child: Column(
            //     children: [
            //       CustomTextButton(
            //         backgroundColor: ThemeColors.lightGrey,
            //         text: 'Press to see all the animals',
            //         textColor: ThemeColors.lightBlack,
            //         textSize: _responsive.dp(1.5),
            //         onPressedCallback: () async {
            //           await Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: ((context) => ListOfAnimalsPage(
            //                       animalsToShow: widget.animals))));
            //         },
            //       ),
            //     ],
            //   ),
            // );
          },
        ),
      );
    }

    // GridView builder
    Widget _getGridView() {
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
              crossAxisSpacing: _responsive.wp(5),
              mainAxisSpacing: _responsive.hp(2.5),
              childAspectRatio: 0.65),
          itemCount: widget.animals.length,
          itemBuilder: (_, x) {
            final bool isModuleOfTwo = (x + 1) % containersInRow == 0;
            final int direction = isModuleOfTwo ? 1 : -1;

            final double sideStartPosition = _responsive.width * direction;
            final double sideCurrentPosition =
                sideStartPosition * (1 - _animator!.getValue);

            return Transform(
              transform: Matrix4.identity()..translate(sideCurrentPosition),
              child: AnimalContainer(
                animal: widget.animals[x],
                showInVertical: true,
                index: x,
              ),
            );
          },
        ),
      );
    }

    return Opacity(
      opacity: _animator!.getValue,
      child: widget.isListView ? _getListView() : _getGridView(),
    );
  }
}
