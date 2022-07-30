import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:flutter/material.dart';


class AnimalInfoItem extends StatelessWidget {

  final String dataValue;
  final String dataName;

  const AnimalInfoItem({
    Key? key,
    required this.dataValue,
    required this.dataName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);
    
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(dataValue, style: TextStyles.blackw900(_responsive.dp(1.5))),
          Text(dataName, style: TextStyles.middleDarkGrayw500(_responsive.dp(1.25))),
        ],
      ),
    );
  }
}