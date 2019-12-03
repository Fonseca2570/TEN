import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futmm/Pages/Setup/field.dart';
import 'package:futmm/Pages/Setup/campo.dart';
import 'package:futmm/Pages/Setup/signIn.dart';
import 'package:futmm/Pages/Setup/feed.dart';
import 'package:futmm/Pages/Setup/functions/menuBar.dart';

class fields extends StatefulWidget {
  final FirebaseUser user;

  fields({Key key, this.user}) : super(key: key);
  @override
  _fieldsState createState() => _fieldsState();
}

class _fieldsState extends State<fields> {

  List<Widget> makeListWidget(AsyncSnapshot snapshot, FirebaseUser user){
    return snapshot.data.documents.map<Widget>((document){
      return ListTile(
        leading: new CircleAvatar(
            child: new Image(image: new AssetImage(document['img'])),
        ),
        title: Text(document['nome'].toString()),
        subtitle: Text(document['tipologia'].toString()),
        onTap: (){
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new field(value: document['nome'], user: user, data: new DateTime.now())));
        },
      );
    }).toList();
  }


  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campos'),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection('campos').snapshots(),
          builder: (context,snapshot){
            if(snapshot.data == null) return CircularProgressIndicator();
            return ListView(
              children: makeListWidget(snapshot, widget.user),
            );
          },
        ),
      ),
      bottomNavigationBar: getBar(context,widget.user),
    );
  }
}
