import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:futmm/Pages/home.dart';
import 'feed.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: new Center(child: new Text('Sign In', textAlign: TextAlign.center)),
        automaticallyImplyLeading: false
        //backgroundColor: Colors.transparent,
        //elevation: 0.0,
      ),

      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/imagens/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key : _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                validator: (input){
                  if(input.isEmpty){
                    return 'Please Type an email';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'Email',
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
                onPressed: signIn,
                child: Text('Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      //login to firebase
      formState.save();
      try{
        AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => feed(user: user.user)));
      }
      catch(e){
        print(e.message);
      }
    }
  }
}