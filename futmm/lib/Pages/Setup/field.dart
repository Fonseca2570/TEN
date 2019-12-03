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

  field({Key key, this.value, this.user, this.data}) : super(key: key);
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
          String hora = snapshot.data.documents.map((
              doc) => doc[horas]).toString()
              .replaceAll("(", "")
              .replaceAll(")", "");
          if(hora == ""){
            hora = "0";
          }
          List<String> horas1 = horas.split("-");
          return ListTile(
            title: Text('Horario das '+horas1[0]+':00 até as '+horas1[1]+':00 '),
            subtitle: Text('Nº de elementos neste horario ' + hora),
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
}
