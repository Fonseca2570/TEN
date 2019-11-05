import 'package:flutter/material.dart';

class feed extends StatefulWidget {
  @override
  _feedState createState() => _feedState();
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
            onTap: () async {
              showDialog(context: context, child:
                new AlertDialog(
                  title: new Text(news[index]),
                  content: new Text(noticias[index]),
                )
              );
            },
          );

        }),
    );
  }
}
