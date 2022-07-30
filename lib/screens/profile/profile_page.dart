import 'package:animals_adoption_flutter/constants/assets_paths.dart';
import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return BaseScaffold(
      title: 'Profile',
      withBackButton: true,
      withBottomNavigator: true,
      body: [
        SizedBox(height: _responsive.hp(25)),
        SizedBox(
          height: _responsive.hp(20),
          width: _responsive.wp(100),
          child: Image.asset(
            '$illustrationsPath/user.png',
            fit: BoxFit.contain,
          ),
        ),
      ]
    );
  }
}