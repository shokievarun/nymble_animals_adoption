import 'package:animals_adoption_flutter/constants/assets_paths.dart';
import 'package:animals_adoption_flutter/widgets/custom_bottom_navigator_bar.dart';
import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

import '../../widgets/custom_bottom_navigator_bar.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);


    return CustomScaffold(
      title: 'Messages',
      withBackButton: true,
      bottomNavigator: CustomBottomNavigatorBar(),
      body: [
        SizedBox(height: _responsive.hp(20)),
        SizedBox(
          height: _responsive.hp(30),
          width: _responsive.wp(100),
          child: Image.asset(
            '$illustrationsPath/no_messages.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}