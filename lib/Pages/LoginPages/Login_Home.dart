import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waqtuu/Service/google_sign_in.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({ Key? key }) : super(key: key);

  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image(image: AssetImage('assets/images/icon.png')),
              ),
              SizedBox(height: 10,),
              Text("WAQTU: Qur'an Digital Indonesia", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
              SizedBox(height: 30,),
              Flexible(child: Text("silahkan login untuk dapat\nmengakses public chat", style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center,),),
              SizedBox(height: 100,),
              InkWell(
                onTap: (){
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin();
                },
                child:  Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width/1.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FaIcon(FontAwesomeIcons.google, color: LColor,),
                      Text('|', style: TextStyle(color: LColor),),
                      Text('Continue with google', style: TextStyle(color: LColor),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                width: 250,
                child: Text("Apa saja yang ditampilkan? : Nama Profile Email", style: TextStyle(fontSize: 10, color: Colors.white), textAlign: TextAlign.center,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}