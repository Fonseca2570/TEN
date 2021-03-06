import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futmm/utilities/app_settings.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:theme_provider/theme_provider.dart';
import 'fields.dart';


class FieldsScreen extends StatefulWidget {
  final String userId;

  FieldsScreen({Key key, this.userId}) : super(key: key);

  @override
  _FieldsScreenState createState() => _FieldsScreenState();
}

class _FieldsScreenState extends State<FieldsScreen> {

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 2.56 * SizeConfig.heightMultiplier); /* 20.0 */
  TextStyle style2 = TextStyle(fontFamily: 'Montserrat', fontSize: 2.05 * SizeConfig.heightMultiplier); /* 16.0 */
  List<Widget> makeListWidget(AsyncSnapshot snapshot, String userId){
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
            width: 27.02 * SizeConfig.widthMultiplier, /* 100 */
            height: 12.8 * SizeConfig.heightMultiplier, /* 100 */
            child: InkWell(
              onTap: () {},
            ),
          ),
        ),
        title: Text(document['nome'].toString() +" "+ document["preco"].toString() + "€" ,
            style: style.copyWith(
                fontWeight: FontWeight.bold)),
        subtitle: Text(document['tipologia'].toString()+"x"+document['tipologia'].toString(),
            style: style2.copyWith()),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context) => ThemeConsumer(child: Fields(value: document['nome'], user: userId, data: DateTime.now().add(new Duration(days: 1)), tipologia: document['tipologia'], mail : document['email']))));
        },
      );
    }).toList();
  }

  final databaseReference = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    systemOrientationPortraitUp();
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
                            'Campos',
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
                    stream: Firestore.instance.collection('campos').orderBy("distrito").orderBy("concelho").snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.data == null) return Center(
                        child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(DM.isDark ? ColorsApp.brightGreenColor : ColorsApp.normalGreenColor))),
                      );
                      return ListView(
                        children: makeListWidget(snapshot, widget.userId),
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