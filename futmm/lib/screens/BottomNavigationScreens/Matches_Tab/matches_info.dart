import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';

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
        return Padding(
          padding: EdgeInsets.only(bottom: 0.769 * SizeConfig.heightMultiplier), /* 6.0 */
          child: ListTile(
            title: Text("Data: "+ document['Data'].toString() ,
                style: style.copyWith(
                    fontWeight: FontWeight.bold)),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 1.02 * SizeConfig.heightMultiplier), /* 8.0 */
              child: Text("Horário: " + document['Horario'].toString(),
                  style: style2.copyWith()),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.done, size: 13.5 * SizeConfig.widthMultiplier, color: DM.isDark ? ColorsApp.brightGreenColor : ColorsApp.normalGreenColor), /* 50.0 */
              ],
            ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 6.75 * SizeConfig.widthMultiplier), /* 25.0 */
                            child: GestureDetector(
                              child: Icon(
                                Icons.arrow_back,
                                size: 7.5 * SizeConfig.widthMultiplier, /* 30 */
                              ),
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
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
                      SizedBox(height: 3.20 * SizeConfig.heightMultiplier), /* new: 25.0 old: 30.0 */
                      StreamBuilder(
                        stream: Firestore.instance.collection('campos').where('nome',isEqualTo: widget.value).snapshots(),
                        builder: (context,snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(DM.isDark ? ColorsApp.brightGreenColor : ColorsApp.normalGreenColor));
                          }
                          else{
                            return Container(
                                constraints: BoxConstraints.expand(
                                  height:  25.6 * SizeConfig.heightMultiplier, /* 200.0 */
                                ),
                                child: Image.asset(snapshot.data.documents.map((
                                    doc) => doc['img']).toString().replaceAll("(", "").replaceAll(")", ""),width: 300,height: 300,)
                            );
                          }
                        },
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