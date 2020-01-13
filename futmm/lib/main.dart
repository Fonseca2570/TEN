import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futmm/screens/BottomNavigationScreens/screen_management.dart';
import 'package:futmm/screens/welcome_screen.dart';
import 'package:futmm/utilities/app_settings.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import 'onboard/onboarding_screen.dart';

void main() {
  runApp(LoaderS());
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget noSlideGlow, AxisDirection axisDirection) {
    return noSlideGlow;
  }
}

// CLASS AppStart
class AppStart extends StatefulWidget {

  @override
  _AppStartState createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  @override

  /*Future<Widget> _getScreenId(BuildContext context) async{
    return Navigator.push(context, CupertinoPageRoute(
      builder: (context) => StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return ThemeConsumer(child: ManagementScreen());
          }else {
            return ThemeConsumer(child: WelcomeScreen());
          }
        },
      ),
    ));
  }*/

  void initState() {
    super.initState();
    _loadCounter();
    Future.delayed(
      Duration(milliseconds: 500),
          (){
        if (OnBoardChecked.wasSeen == true){
          Navigator.pushReplacement(context, CupertinoPageRoute(
            builder: (context) => StreamBuilder<FirebaseUser>(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return ThemeConsumer(child: ManagementScreen(userId: snapshot.data.uid));
                }else {
                  return ThemeConsumer(child: WelcomeScreen());
                }
              },
            ),
          ));
        }else if (OnBoardChecked.wasSeen == false){
          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => ThemeConsumer(child: OnboardingScreen())));
        }
      },
    );
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      OnBoardChecked.wasSeen = (prefs.getBool('onboard') ?? false);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    systemOrientationPortraitUp();
    return Scaffold(
      backgroundColor: ColorsApp.whiteColor,
      body: Center(
        child: SizedBox(
          height: 24.875 * SizeConfig.heightMultiplier, /* 400 */
          width: 49.75 * SizeConfig.widthMultiplier, /* 400 */
          child: Image.asset(
            'assets/images/splashscreen_logo.png',
            /*scale: 0.2 * SizeConfig.imageSizeMultiplier, *//* 0.6 */
          ),
        ),
      ),
    );
  }
}
// END OF CLASS

class LoaderS extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);
            return ThemeProvider(
              saveThemesOnChange: true,
              loadThemeOnInit: true,
              defaultThemeId: "light_theme",
              themes: <AppTheme>[
                OurThemes.lightModeTheme(),
                OurThemes.darkModeTheme(),
              ],
              child: MaterialApp(
                builder: (context, noSlideGlow) {
                  checkCurrentTheme(context); // check the current Theme used.
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    systemNavigationBarIconBrightness: DM.isDark ? Brightness.light : Brightness.dark,
                    statusBarIconBrightness: DM.isDark ? Brightness.light : Brightness.dark,
                  ));
                  return ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: noSlideGlow,
                  );
                },
                debugShowCheckedModeBanner: false,
                home: AppStart(),
              ),
            );
          },
        );
      },
    );
  }
}