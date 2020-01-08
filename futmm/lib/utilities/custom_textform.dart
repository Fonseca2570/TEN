import 'package:flutter/material.dart';
import 'package:futmm/utilities/styles.dart';

class FutCustomField extends StatelessWidget {
  FutCustomField({@required this.onSaved, this.labelText, this.validator, this.obscureText, this.keyboardType});
  final String labelText;
  final FormFieldValidator validator;
  final FormFieldSetter onSaved;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context, ) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: DM.isDark ? Colors.redAccent : Colors.red,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: DM.isDark ? ColorsApp.brightGreenColor : ColorsApp.normalGreenColor,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.5,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.5,
          ),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
      obscureText: obscureText,
    );
  }
}


class EditProfileFormField extends StatelessWidget {
  EditProfileFormField({@required this.onSaved, this.labelText, this.validator, this.obscureText, this.keyboardType, this.initialValue});
  final String labelText, initialValue;
  final FormFieldValidator validator;
  final FormFieldSetter onSaved;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context, ) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: DM.isDark ? Colors.redAccent : Colors.red,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: DM.isDark ? ColorsApp.brightGreenColor : ColorsApp.normalGreenColor,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.5,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.5,
          ),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
      obscureText: obscureText,
      initialValue: initialValue,
    );
  }
}

