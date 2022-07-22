
import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

import '../widgets/custom_bottom_navigator_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      title: 'Profile',
      body: Text(''),
      withBackButton: true,
      bottomNavigator: CustomBottomNavigatorBar(),
    );
  }
}