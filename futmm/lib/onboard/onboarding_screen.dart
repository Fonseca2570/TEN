import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:futmm/main.dart';
import 'package:futmm/screens/welcome_screen.dart';
import 'package:futmm/utilities/Dialogs.dart';
import 'package:futmm/utilities/app_settings.dart';
import 'package:futmm/utilities/custom_buttons.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  Dialogs dialogs = new Dialogs();
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  _checkOnBoard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('isonboard', true);
    });
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 2 * SizeConfig.widthMultiplier), /* 8 */
      height: 1 * SizeConfig.heightMultiplier, /* 8 */
      width: isActive ? 6 * SizeConfig.widthMultiplier : 4 * SizeConfig.widthMultiplier, /* 24 e 16 */
      decoration: BoxDecoration(
        color: isActive ? ColorsApp.lightGreenColor : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    systemOrientationPortraitUp();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5 * SizeConfig.heightMultiplier), /* 40.0 */
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _currentPage != _numPages - 3 ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.topLeft,
                          child: FlatButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: (){
                              _pageController.previousPage(
                                duration: Duration(
                                    milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 7.5 * SizeConfig.widthMultiplier,  /* 30.0 */
                            ),
                          ),
                        ),
                      )
                          :Text(''),
                      /*Container(
                          child: FlatButton(
                            onPressed: (){
                              _pageController.previousPage(
                                duration: Duration(
                                    milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 30.0,
                            ),
                          ),
                        ),
                        */
                      _currentPage != _numPages - 1 ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.topRight,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                _pageController.animateToPage(
                                    3,
                                    curve: Curves.ease,
                                    duration: Duration(milliseconds: 550)
                                );
                              },
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  fontSize: 2.5 * SizeConfig.heightMultiplier, /* 20.0 */
                                  color: DM.isDark ? ColorsApp.lightGreenColor : ColorsApp.normalGreenColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                          :Text(''),
                    ],
                  ),
                ),
                Container(
                  height: 71.1 * SizeConfig.heightMultiplier, /* old: 584,4  now: 568,8 */
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboard/onboarding0.png',
                                ),
                                height: 31.2 * SizeConfig.heightMultiplier, /* 250 */
                                width: 72.5 * SizeConfig.widthMultiplier, /* 250  (92.5 * 4 = 330) */
                              ),
                            ),
                            SizedBox(height: 3.75 * SizeConfig.heightMultiplier), /* 30.0 */
                            Text(
                              'Comece a jogar e\ncrie amizades',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 1.87 * SizeConfig.heightMultiplier), /* 15.0 */
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboard/onboarding1.png',
                                ),
                                height: 31.2 * SizeConfig.heightMultiplier, /* 250.0 */
                                width: 72.5 * SizeConfig.widthMultiplier, /* 250  (92.5 * 4 = 330) */
                              ),
                            ),
                            SizedBox(height: 3.75 * SizeConfig.heightMultiplier), /* 30.0 */
                            Text(
                              'Convide os seus amigos\ne deixe-os convidar\noutros amigos',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 1.87 * SizeConfig.heightMultiplier), /* 15.0*/
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/onboard/onboarding2.png',
                                ),
                                height: 31.2 * SizeConfig.heightMultiplier, /* 250.0 */
                                width: 72.5 * SizeConfig.widthMultiplier, /* 250  (92.5 * 4 = 330) */
                              ),
                            ),
                            SizedBox(height: 3.75 * SizeConfig.heightMultiplier), /* 30.0 */
                            Text(
                              'Escolha o campo que\nmais gosta',
                              style: kTitleStyle,
                            ),
                            SizedBox(height: 1.87 * SizeConfig.heightMultiplier), /* 15.0*/
                            Text(
                              'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                              style: kSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                  ],
                ),
                _currentPage != _numPages - 1 ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Seguinte',
                            style: TextStyle(
                              fontSize: 2.75 * SizeConfig.heightMultiplier, /* 22.0 */
                            ),
                          ),
                          SizedBox(width: 2.5 * SizeConfig.widthMultiplier), /* 10.0 */
                          Icon(
                            Icons.arrow_forward,
                            size: 7.5 * SizeConfig.widthMultiplier, /* 30.0 */
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : Expanded(
                  child: Align(
                    alignment: Alignment(0 * SizeConfig.widthMultiplier, 0.155 * SizeConfig.heightMultiplier), /* 0 , 1.24*/
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10 * SizeConfig.widthMultiplier), /* 40 */
                      child: SizedBox(
                        width: double.infinity,
                        height: 6.5 * SizeConfig.heightMultiplier, /* 52 */
                        child: NotFilledButton(
                            text: 'Começar Agora',
                            onPressed: () {
                              _checkOnBoard();
                              Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) =>
                                  ThemeConsumer(child: WelcomeScreen())), (Route<dynamic> route) => false);
                            }
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
