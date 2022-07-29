import 'package:animals_adoption_flutter/constants/assets_paths.dart';
import 'package:animals_adoption_flutter/widgets/custom_scaffold.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);
    
    return CustomScaffold(
      title: 'My location',
      withBackButton: true,
      withBottomNavigator: true,
      body: [
        SizedBox(height: _responsive.hp(20)),
        SizedBox(
          height: _responsive.hp(30),
          width: _responsive.wp(100),
          child: Image.asset(
            '$illustrationsPath/map.png',
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}