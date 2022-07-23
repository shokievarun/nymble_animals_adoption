
import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/widgets/custom_animal_container.dart';
import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

class ListOfAnimalsPage extends StatelessWidget {

  final List<AnimalModel> animalsToShow;

  const ListOfAnimalsPage({
    Key? key,
    required this.animalsToShow
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return CustomScaffold(
      title: 'All the animals',
      withBackButton: true,
      body: [
        SizedBox(
          height: _responsive.hp(32.5) * (animalsToShow.length ~/ 2),
          width: _responsive.wp(100),
          child: GridView.builder(
            shrinkWrap: false,
            clipBehavior: Clip.none,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: _responsive.hp(3.5)),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: _responsive.wp(2.5),
              mainAxisSpacing: _responsive.hp(1),
              childAspectRatio: 0.65
            ),
            itemCount: animalsToShow.length,
            itemBuilder: (_, x) {
              return CustomAnimalContainer(
                animal: animalsToShow[x],
                showInVertical: true,
              );
            },
          ),
        ),
      ],
    );
  }
}