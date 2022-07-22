

import 'package:flutter/widgets.dart';
export 'package:provider/provider.dart';

class NavigatorBarProvider extends ChangeNotifier {

  late int _currentRouteIndex;

  int get currentRoute => _currentRouteIndex;
  set currentRoute(final int newRoute){
    _currentRouteIndex = newRoute;
    notifyListeners();
  }

  NavigatorBarProvider(){
    _currentRouteIndex = 0;
  }
}