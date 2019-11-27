import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futmm/Pages/Setup/campo.dart';
import 'functions/menuBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class field extends StatefulWidget {
  String value;
  final FirebaseUser user;

  field({Key key, this.value, this.user}) : super(key: key);
  @override
  _fieldState createState() => _fieldState();
}

class _fieldState extends State<field> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.value),
      ),

      body: Column(
        children: <Widget>[
              StreamBuilder(
                stream: Firestore.instance.collection('campos/'+widget.value+'/Data').where('data', isEqualTo: '20-12-2019').snapshots(),
                builder: (context,snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  else {
                    String hora = snapshot.data.documents.map((
                        doc) => doc['15-16']).toString()
                        .replaceAll("(", "")
                        .replaceAll(")", "");
                    if(hora == ""){
                      hora = "0";
                    }
                    return ListTile(
                      title: Text('Horario das 15:00 até as 16:00 '),
                      subtitle: Text('Nº de elementos neste horario ' + hora),
                    );
                  }
                },
              ),
          StreamBuilder(
            stream: Firestore.instance.collection('campos/Afurada/Data').where('data', isEqualTo: '20-12-2019').snapshots(),
            builder: (context,snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              else {
                String hora = snapshot.data.documents.map((
                    doc) => doc['16-17']).toString()
                    .replaceAll("(", "")
                    .replaceAll(")", "");
                if(hora == ""){
                  hora = "0";
                }
                return ListTile(
                  title: Text('Horario das 16:00 até as 17:00 '),
                  subtitle: Text('Nº de elementos neste horario ' + hora),
                );
              }
            },
          ),
          StreamBuilder(
            stream: Firestore.instance.collection('campos/Afurada/Data').where('data', isEqualTo: '20-12-2019').snapshots(),
            builder: (context,snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              else {
                String hora = snapshot.data.documents.map((
                    doc) => doc['17-18']).toString()
                    .replaceAll("(", "")
                    .replaceAll(")", "");
                if(hora == ""){
                  hora = "0";
                }
                return ListTile(
                  title: Text('Horario das 17:00 até as 18:00 '),
                  subtitle: Text('Nº de elementos neste horario ' + hora),
                );
              }
            },
          ),
          StreamBuilder(
            stream: Firestore.instance.collection('campos/Afurada/Data').where('data', isEqualTo: '20-12-2019').snapshots(),
            builder: (context,snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              else {
                String hora = snapshot.data.documents.map((
                    doc) => doc['18-19']).toString()
                    .replaceAll("(", "")
                    .replaceAll(")", "");
                if(hora == ""){
                  hora = "0";
                }
                return ListTile(
                  title: Text('Horario das 18:00 até as 19:00 '),
                  subtitle: Text('Nº de elementos neste horario ' + hora),
                );
              }
            },
          ),
          StreamBuilder(
            stream: Firestore.instance.collection('campos/Afurada/Data').where('data', isEqualTo: '20-12-2019').snapshots(),
            builder: (context,snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              else {
                String hora = snapshot.data.documents.map((
                    doc) => doc['19-20']).toString()
                    .replaceAll("(", "")
                    .replaceAll(")", "");
                if(hora == ""){
                  hora = "0";
                }
                return ListTile(
                  title: Text('Horario das 19:00 até as 20:00 '),
                  subtitle: Text('Nº de elementos neste horario ' + hora),
                );
              }
            },
          ),

        ],

      ),
      bottomNavigationBar: getBar(context, widget.user)
    );
  }
}
