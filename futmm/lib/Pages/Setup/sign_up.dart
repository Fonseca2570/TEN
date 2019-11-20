import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:futmm/Pages/Setup/signIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: new Center(child: new Text('Sign Up', textAlign: TextAlign.center)),
          automaticallyImplyLeading: false
      ),
      body: Form(
        key : _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input){
                if(input.isEmpty){
                  return 'Please Type an email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                  labelText: 'Email'
              ),
            ),
            TextFormField(
              validator: (input){
                if(input.length < 6){
                  return 'Your password needs to be atleast 6 characters';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      //login to firebase
      formState.save();
      try{
        AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        user.user.sendEmailVerification();
        Firestore.instance.collection("users")
            .add({
          'auth': user.user.uid,
          'email': user.user.email,
          'nickname': ""
        });
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
      catch(e){
        print(e.message);
      }
    }
  }
}
