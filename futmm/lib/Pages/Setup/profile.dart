import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
        title: new Center(child: new Text("Profile")),
        automaticallyImplyLeading: false
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
                StreamBuilder(
                  stream: Firestore.instance.collection('users').where('email', isEqualTo: widget.user.email).snapshots(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return CircularProgressIndicator();
                    }
                    String s = getNick(snapshot).toString().replaceAll("(", "");
                    s = s.replaceAll(")", "");
                    return Text ("Nickname: "+s);
                  },
                ),
                RaisedButton(
                  onPressed: null,
                  child: Icon(Icons.edit),
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: getBar(context,widget.user),
    );
  }
}
getNick(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data.documents
      .map((doc) => doc['nickname']).toString();
}


