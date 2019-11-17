import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futmm/Pages/Setup/campo.dart';

class field extends StatelessWidget {
  final Campo campo;

  // In the constructor, require a Todo.
  field({Key key, @required this.campo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(campo.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(campo.tipologia.toString()),
      ),
    );
  }
}
