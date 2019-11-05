import 'package:flutter/material.dart';

class feed extends StatefulWidget {
  @override
  _feedState createState() => _feedState();
}
Dialog showalert(String title, String texto, String data) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      /*decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/imagens/background.jpg"),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.circle,
      ),*/
      height: 500.0,
      width: 300.0,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset('assets/imagens/background.jpg'),
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

  final news = ['Melhor Campo Novembro', 'Abertura da Aplicação', 'Inicio do desenvolvimento','Escolha do Tema', 'Formação do Grupo'];
  final datas = ['Publicado a 30-11-2019','Publicado a 30-12-2019','Publicado a 30-01-2019','Publicado a 30-02-2019','Publicado a 30-03-2019'];
  final noticias = ["O melhor campo do mes de novembro foi o campo xpto",'A partir do dia de hoje a nossa aplicação passou a estar funcional com acesso beta para ser utilizado pelos nosso utilizadores','Começamo hoje a criação da aplicação a mesma está a ser desenvolvida em flutter','O nosso tema é a criação de uma aplicação hibrida que permite fazer Matchmaking de jogos de futebol com amigos ou desconhecidos','Foi formado o nosso grupo para a cadeira de Ten Composta pelos alunos: João Fonseca, Ivo Ferreira, Carlos, Hugo Silva, Bruno, Hugo Alves, Nuno Bandeira'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext ctxt, int index) {
          return ListTile(
            title: Text(news[index]),
            subtitle: Text(datas[index]),
            contentPadding: EdgeInsets.all(25.0),
            onTap: () async {/*
              showDialog(context: context, child:
                new AlertDialog(
                  title: new Text(news[index]),
                  content: new Text(noticias[index]),

                )
              );*/
              showDialog(context: context, builder: (BuildContext context) => showalert(news[index], noticias[index], datas[index]));
            },
          );

        }),
    );
  }
}
