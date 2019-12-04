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

Dialog editImage(FirebaseUser user, TextEditingController myController, BuildContext context){
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      height: 300.0,
      width: 200.0,
      child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 6.0)
                ),
                InkWell(
                  onTap: () {
                    Firestore.instance.collection('users').document(user.uid).updateData({
                      'url': 'profile.png',
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset('assets/imagens/profile.png',
                          width: 80, height: 80),
                    ),),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 6.0)
                ),
                InkWell(
                  onTap: () {
                    Firestore.instance.collection('users').document(user.uid).updateData({
                      'url': 'ouro.jpg',
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("assets/imagens/ouro.jpg", height: 80, width: 80,
                          ),
                    ),),
                ),

                Padding(
                    padding: EdgeInsets.only(left: 6.0)
                ),
                InkWell(
                  onTap: () {
                    Firestore.instance.collection('users').document(user.uid).updateData({
                      'url': 'chuteira.jpg',
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("assets/imagens/chuteira.jpg", height: 80, width: 80,),
                    ),
                  ),
                ),

              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 6.0)
                ),
                InkWell(
                  onTap: () {
                    Firestore.instance.collection('users').document(user.uid).updateData({
                      'url': 'oliver.jpg',
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("assets/imagens/oliver.jpg", height: 80, width: 80,),
                    ),
                  ),
                ),

                Padding(
                    padding: EdgeInsets.only(left: 6.0)
                ),
                InkWell(
                  onTap: () {
                    Firestore.instance.collection('users').document(user.uid).updateData({
                      'url': 'benji.jpg',
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("assets/imagens/benji.jpg", height: 80, width: 80,),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 6.0)
                ),
                InkWell(
                  onTap: () {
                    Firestore.instance.collection('users').document(user.uid).updateData({
                      'url': 'tobi.jpg',
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset("assets/imagens/tobi.jpg", height: 80, width: 80,),
                    ),
                  ),
                ),

              ],
            ),
          ]
      ),
    ),
  );
  return errorDialog;
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
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black)
                ),
                hintText: nickname,
              prefixIcon: const Icon(Icons.person, color: Colors.green,),
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
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            StreamBuilder(
              stream: Firestore.instance.collection('users').where('email', isEqualTo: widget.user.email).snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Image.asset("assets/imagens/profile.png",height: 200, width: 200,);
                }
                else{
                  String img = snapshot.data.documents.map((doc) => doc['url']).toString().replaceAll("(", "").replaceAll(")", "");
                  return Image.asset(
                    "assets/imagens/"+img, height: 200, width: 200,
                  );
                }

              }
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(6.0),
                  ),
                  RaisedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext context) => editImage(widget.user, myController, context));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.edit,
                          ),
                          Text("Editar Imagem"),
                        ],
                      )

                  ),
                ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.edit,
                      ),
                      Text("Editar nickname"),
                    ],
                  ),
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
  if(newNick != "") {
    Firestore.instance.collection('users').document(user.uid).updateData({
      'nickname': newNick
    });
  }
}


