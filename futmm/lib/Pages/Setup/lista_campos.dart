import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'campos.dart';
import 'package:firebase_database/firebase_database.dart';

class lista_campos extends StatefulWidget {
  @override
  _lista_camposState createState() => _lista_camposState();
}

class _lista_camposState extends State<lista_campos> {
  get navigateToSignIn => null;

  List<Campos> camposList = [];
  @override
  void initState() {
    super.initState();

    DatabaseReference camposRef = FirebaseDatabase.instance.reference().child("Campos");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de campos"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.asset("assets/imagens/logo.png",height: 250, width: 250,),
          Padding(
            padding: EdgeInsets.all(50.0),
          ),
        ],
      ),
    );
  }
}
