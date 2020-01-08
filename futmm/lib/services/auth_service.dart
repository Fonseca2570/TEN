import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futmm/screens/BottomNavigationScreens/screen_management.dart';
import 'package:futmm/screens/welcome_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:theme_provider/theme_provider.dart';

class AuthService{

  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;

  static void signUpUser(BuildContext context, String name, String email, String password, ProgressDialog progressDialog) async{
    try{
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null){
        _firestore.collection('/users').document(signedInUser.uid).setData({
          'name': name,
          'email': email,
          'profileImageUrl': '',
        });
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            ThemeConsumer(child: ManagementScreen(userId: signedInUser.uid))), (Route<dynamic> route) => false);
      }
    }catch(e){
      progressDialog.hide();
      print(e);
    }
  }

  static void logout(BuildContext context) {
    _auth.signOut();
    Navigator.pushReplacement(context, CupertinoPageRoute(
        builder: (context) => ThemeConsumer(child: WelcomeScreen())));
  }

  static void login(BuildContext context, String email, String password, ProgressDialog progressDialog) async{
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser userId = authResult.user;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          ThemeConsumer(child: ManagementScreen(userId: userId.uid))), (Route<dynamic> route) => false);
    }catch (e){
      progressDialog.hide();
      print(e);
    }
  }
}