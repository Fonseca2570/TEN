import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futmm/Pages/Setup/field.dart';
import 'package:futmm/Pages/Setup/campo.dart';

class fields extends StatefulWidget {
  @override
  _fieldsState createState() => _fieldsState();
}

class _fieldsState extends State<fields> {

  List<Widget> makeListWidget(AsyncSnapshot snapshot){
    return snapshot.data.documents.map<Widget>((document){
      return ListTile(
        leading: new CircleAvatar(
            child: new Image(image: new AssetImage(document['img'])),
        ),
        title: Text(document['nome'].toString()),
        subtitle: Text(document['tipologia'].toString()),
        onTap: (){
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new field(campo: new Campo(document['nome'], document['tipologia']))));
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
              children: makeListWidget(snapshot),
            );
          },
        ),
      ),
    );
  }
}
