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

  horarios(String campo, String horas, String data){
    return StreamBuilder(
      stream: Firestore.instance.collection('campos/'+campo+'/Data').where('data', isEqualTo: data).snapshots(),
      builder: (context,snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        else {
          String hora = snapshot.data.documents.map((
              doc) => doc[horas]).toString()
              .replaceAll("(", "")
              .replaceAll(")", "");
          if(hora == ""){
            hora = "0";
          }
          List<String> horas1 = horas.split("-");
          return ListTile(
            title: Text('Horario das '+horas1[0]+':00 até as '+horas1[1]+':00 '),
            subtitle: Text('Nº de elementos neste horario ' + hora),
          );
        }
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.value),
      ),

      body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 500,
              ),
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: Firestore.instance.collection('campos').where('nome',isEqualTo: widget.value).snapshots(),
                    builder: (context,snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      else{
                        return Container(
                          constraints: BoxConstraints.expand(
                          height: 200.0
                        ),
                        child: Image.asset(snapshot.data.documents.map((
                          doc) => doc['img']).toString().replaceAll("(", "").replaceAll(")", ""),width: 300,height: 300,)
                        );
                      }
                    },
                  ),
                  horarios(widget.value, "15-16", "20-12-2019"),
                  horarios(widget.value, "16-17", "20-12-2019"),
                  horarios(widget.value, "17-18", "20-12-2019"),
                  horarios(widget.value, "18-19", "20-12-2019"),
                  horarios(widget.value, "19-20", "20-12-2019"),


                ],

              ),
          ),
      ),


      bottomNavigationBar: getBar(context, widget.user)
    );
  }
}
