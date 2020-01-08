import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:futmm/services/auth_service.dart';
import 'package:futmm/utilities/app_settings.dart';
import 'package:futmm/utilities/custom_buttons.dart';
import 'package:futmm/utilities/custom_textform.dart';
import 'package:futmm/utilities/size_config.dart';
import 'package:futmm/utilities/styles.dart';
import 'package:progress_dialog/progress_dialog.dart';

/* DEVELOPED BASED ON ASUS MEASUREMENTS (CHECK size_config file at the end of uncommented code*/

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  ProgressDialog progressDialog;
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

  _submit(){
    if (_formKey.currentState.validate()){
      progressDialog.show();
      _formKey.currentState.save();
      AuthService.login(context, _email, _password, progressDialog);
    }
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: 'A iniciar sessão...');
    systemOrientationPortraitUp();
    return Scaffold(
      body: GestureDetector(
        onTap: () {FocusScope.of(context).requestFocus(new FocusNode());
        },
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
                              height: 10.2 * SizeConfig.heightMultiplier, /* 80 */
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
                      SizedBox(height: 3.84 * SizeConfig.heightMultiplier), /* 30 */
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.8 * SizeConfig.widthMultiplier), /* 40 */
                          child: Column(
                            children: <Widget>[
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
                              SizedBox(height: 1.47 * SizeConfig.heightMultiplier), /* 11.5 */
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'Esqueceu-se da password?',
                                    style: TextStyle(
                                      fontSize: 1.79 * SizeConfig.heightMultiplier, /* 14 */
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.76 * SizeConfig.heightMultiplier), /* 45 */
                            ],
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
                                text: 'Iniciar sessão',
                                onPressed: () async {
                                  await _submit();
                                },
                              ),
                            ),
                            SizedBox(height: 3.20 * SizeConfig.heightMultiplier), /* 25 */
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 4.05 * SizeConfig.widthMultiplier), /* 15 */
                                      child: Divider(
                                        color: DM.isDark ? ColorsApp.whiteColor : ColorsApp.blackColor,
                                        height: 4.61 * SizeConfig.heightMultiplier, /* 36 */
                                        thickness: 1,
                                      ),
                                    )
                                ),
                                Text("ou",
                                  style: TextStyle(
                                    fontSize: 2.05 * SizeConfig.heightMultiplier, /* 16 */
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 4.05 * SizeConfig.widthMultiplier), /* 15 */
                                    child: Divider(
                                      color: DM.isDark ? ColorsApp.whiteColor : ColorsApp.blackColor,
                                      height: 4.61 * SizeConfig.heightMultiplier, /* 36 */
                                      thickness: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.20 * SizeConfig.heightMultiplier), /* 25 */
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  width: double.infinity,
                                  height: 6.28 * SizeConfig.heightMultiplier, /* new: 49 old: 52 -> 6.66 */
                                  child: SignInButton(
                                    DM.isDark ? Buttons.GoogleDark : Buttons.Google,
                                    onPressed: () => print('Login w/ Google'),
                                    shape: StadiumBorder(),
                                    text: 'Entrar com o Google',
                                  ),
                                ),
                                SizedBox(height: 2.56 * SizeConfig.heightMultiplier), /* 20 */
                                SizedBox(
                                  width: double.infinity,
                                  height: 6.28 * SizeConfig.heightMultiplier, /* new: 49 old: 52 -> 6.66 */
                                  child: SignInButton(
                                    Buttons.Facebook,
                                    onPressed: () => print('Login w/ Facebook'),
                                    shape: StadiumBorder(),
                                    text: 'Entrar com o Facebook',
                                  ),
                                ),
                              ],
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
