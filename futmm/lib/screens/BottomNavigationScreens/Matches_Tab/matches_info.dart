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

class MatchesInfoScreen extends StatefulWidget {
  String value;
  final String user;
  DateTime data;
  int tipologia;
  String mail;


  MatchesInfoScreen({Key key, this.value, this.user, this.data, this.tipologia, this.mail}) : super(key: key);
  @override
  _MatchesInfoScreenState createState() => _MatchesInfoScreenState();
}

class _MatchesInfoScreenState extends State<MatchesInfoScreen> {
  @override
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 2.56 * SizeConfig.heightMultiplier); /* 20.0 */
  TextStyle style2 = TextStyle(fontFamily: 'Montserrat', fontSize: 2.05 * SizeConfig.heightMultiplier); /* 16.0 */
  Widget build(BuildContext context) {
    List<Widget> makeListWidget(AsyncSnapshot snapshot){
      return snapshot.data.documents.map<Widget>((document){
        return ListTile(

          title: Text("Data: "+ document['Data'].toString() ,
              style: style.copyWith(
                  fontWeight: FontWeight.bold)),
          subtitle: Text("Horario: " + document['Horario'].toString(),
              style: style2.copyWith()),
          trailing: new Material(
            elevation: 4.0,
            //shape: CircleBorder(side: BorderSide(color: Colors.black)),
            shape: ContinuousRectangleBorder(side: BorderSide()),
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child:
            Icon(Icons.done, size: 50, color: ColorsApp.normalGreenColor),
          ),
        );
      }).toList();
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(5 * SizeConfig.widthMultiplier, 6 * SizeConfig.heightMultiplier, 5 * SizeConfig.widthMultiplier , 0.0), /* 40.0 */
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.value,
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
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('campos/'+widget.value + "/Registo/").orderBy('Data', descending: true).snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.data == null) return Center(
                        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(DM.isDark ? ColorsApp.brightGreenColor : ColorsApp.normalGreenColor))),
                      );
                      return ListView(
                        children: makeListWidget(snapshot),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
