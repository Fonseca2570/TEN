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
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextStyle style2 = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);
  List<Widget> makeListWidget(AsyncSnapshot snapshot, FirebaseUser user){
    return snapshot.data.documents.map<Widget>((document){
      return ListTile(
        /*leading: new CircleAvatar(
            backgroundImage: AssetImage(document['img']),
            radius: 30,

        ),*/
        leading: new Material(
          elevation: 4.0,
          //shape: CircleBorder(side: BorderSide(color: Colors.black)),
          shape: ContinuousRectangleBorder(side: BorderSide(color: Colors.black)),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,

          child: Ink.image(
            image: AssetImage(document['img']),
            fit: BoxFit.cover,
            width: 100.0,
            height: 100.0,
            child: InkWell(
              onTap: () {},
            ),
          ),
        ),
        title: Text(document['nome'].toString(),
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold)),
        subtitle: Text(document['tipologia'].toString()+"x"+document['tipologia'].toString(),
            style: style2.copyWith(
                color: Colors.black,)),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new field(value: document['nome'], user: user, data: new DateTime.now(), tipologia: document['tipologia'])));
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
