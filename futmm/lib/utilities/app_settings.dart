import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:futmm/screens/BottomNavigationScreens/screen_management.dart';
import 'package:futmm/screens/welcome_screen.dart';

// Always use vertical portrait
systemOrientationPortraitUp() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

//
class OnBoardChecked{
  OnBoardChecked._();
  static bool wasSeen = false;
}

// Map of routes available in the app
Map<String, WidgetBuilder> checkRoutes(){
  Map<String, WidgetBuilder> checkRoutes = new Map<String, WidgetBuilder>();
  checkRoutes = {
    '/welcome': (context) => WelcomeScreen(),
    '/mamagement': (context) => ManagementScreen(),
  };
  return checkRoutes;
}