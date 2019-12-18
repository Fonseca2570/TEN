import 'package:flutter/material.dart';
import 'package:futmm/Pages/Setup/signIn.dart';
import 'package:futmm/Pages/Setup/sign_up.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:theme_provider/theme_provider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
          title: new Center(child: new Text('FutMM', textAlign: TextAlign.center)),
          automaticallyImplyLeading: false

      ),*/
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset("assets/imagens/logo.jpg",height: 250, width: 250,),
            Padding(
              padding: EdgeInsets.all(30.0),
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Color(0xff009933),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: navigateToSignIn,
                child: Text("Login",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Color(0xff66ff33),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: navigateToSignUp,
                child: Text("Registar",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(width: 40),
            Center(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Transform.scale(
                      scale: 1.6,
                      child: Switch(
                        value: DM.isDark,
                        onChanged:(value){
                          setState(() {
                            DM.isDark = value;
                            ThemeProvider.controllerOf(context).nextTheme();
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }

  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ThemeConsumer(child: LoginPage()), fullscreenDialog: true));
  }

  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ThemeConsumer(child: SignUpPage()), fullscreenDialog: true));
  }
}
