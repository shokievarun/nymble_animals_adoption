import 'package:animals_adoption_flutter/bloc/categories/categories_bloc.dart';
import 'package:animals_adoption_flutter/db/hive_db.dart';
import 'package:animals_adoption_flutter/db/pet.dart';
import 'package:animals_adoption_flutter/providers/navigator_bar_provider.dart';
import 'package:animals_adoption_flutter/screens/history_page/history_page.dart';
import 'package:animals_adoption_flutter/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  // Initialize hive
  await Hive.initFlutter();
  Hive.registerAdapter(AnimalModelAdapter());
  await Hive.openBox('isLightTheme');
  await Hive.openBox('animalBox');
  await HiveDB.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesBloc>(
          create: (_) => CategoriesBloc(false),
        )
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<NavigatorBarProvider>(
              create: (context) => NavigatorBarProvider())
        ],
        child: MaterialApp(
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          title: 'Nymble Animal Adoption',
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: _themeMode, // standard dark theme

          routes: {
            '/': ((context) => HomePage()),
            // '/viewAllAnimals': ((context) =>
            //     const ListOfAnimalsPage(animalsToShow: [])),
            '/history': ((context) => const HistoryPage()),
            // '/profile': ((context) => const ProfilePage()),
            // '/map': ((context) => const MapPage()),
            //'/messages': ((context) => const MessagesPage()),
          },
        ),
      ),
    );
  }
}
