import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futmm/utilities/app_settings.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';

import 'Home_News/news_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Dialog showalert(String img, String title, String texto, String data) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: DM.isDark ? Border.all(width: 0.405 * SizeConfig.widthMultiplier, color: ColorsApp.lightGreyColor2) : null, /* 1.5 */
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.97 * SizeConfig.heightMultiplier), /* 70 */
        child: Container(
          width: 81.08 * SizeConfig.widthMultiplier, /* 300 */
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(img),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.05 * SizeConfig.widthMultiplier, vertical: 1.92 * SizeConfig.heightMultiplier), /* 15.0 | 15.0 */
                child: Text(title, style: TextStyle(fontSize: 3.07 * SizeConfig.heightMultiplier, fontWeight: FontWeight.w400), /* 24 */
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.05 * SizeConfig.widthMultiplier, vertical: 1.92 * SizeConfig.heightMultiplier), /* 15.0 | 15.0 */
                child: Text(texto, style: TextStyle(fontSize: 2.05 * SizeConfig.heightMultiplier, height: 0.192 * SizeConfig.heightMultiplier)), /* 16 | 1.5 */
              ),
              Padding(padding: EdgeInsets.only(top: 6.41 * SizeConfig.heightMultiplier)), /* 50 */
              FlatButton(onPressed: () {
                BuildContext context;
                Navigator.of(context).pop();
              },
                  child: Text(data,
                    style: TextStyle(fontSize: 2.30 * SizeConfig.heightMultiplier),)), /* 18 */
            ],
          ),
        ),
      ),
    ),
  );
  return errorDialog;
}

class _HomeScreenState extends State<HomeScreen> {
  /*int _currentIndex = 0;
  final news = ['Melhor Campo Fevereiro', 'Abertura da Aplicação', 'Inicio do desenvolvimento','Escolha do Tema', 'Formação do Grupo'];
  final datas = ['Publicado a 02-02-2020','Publicado a 01-02-2020','Publicado a 16-12-2019','Publicado a 15-12-2019','Publicado a 30-11-2019'];
  final noticias = ["O melhor campo do mes de novembro foi o campo xpto",'A partir do dia de hoje a nossa aplicação passou a estar funcional com acesso beta para ser utilizado pelos nosso utilizadores','Começamo hoje a criação da aplicação a mesma está a ser desenvolvida em flutter','O nosso tema é a criação de uma aplicação hibrida que permite fazer Matchmaking de jogos de futebol com amigos ou desconhecidos','Foi formado o nosso grupo para a cadeira de Ten Composta pelos alunos: João Fonseca, Ivo Ferreira, Carlos, Hugo Silva, Bruno, Hugo Alves, Nuno Bandeira'];
  final img = ['assets/imagens/background1.jpg','assets/imagens/open.jpg','assets/imagens/flutter.jpg','assets/imagens/brain_storming.jpg','assets/imagens/team_forming.jpg'];*/
  @override
  Widget build(BuildContext context) {
    systemOrientationPortraitUp();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(5 * SizeConfig.widthMultiplier, 6 * SizeConfig.heightMultiplier, 5 * SizeConfig.widthMultiplier , 0.0), /* 40.0 */
        child:Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
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
              ),
              SizedBox(height: 0.641 * SizeConfig.heightMultiplier), /* 5 */
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraint){
                    return Column(
                      children: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.topCenter,
                          height: constraint.maxHeight,
                          child: ListView.builder(
                            padding: EdgeInsets.all(0.0),
                            itemCount: appNews.length,
                            itemBuilder: (BuildContext context, int index){
                              AppNew appnew = appNews[index];
                              return GestureDetector(
                                onTap: (){
                                  showDialog(context: context, builder: (BuildContext context) => showalert(appnew.imgUrl, appnew.title, appnew.content, appnew.dataPub));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: DM.isDark ? ColorsApp.greyColor : ColorsApp.lightGreyColor2),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  margin: EdgeInsets.symmetric(vertical: 0.897 * SizeConfig.heightMultiplier), /* 7 */
                                  /*height: 300.0,*/
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 21.79 * SizeConfig.heightMultiplier, /* 170 */
                                        width: MediaQuery.of(context).size.width,
                                        /*decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(14.0),
                                            topRight: Radius.circular(14.0),
                                          ),
                                        ),*/
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(14.0),
                                            topRight: Radius.circular(14.0),
                                          ),
                                          child: Image.asset(
                                            appnew.imgUrl,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 2.16 * SizeConfig.widthMultiplier, top: 1.79 * SizeConfig.heightMultiplier), /* 8.0 | 14.0 */
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              '${appnew.title}',
                                              style: TextStyle(
                                                fontSize: 2.05 * SizeConfig.heightMultiplier, /* 16 */
                                                color: DM.isDark ? ColorsApp.whiteColor : ColorsApp.blackColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 2.16 * SizeConfig.widthMultiplier, top: 1.02 * SizeConfig.heightMultiplier), /* 8.0 | 8.0 */
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '${appnew.content}',
                                                style: TextStyle(
                                                  fontSize: 1.79 * SizeConfig.heightMultiplier, /* 14 */
                                                  height: 0.192 * SizeConfig.heightMultiplier, /* 1.5 */
                                                  color: DM.isDark ? ColorsApp.lightGreyColor2 : ColorsApp.greyColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(2.70 * SizeConfig.widthMultiplier, 1.79 * SizeConfig.heightMultiplier, 2.70 * SizeConfig.widthMultiplier, 1.28 * SizeConfig.heightMultiplier), /* 10 | 14 | 10 | 10 */
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              'Publicado a ${appnew.dataPub}',
                                              style: TextStyle(
                                                fontSize: 1.53 * SizeConfig.heightMultiplier, /* 12 */
                                                color: DM.isDark ? ColorsApp.lightGreyColor2 : ColorsApp.greyColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
* LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Container(
                        height: constraints.maxHeight,
                        color: Colors.blue,
                        child: ListView.builder(
                          itemCount: appNews.length,
                          itemBuilder: (BuildContext context, int index) {
                            AppNew appnew = appNews[index];
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              height: 210.0,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 200.0,
                                    width: MediaQuery.of(context).size.height,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  * */