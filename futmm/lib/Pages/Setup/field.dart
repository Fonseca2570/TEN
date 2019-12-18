import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:futmm/Pages/Setup/campo.dart';
import 'functions/menuBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class field extends StatefulWidget {
  String value;
  final FirebaseUser user;
  DateTime data;
  int tipologia;

  field({Key key, this.value, this.user, this.data, this.tipologia}) : super(key: key);
  @override
  _fieldState createState() => _fieldState();
}

class _fieldState extends State<field> {

  horarios(String campo, String horas, DateTime data){
    return StreamBuilder(
      stream: Firestore.instance.collection('campos/' + campo + '/Data').where('data', isEqualTo: (data.day.toString() + "-" + data.month.toString() + "-" + data.year.toString())).snapshots(),
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
              onTap(int.tryParse(jog), widget.tipologia, horas1[0], horas1[1]);
            },
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
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => onPressedButton(),
          )
        ],
      ),

      body: SingleChildScrollView(
          child: ConstrainedBox(
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
      ),
      bottomNavigationBar: getBar(context, widget.user)
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
                weekendTextStyle: TextStyle(
                  color: Colors.red,
                ),
                thisMonthDayBorderColor: Colors.grey,
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

  void onTap(int dropdownValue, int tipologia, String hora1, String hora2) {
    int drop = dropdownValue;
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    void modal(int drop, int tipologia){
      List<int> pessoas = List();
      for (int i = 0; i < (tipologia * 2) + 1; i++){
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
                        color: Colors.black, fontWeight: FontWeight.bold)),
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
    if(jogadores != "0") {
      String dia = data.toString().substring(8, 10);
      String mes = data.toString().substring(5, 7);
      String ano = data.toString().substring(0, 4);
      jogadores = jogadores + dropDownValue;
      Firestore.instance.collection('campos/' + widget.value + "/Data").document(dia + "-" + mes + "-" + ano).updateData({
        hora1+"-"+hora2: jogadores,
      });
    }
  }
}
