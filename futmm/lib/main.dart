import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:theme_provider/theme_provider.dart';
import 'Pages/onboard/onboarding_screen.dart';
import 'dart:async';

void main() {
  runApp(
      LoaderS()
  );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget noSlideGlow, AxisDirection axisDirection) {
    return noSlideGlow;
  }
}

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
                  return ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: noSlideGlow,
                  );
                },
                debugShowCheckedModeBanner: false,
                home: ThemeConsumer(
                  child: ThemeConsumer(child: MyApp()),
                ),
              ),
            );
          },
        );
      },
    );
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
          (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ThemeConsumer(child: OnboardingScreen()),
        ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 50 * SizeConfig.heightMultiplier, /* 400 */
          width: 100 * SizeConfig.widthMultiplier, /* 400 */
          child: Image.asset(
            'assets/images/original_logo.png',
            /*scale: 0.2 * SizeConfig.imageSizeMultiplier, *//* 0.6 */
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:futmm/Pages/Setup/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: WelcomePage(),
    );
  }
}*/
