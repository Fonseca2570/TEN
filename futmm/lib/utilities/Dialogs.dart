import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DialogAction {yes, abort}

class Dialogs{
  static Future<DialogAction> yesAbortDialog(
      BuildContext context,
      String title,
      String body
      ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.yes),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        }
    );
    return (action != null) ? action : DialogAction.abort;
  }

}
/*
import 'package:flutter/material.dart';

class Dialogs{
  information(BuildContext context, String title, String description){
    return showDialog(context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description)
                ],
              ),
            ) ,
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Sim'),
              )
            ],
          );
        }
    );
  }

  waiting(BuildContext context, String title, String description){
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description)
                ],
              ),
            ) ,
          );
        }
    );
  }
}*/
