import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futmm/utilities/app_settings.dart';
import 'package:futmm/utilities/custom_buttons.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:theme_provider/theme_provider.dart';
import 'Auth/login_screen.dart';
import 'Auth/register_screen.dart';

/* DEVELOPED BASED ON ASUS MEASUREMENTS (CHECK size_config file at the end of uncommented code*/

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    systemOrientationPortraitUp();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.jpg'),
              ),
            ),
          ),

          Container(
            color: DM.isDark ? ColorsApp.blackColor.withOpacity(0.80) : ColorsApp.whiteColor.withOpacity(0.80),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5 * SizeConfig.heightMultiplier), /* 40.0 */
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/original_logo.png'),
                            height: 10.2 * SizeConfig.heightMultiplier, /* 80 */
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.20 * SizeConfig.heightMultiplier), /* 25 */
                    Container(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              'Bem vindo\nao FutMM',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 4.23 * SizeConfig.heightMultiplier, /* 33 */
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 9.61 * SizeConfig.heightMultiplier), /* 75 */
                    Container(
                      child: Center(
                        child: Text(
                          'Antes de usar a App, fique a\nsaber que pode alternar para\no modo escuro. Assim facilita\no uso durante a noite.',
                          style: TextStyle(
                            fontSize: 2.43 * SizeConfig.heightMultiplier, /* 19 */
                            height: 0.22 * SizeConfig.heightMultiplier, /* 1.76 */
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.84 * SizeConfig.heightMultiplier), /* 30 */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Modo escuro',
                          style: TextStyle(
                            fontSize: 2.60 * SizeConfig.heightMultiplier, /* 18 */
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10.8 * SizeConfig.widthMultiplier), /* 40 */
                        Center(
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Transform.scale(
                                  scale: 0.17 * SizeConfig.heightMultiplier, /* new: 1.326 old: 1.5 */
                                  child: Switch(
                                    value: DM.isDark,
                                    onChanged:(value){
                                      setState(() {
                                        DM.isDark = value;
                                        ThemeProvider.controllerOf(context).nextTheme();
                                      });
                                    },
                                    activeTrackColor: ColorsApp.normalGreenColor,
                                    activeColor: ColorsApp.brightGreenColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 9.61 * SizeConfig.heightMultiplier), /* 75 */
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.8 * SizeConfig.widthMultiplier), /* 40 */
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            height: 6.66 * SizeConfig.heightMultiplier, /* 52 */
                            child: FilledButton(
                              text: 'Iniciar sessão',
                              onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ThemeConsumer(child: LoginScreen()))),
                            ),
                          ),
                          SizedBox(height: 3.20 * SizeConfig.heightMultiplier), /* 25 */
                          SizedBox(
                            width: double.infinity,
                            height: 6.66 * SizeConfig.heightMultiplier, /* 52 */
                            child: NotFilledButton(
                              text: 'Criar conta',
                              onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ThemeConsumer(child: RegisterScreen()))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
