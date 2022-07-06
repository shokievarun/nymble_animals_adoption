import 'dart:math';

import 'package:animals_adoption_flutter/utils/constants.dart';
import 'package:animals_adoption_flutter/utils/text_styles.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Controllers
  PageController? _categoriesController; 
  PageController? _petsController; 

  // Variables
  int _currentPage = 1;

  @override
  void initState() {

    _categoriesController = PageController(
      initialPage: _currentPage, 
      viewportFraction: 1 / 3,
    );
    _petsController = PageController(
      initialPage: _currentPage, 
      viewportFraction: 1 / 3,
    );

    super.initState();
  }

  void _onPageChange(int newIndex){
    if(newIndex == _currentPage){
      return;
    }
    setState(() {
      _currentPage = newIndex;
    });
    newIndex = newIndex + (newIndex == 0 ? 1 : newIndex == categories.length - 1 ? -1 : 0);
    _categoriesController!.animateToPage(newIndex, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
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
                const Icon(Icons.search_rounded, size: 25, color: ThemeColors.darkGray),
                SizedBox(width: _size.width * 0.05),
                const Icon(Icons.notifications_rounded, size: 25, color: ThemeColors.darkGray)
              ],
            ),

            // Principal Image
            SizedBox(height: _size.height * 0.025),
            Container(
              height: _size.height * 0.15,
              width: _size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: ThemeColors.blueGradient
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: _size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Check all the pets available in our application', style: TextStyles.principalContainerTitle)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Image.asset(
                        'assets/images/animals/kitty.png', fit: BoxFit.contain,
                        ),
                    ),
                  ),
                ],
              )
            ),
            
            // Body categories
            SizedBox(height: _size.height * 0.015),
            const Text('Categories:', style: TextStyles.bodySubtitle),
            SizedBox(height: _size.height * 0.015),
            SizedBox(
              height: _size.height * 0.175,
              width: _size.width,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                controller: _categoriesController,
                clipBehavior: Clip.none,
                itemBuilder: (_, x){
                  
                  final isSelected = _currentPage == x;
                  final double widgetScale = isSelected  ? 1.10 : 0.85;

                  return GestureDetector(
                    onTap: () => _onPageChange(x),
                    child: AnimatedScale(
                      scale: widgetScale,
                      duration: const Duration(milliseconds: 250),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        transform: Matrix4.identity()..translate(
                          0,
                          isSelected ? 0 : 35
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: ThemeColors.gradients[x].map((e) => e.withOpacity(0.35)).toList(),
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight
                          ),
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(categories[x].name, style: TextStyles.categoryTitle),
                              Text(categories[x].description, style: TextStyles.categorySubtitle),
                              const Spacer(),
                              Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Image.asset(
                                      categories[x].imagePath, 
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Pet list
            SizedBox(height: _size.height * 0.05),
            const Text('Pet list:', style: TextStyles.bodySubtitle),
            SizedBox(
              height: _size.height * 0.175,
              width: _size.width,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _petsController,
                itemCount: animals.length,
                clipBehavior: Clip.none,
                itemBuilder: (_, x){
                  
                  final Color containerColor = ThemeColors.containersBackground[Random().nextInt(ThemeColors.containersBackground.length - 1)].withOpacity(0.25);
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: containerColor,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(animals[x].name, textAlign: TextAlign.center, style: TextStyles.petTitleList),
                                    Text('${animals[x].location} (${animals[x].distanceInKm} km)', textAlign: TextAlign.center, style: TextStyles.petSubtitleList),
                                  ],
                                ),
                              ),
                            ),
                            Divider(color: containerColor),
                            Expanded(
                              flex: 3,
                              child: Image.network(
                                animals[x].imagePath, 
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          height: _size.height * 0.1,
          width: _size.width,
          transform: Matrix4.identity()..translate(0, -_size.height * 0.025),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(25)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.home, color: ThemeColors.lightBlack, size: 30),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.account_circle_rounded, color: ThemeColors.lightBlack, size: 30),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.location_on_rounded, color: ThemeColors.lightBlack, size: 30),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.message_rounded, color: ThemeColors.lightBlack, size: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}