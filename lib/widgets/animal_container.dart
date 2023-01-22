import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/db/pet.dart';
import 'package:animals_adoption_flutter/widgets/favorite_button.dart';
import 'package:animals_adoption_flutter/widgets/get_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animals_adoption_flutter/screens/animal_details/animal_details_page.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:animals_adoption_flutter/widgets/custom_text_button.dart';

import '../utils/text_styles.dart';
import '../utils/theme_colors.dart';

class AnimalContainer extends StatelessWidget {
  final AnimalModel animal;
  final bool? showInVertical;
  final bool? withHeroAnimation;
  final int index;

  const AnimalContainer(
      {Key? key,
      required this.animal,
      this.showInVertical,
      this.withHeroAnimation,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);
    // var now = DateTime.parse(animal.adoptedDate);
    // var formatter = DateFormat('dd-MM-yyyy');
    // String formattedTime = DateFormat('kk:mm:a').format(now);
    // String formattedDate = formatter.format(now);
    Widget getAnimalImages() {
      return GetNetworkImage(url: animal.imagePath);
    }

    List<Widget> getAnimalInformationWidget() {
      return [
        Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: withHeroAnimation ?? false
                  ? Hero(tag: animal.id, child: getAnimalImages())
                  : getAnimalImages(),
            )),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(animal.name,
                          textAlign: TextAlign.center,
                          style: TextStyles.blackSemiBold(_responsive.dp(1.5))),
                      // Row(
                      //   children: [
                      //     Icon(Icons.location_on_sharp, color: ThemeColors.accentForText, size: _responsive.dp(1.25)),
                      //     Text('${animal.location} (${animal.distanceInKm} km)', textAlign: TextAlign.center, style: TextStyles.greySemiBold(_responsive.dp(1))),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                      animal.isAdopted
                          ? animal.adoptedDate
                          : animal.description,
                      textAlign: TextAlign.start,
                      style: TextStyles.blackSemiBold(_responsive.dp(1.2)),
                      maxLines: showInVertical ?? false ? 3 : 2,
                      overflow: TextOverflow.ellipsis),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(
                          text: animal.isAdopted ? 'Adopted' : 'Details',
                          textColor: ThemeColors.black,
                          backgroundColor: animal.isAdopted
                              ? ThemeColors.redForBackground
                              : ThemeColors.accent,
                          textSize: _responsive.dp(1),
                          onPressedCallback: () async {
                            if (!animal.isAdopted) {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 1000),
                                  pageBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation) {
                                    return AnimalDetailsPage(
                                        animal: animal, index: index);
                                  },
                                  transitionsBuilder: (BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation,
                                      Widget child) {
                                    return Align(
                                      child: FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                ),
                              );
                              // await Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             AnimalDetailsPage(animal: animal)));
                            }
                          }),
                      const Spacer(),
                      Visibility(
                          visible: !animal.isAdopted,
                          child: FavoriteButton(size: _responsive.dp(3)))
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ];
    }

    return Container(
        height: _responsive.hp(15),
        padding: EdgeInsets.symmetric(
            vertical: _responsive.hp(1), horizontal: _responsive.wp(2.5)),
        decoration: BoxDecoration(
            color: ThemeColors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: containerShadows),
        child: showInVertical ?? false
            ? Column(children: getAnimalInformationWidget())
            : Row(children: getAnimalInformationWidget()));
  }
}
