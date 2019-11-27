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

Dialog editNickname(String nickname, FirebaseUser user, TextEditingController myController, BuildContext context) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      height: 300.0,
      width: 200.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: myController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: nickname,

            ),

          ),
          RaisedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.save),
                Text("Guardar")
              ],
            ),
            onPressed: () {
              //print(myController.text);
              if(myController.text != ""){
                updateValores(myController.text, user);
                Navigator.push(context, MaterialPageRoute(builder: (context) => profilePage(user: user)));
              }
            },
            color: Colors.green,

          )
        ]
      ),
    ),
  );
  return errorDialog;
}



class _profilePageState extends State<profilePage> {
  @override
  String s;
  final myController = TextEditingController();
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
                    s = getNick(snapshot).toString().replaceAll("(", "").replaceAll(")", "");
                    return Text ("Nickname: "+s);
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    showDialog(context: context, builder: (BuildContext context) => editNickname(s, widget.user, myController, context));
                  },
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

updateValores(String newNick, FirebaseUser user) async{
  Firestore.instance.collection('users').document(user.uid).updateData({
    'nickname' : newNick
  });
}


