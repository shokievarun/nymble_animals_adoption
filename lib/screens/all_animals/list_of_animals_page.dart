
import 'package:animals_adoption_flutter/models/animal_model.dart';
import 'package:animals_adoption_flutter/screens/home_page/widgets/animals_list_or_grid.dart';
import 'package:animals_adoption_flutter/utils/animations/basic_custom_animation.dart';
import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';


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

  late final BasicCustomAnimation _animator;


  @override
  void initState() {
    _animator = BasicCustomAnimation(
      listener: _animationListener, 
      tickerProvider: this
    );
    super.initState();
  }

  @override
  void dispose() {
    _animator.dispose();
    super.dispose();
  }

  void _animationListener() => setState(() {});
  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    final double gridViewHeight = _responsive.hp(32.5) * (widget.animalsToShow.length ~/ 2);

    return BaseScaffold(
      title: 'All the animals',
      withBackButton: true,
      body: [
        AnimalsListOrGrid(
          animals: widget.animalsToShow,
          isListView: false,
          gridViewHeight: gridViewHeight,
        ),
        SizedBox(height: _responsive.hp(10))
      ],
    );
  }
}