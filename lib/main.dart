import 'package:animals_adoption_flutter/bloc/categories/categories_bloc.dart';
import 'package:animals_adoption_flutter/providers/navigator_bar_provider.dart';
import 'package:animals_adoption_flutter/screens/home_page/home_page.dart';
import 'package:animals_adoption_flutter/screens/all_animals/list_of_animals_page.dart';
import 'package:animals_adoption_flutter/screens/map/map_page.dart';
import 'package:animals_adoption_flutter/screens/messages/messages_page.dart';
import 'package:animals_adoption_flutter/screens/profile/profile_page.dart';
import 'package:animals_adoption_flutter/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main(List<String> args) async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesBloc>(
          create: (_) => CategoriesBloc(),
        )
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<NavigatorBarProvider>(create: (context) => NavigatorBarProvider())
        ],
        child: MaterialApp(
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          title: 'Animals Adoption App',
      
          // Theme
          theme: ThemeData(
            scaffoldBackgroundColor: ThemeColors.background
          ),
          routes: {
            '/' : ((context) => const HomePage()),
            '/viewAllAnimals' : ((context) => const ListOfAnimalsPage(animalsToShow: [])),
            '/profile' : ((context) => const ProfilePage()),
            '/map' : ((context) => const MapPage()),
            '/messages' : ((context) => const MessagesPage()),
      
          },
        ),
      ),
    );
  }
}