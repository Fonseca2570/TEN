import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futmm/utilities/app_settings.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'Fields_Tab/fields_screen.dart';
import 'Home_Tab/home_screen.dart';
import 'Matches_Tab/matches_screen.dart';
import 'Scoreboard_Tab/scoreboard_screen.dart';
import 'Profile_Tab/profile_screen.dart';

class ManagementScreen extends StatefulWidget {

  final String userId;
  ManagementScreen({this.userId});

  @override
  _ManagementScreenState createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {

  int _currentTab = 2;
  PageController _pageController;
  @override
  void initState(){
    //TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 2);
  }

  Widget build(BuildContext context) {
    systemOrientationPortraitUp();
    return Scaffold(
      appBar: null,
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FieldsScreen(userId: widget.userId),
          ScoreboardScreen(),
          HomeScreen(),
          MatchesScreen(),
          ProfileScreen(userId: widget.userId),
        ],
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 2.05 * SizeConfig.heightMultiplier), /* 16 */
        child: CupertinoTabBar(
          currentIndex: _currentTab,
          onTap: (int index){
            setState(() {
              _currentTab = index;
            });
            _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.linear);
          },
          activeColor: checkDarkTheme(context) ? ColorsApp.brightGreenColor : ColorsApp.normalGreenColor,
          backgroundColor: Colors.transparent,
          border: null,
          inactiveColor: ColorsApp.lightGreyColor2,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_balance,
                size: 6.48 * SizeConfig.widthMultiplier, /* 24 */
              ),
              title: Text('Campos'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.equalizer,
                size: 6.48 * SizeConfig.widthMultiplier, /* 24 */
              ),
              title: Text('Classificação'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 6.48 * SizeConfig.widthMultiplier, /* 24 */
              ),
              title: Text('Início'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.date_range,
                size: 6.48 * SizeConfig.widthMultiplier, /* 24 */
              ),
              title: Text('Partidas'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 6.48 * SizeConfig.widthMultiplier, /* 24 */
              ),
              title: Text('Definições'),
            ),
          ],
        ),
      ),
    );
  }
}

/*return Scaffold(
body: GestureDetector(
onTap: () {FocusScope.of(context).requestFocus(new FocusNode());},
child: SingleChildScrollView(
child: Stack(
children: <Widget>[
SingleChildScrollView(
child: Container(
height: MediaQuery.of(context).size.height,
decoration: BoxDecoration(
image: DecorationImage(
fit: BoxFit.cover,
image: AssetImage('assets/images/background.jpg'),
),
),
),
),
SingleChildScrollView(
child: Container(
height: MediaQuery.of(context).size.height,
color: DM.isDark ? ColorsApp.blackColor.withOpacity(0.80) : ColorsApp.whiteColor.withOpacity(0.80),
),
),
Padding(
padding: EdgeInsets.symmetric(horizontal: 10.8 * SizeConfig.widthMultiplier),
 40

child: Container(
height: MediaQuery.of(context).size.height,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
Center(
child: Text(
'Páginal Inicial/\nMenu Inicial',
textAlign: TextAlign.center,
style: TextStyle(
fontSize: 4.23 * SizeConfig.heightMultiplier,
 33

fontWeight: FontWeight.bold,
),
),
),
SizedBox(height: 7.69 * SizeConfig.heightMultiplier),
 60
],
),
),
),
],
),
),
),
);*/