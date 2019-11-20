import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futmm/Pages/Setup/campo.dart';
import 'functions/menuBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class field extends StatefulWidget {
  String value;

  field({Key key, this.value}) : super(key: key);
  @override
  _fieldState createState() => _fieldState();
}

class _fieldState extends State<field> {

  List<Widget> makeListWidget(AsyncSnapshot snapshot){
    return snapshot.data.documents.map<Widget>((document){
      return ListTile(
        title: Text(document['15-16'].toString()),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.value),
      ),

      body: Container(

        padding: EdgeInsets.all(16.0),

        child: StreamBuilder(
          stream: Firestore.instance.collection('campos/Afurada/Data').snapshots(),
          builder: (context,snapshot){
            if(snapshot.data == null) return CircularProgressIndicator();
            return ListView(
              children: makeListWidget(snapshot),
            );
          },
        ),
      ),
      bottomNavigationBar: getBar(context)
    );
  }
}
