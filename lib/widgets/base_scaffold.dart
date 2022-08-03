import 'package:animals_adoption_flutter/widgets/custom_bottom_navigator_bar.dart';
import 'package:animals_adoption_flutter/widgets/header_back_button.dart';
import 'package:flutter/material.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import '../utils/text_styles.dart';

export 'package:flutter/material.dart';
export 'package:animals_adoption_flutter/utils/responsive_util.dart';
export 'package:animals_adoption_flutter/utils/text_styles.dart';
export 'package:animals_adoption_flutter/utils/theme_colors.dart';

class BaseScaffold extends StatelessWidget {

  final List<Widget> body;
  final bool? withBottomNavigator;
  final bool? withBackButton;
  final String? title;

  const BaseScaffold({
    Key? key,
    required this.body,
    this.withBottomNavigator,
    this.withBackButton,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: _responsive.tPadding, bottom: _responsive.bPadding, left: _responsive.sPadding, right: _responsive.sPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          HeaderBackButton(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _responsive.hp(5),
                      width: _responsive.wp(33),
                      child: Center(
                        child: Text(title ?? 'No title', style: TextStyles.blackSemiBold(_responsive.dp(2.25)), maxLines: 2, overflow: TextOverflow.visible, textAlign: TextAlign.center)
                      )
                    ),
                  ],
                ),
              ],
              SizedBox(height: _responsive.heightSeparator),
              ...body
            ],
          ),
        ),
        bottomNavigationBar: withBottomNavigator ?? false ? CustomBottomNavigatorBar() : const SizedBox(),
      ),
    );
  }
}