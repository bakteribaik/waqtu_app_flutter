import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqtuu/SCREEN/Forum%20Chat/ForumChat.dart';
import 'package:waqtuu/SCREEN/Forum%20Chat/RegisterPage.dart';

class DataCheckForum extends StatefulWidget {
  const DataCheckForum({Key? key}) : super(key: key);

  @override
  State<DataCheckForum> createState() => _DataCheckForumState();
}

class _DataCheckForumState extends State<DataCheckForum> {

 

  _checkData() async {
    final pref = await SharedPreferences.getInstance();
    final uid = pref.getString('userid');

    FirebaseFirestore.instance.collection('user')
      .doc(uid)
      .get()
      .then((value){
        if(value.exists){
          Future.delayed(Duration.zero,(){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForumChatPage()));
          });
        }else{
          Future.delayed(Duration.zero,(){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage()));
          });
        }
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Sedang membuka forum...'),
      ),
    );
  }
}