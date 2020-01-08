import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futmm/screens/welcome_screen.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:theme_provider/theme_provider.dart';

// NOT FILLED BUTTON

class NotFilledButton extends StatelessWidget {
  NotFilledButton({@required this.onPressed, this.text});
  final GestureTapCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        boxShadow: [
          BoxShadow(
            color: DM.isDark ? Colors.transparent : Colors.grey,
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0,3),
          ),
        ]
      ),
      child: DecoratedBox(
        decoration: ShapeDecoration(shape: StadiumBorder(), color: DM.isDark ? Colors.transparent : ColorsApp.bGDirtyWhiteColor),
        child: OutlineButton(
          shape: StadiumBorder(),
          splashColor: ColorsApp.lightGreenColor,
          highlightColor: Colors.transparent,
          highlightedBorderColor: ColorsApp.normalGreenColor,
          child: Text(text,
            style: TextStyle(
              fontSize: 2.25 * SizeConfig.heightMultiplier, /* 18 */
              color: DM.isDark ? ColorsApp.dirtyWhiteColor : ColorsApp.blackColor,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.green,
            style: BorderStyle.solid,
            width: 0.475 * SizeConfig.widthMultiplier, /* 1.9 */
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

// FILLED BUTTON

class FilledButton extends StatelessWidget {
  FilledButton({@required this.onPressed, this.text});
  final GestureTapCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration:
      ShapeDecoration(shape: StadiumBorder(), color: ColorsApp.normalGreenColor),
      child: OutlineButton(
        shape: StadiumBorder(),
        splashColor: ColorsApp.lightGreenColor,
        highlightColor: Colors.transparent,
        highlightedBorderColor: ColorsApp.normalGreenColor,
        child: Text(text,
          style: TextStyle(
            fontSize: 2.25 * SizeConfig.heightMultiplier, /* 18 */
            color: ColorsApp.dirtyWhiteColor,
          ),
        ),
        borderSide: BorderSide(
          color: ColorsApp.normalGreenColor,
          style: BorderStyle.solid,
          width: 0.475 * SizeConfig.widthMultiplier, /* 1.9 */
        ),
        onPressed: onPressed,
      ),
    );
  }
}