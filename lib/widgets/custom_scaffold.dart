import 'package:animals_adoption_flutter/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';

export 'package:flutter/material.dart';
export 'package:animals_adoption_flutter/utils/responsive_util.dart';
export 'package:animals_adoption_flutter/utils/text_styles.dart';
export 'package:animals_adoption_flutter/utils/theme_colors.dart';

class CustomScaffold extends StatelessWidget {

  final Widget body;
  final Widget? bottomNavigator;
  final bool? withBackButton;

  const CustomScaffold({
    Key? key,
    required this.body,
    this.bottomNavigator,
    this.withBackButton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: _responsive.tPadding, bottom: _responsive.bPadding, left: _responsive.sPadding, right: _responsive.sPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(withBackButton ?? false)...[
                const CustomBackButton(),
              ],
              body,
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigator ?? const SizedBox(),
    );
  }
}