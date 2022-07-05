import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Header
            const Text('Location:', style: TextStyles.titleInformation),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Tijuana, BC MX', style: TextStyles.titleData),
                const Spacer(),
                const Icon(Icons.search, size: 25, color: ThemeColors.darkGray),
                SizedBox(width: _size.width * 0.05),
                const Icon(Icons.notifications_none_outlined, size: 25, color: ThemeColors.darkGray)
              ],
            ),

            // Principal Image
            SizedBox(height: _size.height * 0.015),
            Container(
              height: _size.height * 0.15,
              width: _size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: ThemeColors.blueGradient
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: _size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Check all the animals available in the application', style: TextStyles.principalContainerTitle)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: _size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Image.asset(
                          'assets/images/animals/kitty.png', fit: BoxFit.contain,
                          ),
                      ),
                    ),
                  ),
                ],
              )
            ),
            
            // Body categories
            SizedBox(height: _size.height * 0.015),
            const Text('Categories:', style: TextStyles.bodySubtitle),
          ],
        ),
      ),
    );
  }
}