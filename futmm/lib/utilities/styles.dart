import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futmm/onboard/onboarding_screen.dart';
import 'package:futmm/screens/welcome_screen.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';


/*class OBW{
  OBW._();
  static bool isSeen = false;
}*/

/*splashScreenStatus(bool isThere){
  if(isThere == true){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
  }else{
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: DM.isDark ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: DM.isDark ? Brightness.light : Brightness.dark,
    ));
  }
}*/

checkCurrentStatus(BuildContext context){
  var checkTheme = ThemeProvider.themeOf(context).id;
  if(checkTheme == 'dark_theme'){
    return true;
  }else{
    return false;
  }
}

// Initialize the global variable that will define if the app is in dark mode or not
class DM {
  DM._();
  static bool isDark = false;
}
// ------------------------------------------------

// Check the current theme and set the variable above to true of false on startup
checkCurrentTheme(BuildContext context){
  var checkTheme = ThemeProvider.themeOf(context).id;
  checkTheme == 'dark_theme' ? DM.isDark = true : DM.isDark = false;
}
// ------------------------------------------------


//Check the current theme and return bool value to change attributes inside app
checkDarkTheme(BuildContext context){
  var checkTheme = ThemeProvider.themeOf(context).id;
  if(checkTheme == 'dark_theme'){
    return true;
  }else{
    return false;
  }
}
//-------------------------------------------------


// Defined the 2 themes this App has. LightMode and DarkMode
class OurThemes{
  OurThemes._();

  static AppTheme lightModeTheme() {
    return AppTheme(
      id: "light_theme",
      description: "Light Theme",
      data: ThemeData(
        accentColor: ColorsApp.dirtyWhiteColor,
        primaryColor: ColorsApp.whiteColor,
        scaffoldBackgroundColor: ColorsApp.whiteColor,
        brightness: Brightness.light,
        dialogBackgroundColor: ColorsApp.whiteColor,
        textTheme: AppThemes.lightTextTheme,
      ),
    );
  }

  static AppTheme darkModeTheme() {
    return AppTheme(
      id: "dark_theme",
      description: "Black Theme",
      data: ThemeData(
        accentColor: ColorsApp.lightGreyColor2,
        primaryColor: ColorsApp.greyColor,
        scaffoldBackgroundColor: ColorsApp.blackColor,
        brightness: Brightness.dark,
        dialogBackgroundColor: ColorsApp.blackColor,
        textTheme: AppThemes.darkTextTheme,
      ),
    );
  }
}
// ------------------------------------------------

// Defined the Primary and Second Colors that will be used in this App
class ColorsApp {
  ColorsApp._();

  // Main/ Primary Colors
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color normalGreenColor = Color(0xFF009118);  //007012 Old one
  static const Color brightGreenColor = Color(0xFF04DB27);

  // Secondary Colors
  static const Color lightGreenColor = Color(0xFF65CB5D);
  static const Color bGDirtyWhiteColor = Color(0xFFF6F5EB);
  static const Color dirtyWhiteColor = Color(0xFFF5F5F2);
  static const Color greyColor = Color(0xFF707070);
  static const Color lightGreyColor = Color(0xFFE2E2E2);
  static const Color lightGreyColor2 = Color(0xFFC8C8C8); // Not so much used
}


class AppThemes {
  AppThemes._();

  /*static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsApp.whiteColor,
    brightness: Brightness.light,
    textTheme: lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsApp.blackColor,
    brightness: Brightness.dark,
    textTheme: darkTextTheme,
  );*/

  //TextTheme Configuration

  static final TextTheme lightTextTheme = TextTheme(
    title: _titleLight,
    subtitle: _subtitleLight,
    button: _buttonLight,
  );

  static final TextTheme darkTextTheme = TextTheme(
    title: _titleDark,
    subtitle: _subtitleDark,
    button: _buttonDark,
  );


  // LIGHT TextTheme ATRIBUTES configuration

  static final TextStyle _titleLight = TextStyle(
    color: ColorsApp.blackColor,
    fontSize: 3 * SizeConfig.heightMultiplier, /* 24.0 */
  );

  static final TextStyle _subtitleLight = TextStyle(
    color: ColorsApp.lightGreyColor,
    fontSize: 1.75 * SizeConfig.heightMultiplier, /* 14 */
    height: 0.1875 * SizeConfig.heightMultiplier, /* 1.5 */
  );

  static final TextStyle _buttonLight = TextStyle(
    color: ColorsApp.blackColor,
    fontSize: 2.25 * SizeConfig.heightMultiplier, /* 18 */
  );


  // Black TextTheme ATRIBUTES configuration

  static final TextStyle _titleDark = _titleLight.copyWith(color: ColorsApp.dirtyWhiteColor);
  static final TextStyle _subtitleDark = _subtitleLight.copyWith(color: ColorsApp.dirtyWhiteColor);
  static final TextStyle _buttonDark = _titleLight.copyWith(color: ColorsApp.whiteColor);
}

// Custom font styles for the OnBoardingScreen

final kTitleStyle = TextStyle(
  fontFamily: 'CM Sans Serif',
  fontSize: 3 * SizeConfig.heightMultiplier, /* old: 26.0 now: 24.0 */
  height: 0.1875 * SizeConfig.heightMultiplier, /* old: 1.5  old2: 1.26  now: 1.58 */
);

final kSubtitleStyle = TextStyle(
  color: ColorsApp.greyColor,
  fontSize: 2.25 * SizeConfig.heightMultiplier, /* 18.0 */
  height: 0.19 * SizeConfig.heightMultiplier, /* old: 1.2 now: 1.6 */
);