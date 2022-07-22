


import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

import '../widgets/custom_bottom_navigator_bar.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Messages',
      body: const Text(''),
      withBackButton: true,
      bottomNavigator: CustomBottomNavigatorBar(),
    );
  }
}