import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futmm/Pages/Setup/profile.dart';
import '../feed.dart';
import '../fields_page.dart';
import '../signIn.dart';

getBar (context, FirebaseUser user){
  return BottomNavigationBar(
    currentIndex: 0, // this will be set when a new tab is tapped
    onTap: (index){
      if(index == 0){
        Navigator.push(context, MaterialPageRoute(builder: (context) => feed(user: user)));
      }
      if(index == 1){
        Navigator.push(context, MaterialPageRoute(builder: (context) => fields(user: user)));
      }
      if(index == 2){
        Navigator.push(context, MaterialPageRoute(builder: (context) => profilePage(user: user)));
      }
    },
    items: [
      BottomNavigationBarItem(
        icon: new Icon(Icons.notifications),
        title: new Text('Feed'),
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.calendar_today),
        title: new Text('Campos'),
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile')
      )
    ],
  );
}