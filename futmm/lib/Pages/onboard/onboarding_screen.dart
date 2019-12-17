import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:futmm/Pages/Setup/welcome.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:theme_provider/theme_provider.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 2 * SizeConfig.widthMultiplier), /* 8 */
      height: 1 * SizeConfig.heightMultiplier, /* 8 */
      width: isActive ? 6 * SizeConfig.widthMultiplier : 4 * SizeConfig.widthMultiplier, /* 24 e 16 */
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: DM.isDark ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: DM.isDark ? Brightness.light : Brightness.dark,
    ));*/
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
          ),
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
                            'Próximo',
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
                    child: SizedBox(
                      width: 87.5 * SizeConfig.widthMultiplier, /* 350 */
                      height: 6.5 * SizeConfig.heightMultiplier, /* 52 */
                      child: OutlineButton(
                          shape: StadiumBorder(),
                          splashColor: ColorsApp.lightGreenColor,
                          highlightColor: Colors.transparent,
                          highlightedBorderColor: ColorsApp.normalGreenColor,
                          child: Text('Começar agora',
                            style: TextStyle(
                              fontSize: 2.25 * SizeConfig.heightMultiplier, /* 18 */
                            ),
                          ),
                          borderSide: BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 0.475 * SizeConfig.widthMultiplier, /* 1.9 */
                          ),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ThemeConsumer(child: WelcomePage()),
                          )),
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
