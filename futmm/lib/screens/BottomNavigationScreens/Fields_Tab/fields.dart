import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';

class Fields extends StatefulWidget {
  String value;
  final FirebaseUser user;
  DateTime data;
  int tipologia;

  Fields({Key key, this.value, this.user, this.data, this.tipologia}) : super(key: key);
  @override
  _FieldsState createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {

  horarios(String campo, String horas, DateTime data){
    String dia = data.toString().substring(8, 10);
    String mes = data.toString().substring(5, 7);
    String ano = data.toString().substring(0, 4);
    return StreamBuilder(
      stream: Firestore.instance.collection('campos/' + campo + '/Data').where('data', isEqualTo: (dia + "-" + mes + "-" + ano)).snapshots(),
      builder: (context,snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
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
              onTap(int.tryParse(jog), widget.tipologia, horas1[0], horas1[1], int.parse(jog));
            },
          );
        }
      },
    );
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

  void onTap(int dropdownValue, int tipologia, String hora1, String hora2, int jog) {
    int drop = dropdownValue;
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    void modal(int drop, int tipologia){
      List<int> pessoas = List();
      for (int i = 0; i <= (tipologia * 2) - jog; i++){
        if ((tipologia * 2) - jog != 0){
          pessoas.add(i);
        }
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
                    drop = newValue;
                    Navigator.pop(context);
                    modal(drop, tipologia);
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
                      updateJogadores(drop, widget.value, widget.data, hora1, hora2, dropdownValue);
                      Navigator.pop(context);
                    },
                    child: Text("Guardar",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            );
          }
      );
    }
    modal(drop, tipologia);
  }

  updateJogadores(int jogadores, String campo, DateTime data, String hora1, String hora2, int dropDownValue) async{
    bool hasData;
    if(jogadores != 0) {
      String dia = data.toString().substring(8, 10);
      String mes = data.toString().substring(5, 7);
      String ano = data.toString().substring(0, 4);
      Firestore.instance.collection('campos/' + widget.value + "/Data").document(dia + "-" + mes + "-" + ano).get().then((onValue){
        if (!onValue.exists) {
          Firestore.instance.collection('campos/' + widget.value + "/Data")
              .document(dia + "-" + mes + "-" + ano)
              .setData({
            '15-16': 0,
            '16-17': 0,
            '17-18': 0,
            '18-19': 0,
            '19-20': 0,
            'data': dia + "-" + mes + "-" + ano,
          });
          updateJogadores(jogadores, campo, data, hora1, hora2, dropDownValue);
        }
      });
      jogadores = jogadores + dropDownValue;
      Firestore.instance.collection('campos/' + widget.value + "/Data").document(dia + "-" + mes + "-" + ano).updateData({
        hora1+"-"+hora2: jogadores,
      });
    }
  }

/*void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Erro"),
          content: new Text("Número de jogadores máximos já resgitados!"),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/
}
