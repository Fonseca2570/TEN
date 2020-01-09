import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futmm/models/user_models.dart';
import 'package:futmm/screens/BottomNavigationScreens/Profile_Tab/edit_profile_screen.dart';
import 'package:futmm/services/auth_service.dart';
import 'package:futmm/utilities/app_settings.dart';
import 'package:futmm/utilities/constants.dart';
import 'package:futmm/utilities/custom_buttons.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:theme_provider/theme_provider.dart';

/* DEVELOPED BASED ON ASUS MEASUREMENTS (CHECK size_config file at the end of uncommented code*/

class ProfileScreen extends StatefulWidget {

  final String userId;
  ProfileScreen({this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    systemOrientationPortraitUp();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(5 * SizeConfig.widthMultiplier, 6 * SizeConfig.heightMultiplier, 5 * SizeConfig.widthMultiplier , 0.0), /* 40.0 */
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: usersRef.document(widget.userId).get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              User user = User.fromDoc(snapshot.data);
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Definições',
                        style: TextStyle(
                          fontFamily: 'CM Sans Serif',
                          fontSize: 3.5 * SizeConfig
                              .heightMultiplier, /* old: 26.0 now: 24.0 */
                          height: 0.1875 * SizeConfig
                              .heightMultiplier, /* old: 1.5  old2: 1.26  now: 1.58 */
                        ),
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.settings,
                          size: 6.48 * SizeConfig.widthMultiplier, /* 24 */
                          color: checkDarkTheme(context) ? ColorsApp
                              .brightGreenColor : ColorsApp.normalGreenColor,
                        ),
                        onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ThemeConsumer(child: EditProfileScreen(user: user)))),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.84 * SizeConfig.heightMultiplier), /* 30 */
                  /*CircularProgressIndicator(),*/
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorsApp.lightGreyColor2,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundColor: checkDarkTheme(context) ? ColorsApp.blackColor : ColorsApp.whiteColor,
                      backgroundImage: user.profileImageUrl.isEmpty ? AssetImage('assets/images/UserApp/user_placeholder.jpg') : CachedNetworkImageProvider(user.profileImageUrl),
                    ),
                  ),
                  SizedBox(height: 1.28 * SizeConfig.heightMultiplier), /* 10 */
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        user.name,
                        style: kTitleStyle,
                      ),
                      Text(
                        user.email,
                        style: kSubtitleStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.12 * SizeConfig.heightMultiplier), /* 40 */
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.8 * SizeConfig.widthMultiplier), /* 40 */
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: 6.28 * SizeConfig.heightMultiplier, /*new: 49 old: 52 -> 6.66*/
                          child: FilledButton(
                            text: 'Logout',
                            onPressed: () => AuthService.logout(context),
                          ),
                        ),
                        SizedBox(height: 6.41 * SizeConfig.heightMultiplier), /* 50 */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Modo escuro',
                              style: TextStyle(
                                fontSize: 2.60 * SizeConfig.heightMultiplier, /* 18 */
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Transform.scale(
                              scale: 0.17 * SizeConfig.heightMultiplier, /* new: 1.326 old: 1.5 */
                              child: Switch(
                                value: DM.isDark,
                                onChanged: (value) {
                                  setState(() {
                                    DM.isDark = value;
                                    ThemeProvider.controllerOf(context).nextTheme();
                                  });
                                },
                                activeTrackColor: ColorsApp.normalGreenColor,
                                activeColor: ColorsApp.brightGreenColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
