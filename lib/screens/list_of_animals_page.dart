
import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

class ListOfAnimalsPage extends StatelessWidget {
  const ListOfAnimalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: Text('New page'),
      withBackButton: true,
    );
  }
}