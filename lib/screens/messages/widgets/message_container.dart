import 'package:animals_adoption_flutter/constants/assets_paths.dart';
import 'package:animals_adoption_flutter/widgets/base_scaffold.dart';
import 'package:animals_adoption_flutter/widgets/custom_text_button.dart';


class MessagesContainer extends StatelessWidget {

  const MessagesContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return Container(
      height: _responsive.hp(10),
      padding: EdgeInsets.symmetric(vertical: _responsive.hp(1), horizontal: _responsive.wp(2.5)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2.5,
            blurRadius: 3.5,
            offset: const Offset(0, 1.5)
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Picture
          Expanded(
            flex: 2,
            child: Image.asset('$illustrationsPath/user.png')
          ),

          // Data
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Francisco Rodríguez', textAlign: TextAlign.center, style: TextStyles.lightBlackw600(_responsive.dp(1.20))),
                SizedBox(height: _responsive.heightSeparator / 100),
                Text('Jasper owner', textAlign: TextAlign.center, style: TextStyles.lightBlackw600(_responsive.dp(1.10))),
                SizedBox(height: _responsive.hp(0.5)),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello, this is a message!', textAlign: TextAlign.center, style: TextStyles.middleDarkGrayw500(_responsive.dp(1)), maxLines: 3, overflow: TextOverflow.ellipsis),
                      const Spacer(),
                      CustomTextButton(
                        textColor: ThemeColors.accentForText, 
                        backgroundColor: ThemeColors.accent, 
                        text: '1', 
                        textSize: _responsive.dp(1),
                        onPressedCallback: () {} 
                      )
                    ],
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}