import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futmm/utilities/animations.dart';
import 'package:futmm/utilities/constants.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:theme_provider/theme_provider.dart';

class Fields extends StatefulWidget {
  String value;
  final String user;
  DateTime data;
  int tipologia;
  String mail;



  Fields({Key key, this.value, this.user, this.data, this.tipologia, this.mail}) : super(key: key);
  @override
  _FieldsState createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextStyle style2 = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);
  List<Widget> makeListWidget(AsyncSnapshot snapshot, FirebaseUser user){
    return snapshot.data.documents.map<Widget>((document){
      return ListTile(
        leading: new Material(
          elevation: 4.0,
          //shape: CircleBorder(side: BorderSide(color: Colors.black)),
          shape: ContinuousRectangleBorder(side: BorderSide()),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,

          child: Ink.image(
            image: AssetImage(document['img']),
            fit: BoxFit.cover,
            width: 100.0,
            height: 100.0,
            child: InkWell(
              onTap: () {},
            ),
          ),
        ),
        title: Text(document['nome'].toString(),
            style: style.copyWith(
                fontWeight: FontWeight.bold)),
        subtitle: Text(document['tipologia'].toString()+"x"+document['tipologia'].toString(),
            style: style2.copyWith()),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context) => ThemeConsumer(child: Fields(value: document['nome'], user: user.uid, data: DateTime.now(), tipologia: document['tipologia']))));
        },
      );
    }).toList();
  }




  horarios(String campo, String horas, DateTime data){
    String dia = data.toString().substring(8, 10);
    String mes = data.toString().substring(5, 7);
    String ano = data.toString().substring(0, 4);
    return StreamBuilder(
      stream: Firestore.instance.collection('campos/' + campo + '/Data').where('data', isEqualTo: (dia + "-" + mes + "-" + ano)).snapshots(),
      builder: (context,snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(DM.isDark ? ColorsApp.brightGreenColor : ColorsApp.normalGreenColor));
        }
        else {
          String jog = snapshot.data.documents.map((
              doc) => doc[horas]).toString()
              .replaceAll("(", "")
              .replaceAll(")", "");
          if(jog == ""){
            jog = "0";
          }
          List<String> horas1 = horas.split("-");
          return ListTile(
            title: Text('Horario das '+horas1[0]+':00 até as '+horas1[1]+':00 '),
            subtitle: Text('Nº de elementos neste horario ' + jog),
            onTap: () {
              onTap(int.tryParse(jog), widget.tipologia, horas1[0], horas1[1], int.parse(jog), widget.user);
            },
          );
        }
      },
    );
  }
  sendEmail(String das, String ate, DateTime data) async {
    String username = 'futmm1@hotmail.com';
    String password = 'futmmreservas2020';

    final smtpServer = hotmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add(widget.mail)
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Reserva do Campo'
      ..text = 'O campo foi reservado para o dia '+ data.day.toString() + "-"+ data.month.toString() + "-" + data.year.toString() +' as horas de '+ das + " ate as " + ate;
      //..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.fromLTRB(5 * SizeConfig.widthMultiplier, 6.5 * SizeConfig.heightMultiplier, 5 * SizeConfig.widthMultiplier , 0.0), /* 40.0 */
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.arrow_back,
                            size: 7.5 * SizeConfig.widthMultiplier, /* 30 */
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                        Text(
                            widget.value,
                            style: kTitleStyle
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => onPressedButton(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 500,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('campos').where('nome',isEqualTo: widget.value).snapshots(),
                          builder: (context,snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(DM.isDark ? ColorsApp.brightGreenColor : ColorsApp.normalGreenColor));
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
                        horarios(widget.value, "15-16", widget.data),
                        horarios(widget.value, "16-17", widget.data),
                        horarios(widget.value, "17-18", widget.data),
                        horarios(widget.value, "18-19", widget.data),
                        horarios(widget.value, "19-20", widget.data),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onPressedButton() {
    EventList<Event> _markedDateMap;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              child: CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  //Navigator.push(context, new MaterialPageRoute(builder: (context) => new field(value: widget.value, user: widget.user, data: date,)));
                  Navigator.pop(context);
                  setState(() {
                    widget.data = date;
                  });
                },
                daysTextStyle: TextStyle(
                  color: checkDarkTheme(context) ? Colors.white : Colors.black,
                ),
                weekendTextStyle: TextStyle(
                  color: Colors.red,
                ),
                customDayBuilder: (
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,
                    ){
                  return null;
                },
                weekFormat: false,
                markedDatesMap: _markedDateMap,
                height: 420.0,
                selectedDateTime: widget.data,
                daysHaveCircularBorder: false,
              )
          );
        }
    );
  }



  void onTap(int dropdownValue, int tipologia, String hora1, String hora2, int jog, String  user) {
    int drop = dropdownValue;
    String listaJogadores = "";
    String dia = widget.data.toString().substring(8, 10);
    String mes = widget.data.toString().substring(5, 7);
    String ano = widget.data.toString().substring(0, 4);
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    void modal(int drop, int tipologia, String listaJogadores){
      List<int> pessoas = List();
      for (int i = jog; i <= (tipologia * 2); i++){
        pessoas.add(i);
      }
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              children: <Widget>[
                Text("Estão inscritos " + dropdownValue.toString() + " jogadores",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        fontWeight: FontWeight.bold)),
                new DropdownButton<int>(
                  value: drop,
                  items: pessoas.map((int value) {
                    return new DropdownMenuItem<int>(
                      value: value,
                      child: new Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int newValue) {
                    setState(() {
                      drop = newValue;
                      Navigator.pop(context);
                      modal(drop, tipologia, listaJogadores);
                    });
                  },
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff009933),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: (){
                      if ((tipologia * 2) - jog == 0){
                        drop = 0;
                      }
                      updateJogadores(drop, widget.value, widget.data, hora1, hora2, dropdownValue, user);
                      Navigator.pop(context);
                    },
                    child: Text("Guardar",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                FutureBuilder(
                    builder: (context, snapshot) {
                      while (listaJogadores == ""){
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Não há jogadores inscritos',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'CM Sans Serif',
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Text('A aguardar reservas...',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: 'CM Sans Serif',
                                          fontWeight: FontWeight.w300
                                      ),
                                    ),
                                  ),
                                  CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(DM.isDark ? ColorsApp.brightGreenColor : ColorsApp.normalGreenColor)),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                            itemCount: listaJogadores
                                .split("/")
                                .length - 1,
                            itemBuilder: (BuildContext ctxt, int Index) {
                              return new ListTile(
                                leading: new Material(
                                  elevation: 4.0,
                                  shape: CircleBorder(
                                      side: BorderSide(color: Colors.grey)),
                                  //shape: ContinuousRectangleBorder(side: BorderSide()),
                                  clipBehavior: Clip.hardEdge,
                                  color: Colors.transparent,

                                  child: Ink.image(
                                    image: AssetImage("assets/images/UserApp/user_placeholder.jpg"),
                                    width: 100.0,
                                    height: 100.0,
                                    child: InkWell(
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                                title: Text(listaJogadores.split("/")[Index].split(";")[0]),
                                //Text(widget.nickNames.replaceAll("(", "").replaceAll("/", "")),
                                subtitle: Text("Numero de reservas: " +
                                    listaJogadores.split("/")[Index].split(";")[1]),
                              );
                            }),
                      );
                    }
                ),
              ],
            );
          }
      );
    }


    //Ver se funciona

    Firestore.instance.collection('campos/' + widget.value + "/Data").document(dia + "-" + mes + "-" + ano).get().then((valor) async{
      if(valor.exists) {
        valor.data.forEach((key, value) {
          if (key == hora1 + "-" + hora2 + "-jogadores") {
            listaJogadores = value;
            modal(drop, tipologia, listaJogadores);
          }
        });
      }
      else{
        modal(drop, tipologia, listaJogadores);
      }
    });
  }

