import 'package:animals_adoption_flutter/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import '../utils/text_styles.dart';

export 'package:flutter/material.dart';
export 'package:animals_adoption_flutter/utils/responsive_util.dart';
export 'package:animals_adoption_flutter/utils/text_styles.dart';
export 'package:animals_adoption_flutter/utils/theme_colors.dart';

class CustomScaffold extends StatelessWidget {

  final List<Widget> body;
  final Widget? bottomNavigator;
  final bool? withBackButton;
  final String? title;

  const CustomScaffold({
    Key? key,
    required this.body,
    this.bottomNavigator,
    this.withBackButton,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: _responsive.tPadding, bottom: _responsive.bPadding, left: _responsive.sPadding, right: _responsive.sPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(withBackButton ?? false)...[
              
              // Back button
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _responsive.hp(5),
                    width: _responsive.wp(33) - _responsive.sPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        CustomBackButton(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: _responsive.hp(5),
                    width: _responsive.wp(33),
                    child: Center(
                      child: Text(title ?? 'No title', style: TextStyles.blackw700(_responsive.dp(2)))
                    )
                  ),
                ],
              ),
            ],
            ...body
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigator ?? const SizedBox(),
    );
  }
}