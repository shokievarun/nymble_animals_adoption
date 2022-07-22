import 'package:animals_adoption_flutter/providers/navigator_bar_provider.dart';
import 'package:animals_adoption_flutter/screens/home_page.dart';
import 'package:animals_adoption_flutter/screens/list_of_animals_page.dart';
import 'package:animals_adoption_flutter/screens/map_page.dart';
import 'package:animals_adoption_flutter/screens/messages_page.dart';
import 'package:animals_adoption_flutter/screens/profile_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  ),
);

// void main(List<String> args) {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigatorBarProvider>(create: (context) => NavigatorBarProvider())
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        builder: DevicePreview.appBuilder,
        locale: DevicePreview.locale(context),
        debugShowCheckedModeBanner: false,
        title: 'Animals Adoption App',
    
        // Theme
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
        ),
        initialRoute: '/home',
        home: const HomePage(),
        routes: {
    
          '/home' : ((context) => const HomePage()),
          '/viewAllAnimals' : ((context) => const ListOfAnimalsPage()),
          '/profile' : ((context) => const ProfilePage()),
          '/map' : ((context) => const MapPage()),
          '/messages' : ((context) => const MessagesPage()),
    
        },
      ),
    );
  }
}