//Tentar guardar os nicks de quem fez reserva
  reservaJogadores(int jogadores, String campo, DateTime data, String hora1, String hora2, int dropDownValue, String  user) async{
    String listaJogadores;
    String dia = data.toString().substring(8, 10);
    String mes = data.toString().substring(5, 7);
    String ano = data.toString().substring(0, 4);
    Firestore.instance.collection('campos/' + widget.value + "/Data").document(dia + "-" + mes + "-" + ano).get().then((valor){
      valor.data.forEach((key,value){
        if(key == hora1+"-"+hora2+"-jogadores"){
          listaJogadores = value;
          Firestore.instance.collection("users").document(user).get().then((value) async{
            String nick = await value.data.values.first;
            listaJogadores = listaJogadores + nick +";" + dropDownValue.toString() + "/";
            Firestore.instance.collection('campos/' + widget.value + "/Data").document(dia + "-" + mes + "-" + ano).updateData({
              hora1+"-"+hora2+"-jogadores": listaJogadores,
            });
          });
        }
      });
    });

  }

  updateJogadores(int jogadores, String campo, DateTime data, String hora1, String hora2, int dropDownValue, String  user) async{
    bool hasData;
    if(jogadores != 0) {
      String dia = data.toString().substring(8, 10);
      String mes = data.toString().substring(5, 7);
      String ano = data.toString().substring(0, 4);

      Firestore.instance.collection('campos/' + widget.value + "/Data").document(dia + "-" + mes + "-" + ano).get().then((onValue) async{
        if (!onValue.exists) {
          Firestore.instance.collection('campos/' + widget.value + "/Data")
              .document(dia + "-" + mes + "-" + ano)
              .setData({
            '15-16': 0,
            '15-16-jogadores': "",
            '16-17': 0,
            '16-17-jogadores': "",
            '17-18': 0,
            '17-18-jogadores': "",
            '18-19': 0,
            '18-19-jogadores': "",
            '19-20': 0,
            '19-20-jogadores': "",
            'data': dia + "-" + mes + "-" + ano,
          });
          //await updateJogadores(jogadores, campo, data, hora1, hora2, dropDownValue, user);
        }
        dropDownValue = jogadores  - dropDownValue;
        Firestore.instance.collection('campos/' + widget.value + "/Data").document(dia + "-" + mes + "-" + ano).updateData({
          hora1+"-"+hora2: jogadores,
        });
        if(jogadores == 2*widget.tipologia){
          sendEmail(hora1,hora2, data);
        }
        reservaJogadores(jogadores, campo, data, hora1,  hora2,  dropDownValue, user);
      });

    }
  }




}
