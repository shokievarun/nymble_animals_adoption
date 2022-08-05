import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:flutter/material.dart';


class TextDetailsInfo extends StatelessWidget {

  final String title;
  final String subTitle;
  final bool centered;

  const TextDetailsInfo({
    Key? key,
    required this.title,
    required this.subTitle,
    this.centered = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil responsive = ResponsiveUtil.of(context);

    return Column(
      crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: TextStyles.blackSemiBold(responsive.dp(1.5))),
        Text(subTitle, style: TextStyles.greySemiBold(responsive.dp(1.25))),
      ],
    );
  }
}