import 'package:flutter/material.dart';
import 'package:futmm/Pages/Setup/signIn.dart';
import 'package:futmm/Pages/Setup/sign_up.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: new Center(child: new Text('FutMM', textAlign: TextAlign.center)),
          automaticallyImplyLeading: false

      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset("assets/imagens/logo.png",height: 250, width: 250,),
            Padding(
              padding: EdgeInsets.all(50.0),
            ),
            RaisedButton(
              onPressed: navigateToSignIn,
              child: Text('Sign in'),
            ),
            RaisedButton(
              onPressed: navigateToSignUp,
              child: Text('Sign up'),
            ),
          ],
        ),
    );
  }

  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(), fullscreenDialog: true));
  }
}
