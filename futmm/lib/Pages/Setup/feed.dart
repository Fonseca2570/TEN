import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futmm/Pages/Setup/signIn.dart';
import 'package:futmm/Pages/Setup/fields_page.dart';

import 'functions/menuBar.dart';

class feed extends StatefulWidget {
  final FirebaseUser user;

  feed({Key key, this.user}) : super(key: key);
  @override
  _feedState createState() => _feedState();
}
Dialog showalert(String title, String texto, String data, String img) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      height: 500.0,
      width: 300.0,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(img),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(title, style: TextStyle(color: Colors.red),),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(texto, style: TextStyle(color: Colors.red),),
          ),
          Padding(padding: EdgeInsets.only(top: 50.0)),
          FlatButton(onPressed: () {
            BuildContext context;
            Navigator.of(context).pop();
          },
              child: Text(data,
                style: TextStyle(color: Colors.purple, fontSize: 18.0),))
        ],
      ),
    ),
  );
  return errorDialog;
}



class _feedState extends State<feed> {
  int _currentIndex = 0;

  final news = ['Melhor Campo Novembro', 'Abertura da Aplicação', 'Inicio do desenvolvimento','Escolha do Tema', 'Formação do Grupo'];
  final datas = ['Publicado a 30-11-2019','Publicado a 30-12-2019','Publicado a 30-01-2019','Publicado a 30-02-2019','Publicado a 30-03-2019'];
  final noticias = ["O melhor campo do mes de novembro foi o campo xpto",'A partir do dia de hoje a nossa aplicação passou a estar funcional com acesso beta para ser utilizado pelos nosso utilizadores','Começamo hoje a criação da aplicação a mesma está a ser desenvolvida em flutter','O nosso tema é a criação de uma aplicação hibrida que permite fazer Matchmaking de jogos de futebol com amigos ou desconhecidos','Foi formado o nosso grupo para a cadeira de Ten Composta pelos alunos: João Fonseca, Ivo Ferreira, Carlos, Hugo Silva, Bruno, Hugo Alves, Nuno Bandeira'];
  final img = ['assets/imagens/background1.jpg','assets/imagens/open.jpg','assets/imagens/flutter.jpg','assets/imagens/brain_storming.jpg','assets/imagens/team_forming.jpg'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: new Center(child: new Text("Feed", textAlign: TextAlign.center)),
          automaticallyImplyLeading: false
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext ctxt, int index) {
          return ListTile(
            title: Text(news[index]),
            subtitle: Text(datas[index]),
            contentPadding: EdgeInsets.all(25.0),
            onTap: () async {
              showDialog(context: context, builder: (BuildContext context) => showalert(news[index], noticias[index], datas[index], img[index]));
            },
          );

        }),
      // Navegaçao
      bottomNavigationBar: getBar(context, widget.user)
    );
  }
}
