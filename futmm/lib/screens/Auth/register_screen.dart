import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futmm/services/auth_service.dart';
import 'package:futmm/utilities/custom_buttons.dart';
import 'package:futmm/utilities/custom_textform.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:theme_provider/theme_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  ProgressDialog progressDialog;
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password, _repPassword;

  // Save validated data
  _submit(){
    if (_formKey.currentState.validate()){
      progressDialog.show();
      _formKey.currentState.save();
/*      print(_name);
      print(_email);
      print(_password);
      print(_repPassword);*/

      AuthService.signUpUser(context, _name, _email, _password, progressDialog);
    }
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: 'A criar conta...');
    return Scaffold(
      body: GestureDetector(
        onTap: () {FocusScope.of(context).requestFocus(new FocusNode());},
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/background.jpg'),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: DM.isDark ? ColorsApp.blackColor.withOpacity(0.80) : ColorsApp.whiteColor.withOpacity(0.80),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5 * SizeConfig.heightMultiplier), /* 40.0 */
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back,
                                size: 7.5 * SizeConfig.widthMultiplier,  /* 30.0 */
                              ),
                            ),
                            Image(
                              image: AssetImage('assets/images/original_logo.png'),
                              height: 10 * SizeConfig.heightMultiplier, /* 80 */
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.125 * SizeConfig.heightMultiplier), /* 25 */
                      Container(
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                'A um passo\nde criar partidas',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 4.23 * SizeConfig.heightMultiplier, /* 33 */
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.48 * SizeConfig.heightMultiplier), /* 35 */
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.8 * SizeConfig.widthMultiplier), /* 40 */
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 10.2 * SizeConfig.heightMultiplier, /* 80 */
                                  child: FutCustomField(
                                    labelText: 'Nome',
                                    keyboardType: TextInputType.text,
                                    validator: (input) => input.trim().isEmpty ? 'Introduza um nome válido' : null,
                                    onSaved: (input) => _name = input,
                                    obscureText: false,
                                  ),
                                ),
                                Container(
                                  height: 10.2 * SizeConfig.heightMultiplier, /* 80 */
                                  child: FutCustomField(
                                    labelText: 'Email',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (input) => !input.trim().contains('@') ? 'Introduza um email válido.' : null,
                                    onSaved: (input) => _email = input,
                                    obscureText: false,
                                  ),
                                ),
                                Container(
                                  height: 10.2 * SizeConfig.heightMultiplier, /* 80 */
                                  child: FutCustomField(
                                    labelText: 'Password',
                                    keyboardType: null,
                                    validator: (input) => input.length < 8 ? 'A password deve conter pelo menos 8 caracteres.' : null,
                                    onSaved: (input) => _password = input,
                                    obscureText: true,
                                  ),
                                ),
                                Container(
                                  height: 10.2 * SizeConfig.heightMultiplier, /* 80 */
                                  child: FutCustomField(
                                    labelText: 'Repetir Password',
                                    keyboardType: null,
                                    validator: (input) => input.length < 8 ? 'A password deve conter pelo menos 8 caracteres.' : null,
                                    onSaved: (input) => _repPassword = input,
                                    obscureText: true,
                                  ),
                                ),
                                SizedBox(height: 1.92 * SizeConfig.heightMultiplier), /* 15 */
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'Já tem uma conta? ',
                                        style: TextStyle(
                                          fontSize: 2.05 * SizeConfig.heightMultiplier, /* 16 */
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => ThemeConsumer(child: LoginScreen()))),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: 2.05 * SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.76 * SizeConfig.heightMultiplier), /* 45 */
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.8 * SizeConfig.widthMultiplier), /* 40 */
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              height: 6.28 * SizeConfig.heightMultiplier, /* new: 49 old: 52 -> 6.66 */
                              child: FilledButton(
                                text: 'Criar conta',
                                onPressed: () async{
                                  _submit();
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}