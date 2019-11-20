import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'functions/menuBar.dart';

class profilePage extends StatefulWidget {
  final FirebaseUser user;

  profilePage({Key key, this.user}) : super(key: key);
  @override
  _profilePageState createState() => _profilePageState();
}



class _profilePageState extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Colocar nome Profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset("assets/imagens/profile.png",height: 200, width: 200,),
            Padding(
              padding: EdgeInsets.all(50.0),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Nickname"),
              ],
            ),
        ],
      ),
      bottomNavigationBar: getBar(context,widget.user),
    );
  }
}
