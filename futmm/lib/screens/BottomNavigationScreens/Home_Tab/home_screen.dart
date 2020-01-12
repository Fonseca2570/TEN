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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 70.0),
      child: Container(
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(img),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(texto, style: TextStyle(fontSize: 16, height: 1.5)),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            FlatButton(onPressed: () {
              BuildContext context;
              Navigator.of(context).pop();
            },
                child: Text(data,
                  style: TextStyle(fontSize: 18.0),))
          ],
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
              SizedBox(height: 5),
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
                                  margin: EdgeInsets.symmetric(vertical: 7),
                                  /*height: 300.0,*/
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 170.0,
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
                                        padding: const EdgeInsets.only(left: 8.0, top: 14.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              '${appnew.title}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: DM.isDark ? ColorsApp.whiteColor : ColorsApp.blackColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '${appnew.content}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  color: DM.isDark ? ColorsApp.lightGreyColor2 : ColorsApp.greyColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10,14,10,10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              'Publicado a ${appnew.dataPub}',
                                              style: TextStyle(
                                                fontSize: 12,
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