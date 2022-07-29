import 'package:animals_adoption_flutter/constants/constants.dart';
import 'package:animals_adoption_flutter/screens/home_page/widgets/announcement_container.dart';
import 'package:animals_adoption_flutter/utils/responsive_util.dart';
import 'package:flutter/material.dart';


class CustomAnnouncementsGalery extends StatelessWidget {

  late PageController _controller;
  late int _currentPage;

 CustomAnnouncementsGalery({Key? key}) : super(key: key){
  _currentPage = 0;
  _controller = PageController(
    initialPage: _currentPage,
    viewportFraction: 1
  );
  _changePage();
 }

 Future<void> _changePage() async{

  await Future.delayed(const Duration(seconds: 2));
  _currentPage = _currentPage + 1 >= announcements.length ? 0 : _currentPage + 1;
  if (_controller.hasClients) await _controller.animateToPage(_currentPage, duration: const Duration(milliseconds: 250), curve: Curves.ease);
  await _changePage();
 }

  @override
  Widget build(BuildContext context) {

    final ResponsiveUtil _responsive = ResponsiveUtil.of(context);

    return SizedBox(
      height: _responsive.hp(35),
      child: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: announcements.length,
        itemBuilder: ((context, x) {
          return AnnouncementContainer(announcement: announcements[x]);
        }),
      )
    );
  }
}