import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waqtuu/Pages/LoginPages/Login_Home.dart';
import 'package:waqtuu/Pages/PublicChat/publicChat_home.dart';
import 'package:waqtuu/Pages/home_menu.dart';

class RouterPages extends StatefulWidget {
  final bool isDarkMode;
  const RouterPages({ Key? key, required this.isDarkMode}) : super(key: key);

  @override
  _RouterPagesState createState() => _RouterPagesState();
}

class _RouterPagesState extends State<RouterPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.hasData){
            return PublicChatHome(isDarkMode: widget.isDarkMode,);
          }else if(snapshot.hasError){
            return Center(child: Text('Somthing went wrong'),);
          }else{
            return LoginPages();
          }
        }),
    );
  }
}