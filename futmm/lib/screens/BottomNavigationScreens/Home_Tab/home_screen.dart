import 'package:flutter/material.dart';
import 'package:futmm/utilities/app_settings.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Dialog showalert(String title, String texto, String data, String img) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      height: 600.0,
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

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final news = ['Melhor Campo Fevereiro', 'Abertura da Aplicação', 'Inicio do desenvolvimento','Escolha do Tema', 'Formação do Grupo'];
  final datas = ['Publicado a 02-02-2020','Publicado a 01-02-2020','Publicado a 16-12-2019','Publicado a 15-12-2019','Publicado a 30-11-2019'];
  final noticias = ["O melhor campo do mes de novembro foi o campo xpto",'A partir do dia de hoje a nossa aplicação passou a estar funcional com acesso beta para ser utilizado pelos nosso utilizadores','Começamo hoje a criação da aplicação a mesma está a ser desenvolvida em flutter','O nosso tema é a criação de uma aplicação hibrida que permite fazer Matchmaking de jogos de futebol com amigos ou desconhecidos','Foi formado o nosso grupo para a cadeira de Ten Composta pelos alunos: João Fonseca, Ivo Ferreira, Carlos, Hugo Silva, Bruno, Hugo Alves, Nuno Bandeira'];
  final img = ['assets/imagens/background1.jpg','assets/imagens/open.jpg','assets/imagens/flutter.jpg','assets/imagens/brain_storming.jpg','assets/imagens/team_forming.jpg'];
  @override
  Widget build(BuildContext context) {
    systemOrientationPortraitUp();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(5 * SizeConfig.widthMultiplier, 6 * SizeConfig.heightMultiplier, 5 * SizeConfig.widthMultiplier , 0.0), /* 40.0 */
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Início',
                          style: TextStyle(
                            fontFamily: 'CM Sans Serif',
                            fontSize: 3.5 * SizeConfig.heightMultiplier, /* old: 26.0 now: 24.0 */
                            height: 0.1875 * SizeConfig.heightMultiplier, /* old: 1.5  old2: 1.26  now: 1.58 */
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /*Text('Ainda sem conteúdo..',
                      style: kTitleStyle,
                    ),*/
                    ListTile(
                      title: Text(news[0],style: kTitleStyle,),
                      subtitle: Text(datas[0]),
                      contentPadding: EdgeInsets.all(25.0),
                      onTap: () async {
                        showDialog(context: context, builder: (BuildContext context) => showalert(news[0], noticias[0], datas[0], img[0]));
                      },
                    ),
                    ListTile(
                      title: Text(news[1],style: kTitleStyle,),
                      subtitle: Text(datas[1]),
                      contentPadding: EdgeInsets.all(25.0),
                      onTap: () async {
                        showDialog(context: context, builder: (BuildContext context) => showalert(news[1], noticias[1], datas[1], img[1]));
                      },
                    ),
                    ListTile(
                      title: Text(news[2],style: kTitleStyle,),
                      subtitle: Text(datas[2]),
                      contentPadding: EdgeInsets.all(25.0),
                      onTap: () async {
                        showDialog(context: context, builder: (BuildContext context) => showalert(news[2], noticias[2], datas[2], img[2]));
                      },
                    ),
                    ListTile(
                      title: Text(news[3],style: kTitleStyle,),
                      subtitle: Text(datas[3]),
                      contentPadding: EdgeInsets.all(25.0),
                      onTap: () async {
                        showDialog(context: context, builder: (BuildContext context) => showalert(news[3], noticias[3], datas[3], img[3]));
                      },
                    ),
                    ListTile(
                      title: Text(news[4],style: kTitleStyle,),
                      subtitle: Text(datas[4]),
                      contentPadding: EdgeInsets.all(25.0),
                      onTap: () async {
                        showDialog(context: context, builder: (BuildContext context) => showalert(news[4], noticias[4], datas[4], img[4]));
                      },
                    ),
                  ],
                ),
              ),

            ],

          ),
        ),
      ),
    );
  }
}
