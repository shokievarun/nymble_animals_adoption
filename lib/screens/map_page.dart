

import 'package:animals_adoption_flutter/widgets/custom_bottom_navigator_bar.dart';
import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: Text('Map page'),
      withBackButton: true,
      bottomNavigator: CustomBottomNavigatorBar(),
    );
  }
}