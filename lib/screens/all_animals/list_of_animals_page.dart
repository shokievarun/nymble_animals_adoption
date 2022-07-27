
import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/utils/animations/fade_animation.dart';
import 'package:animals_adoption_flutter/widgets/custom_animal_container.dart';
import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';


const int containersInRow = 2;

class ListOfAnimalsPage extends StatefulWidget {

  final List<AnimalModel> animalsToShow;

  const ListOfAnimalsPage({
    Key? key,
    required this.animalsToShow
  }) : super(key: key);

  @override
  State<ListOfAnimalsPage> createState() => _ListOfAnimalsPageState();
}

class _ListOfAnimalsPageState extends State<ListOfAnimalsPage> with SingleTickerProviderStateMixin{

  late FadeAnimationController _fadeAnimationController;


  @override
  void initState() {
    _fadeAnimationController = FadeAnimationController(
      listener: _animationListener, 
      tickerProvider: this
    );
    super.initState();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    super.dispose();
  }

  void _animationListener(){
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    final double gridViewHeight = _responsive.hp(32.5) * (widget.animalsToShow.length ~/ 2);

    return CustomScaffold(
      title: 'All the animals',
      withBackButton: true,
      body: [
        Opacity(
          opacity: _fadeAnimationController.animation.value,
          child: SizedBox(
            height: gridViewHeight,
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
              itemCount: widget.animalsToShow.length,
              itemBuilder: (_, x) {

                final bool isModuleOfTwo = (x + 1) % containersInRow == 0;
                final int direction = isModuleOfTwo ? 1 : -1;

                final double sideStartPosition = _responsive.width * direction;
                final double sideCurrentPosition = sideStartPosition * (1 - _fadeAnimationController.animation.value);

                return Transform(
                  transform: Matrix4.identity()..translate(sideCurrentPosition),
                  child: CustomAnimalContainer(
                    animal: widget.animalsToShow[x],
                    showInVertical: true,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}