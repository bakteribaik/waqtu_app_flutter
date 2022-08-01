import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqtuu/SCREEN/Forum%20Chat/ForumChat.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController _nama = TextEditingController();

  bool laki = false;
  bool perempuan = false;

  String query = '';
  String gender = '';

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  _simpanData() async {
    var uid = DateTime.now().millisecondsSinceEpoch;

    FirebaseFirestore.instance.collection('user')
      .doc(uid.toString())
      .set({
        'userid' : uid.toString(),
        'username' : _nama.text,
        'gender' : gender,
        'moderator' : false,
        'admin' : false,
        'verified' : false
      }).then((value) => print('berhasil menambahkan user'))
      .catchError((e){
        print(e);
      });

    final pref = await SharedPreferences.getInstance();
    pref.setString('userid', uid.toString());
    print(uid);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForumChatPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
        backgroundColor: Colors.transparent,
        title: Text('Buat nama kamu', style: TextStyle(color: Color.fromARGB(255, 50, 172, 111), fontWeight: FontWeight.bold, fontSize: 15),),
      ),
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _nama,
                  maxLength: 30,
                  onChanged: (value){
                    setState(() {
                      query = value;
                    });
                  },
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: 'Nama',
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: 10,),
              Text('Jenis Kelamin', style: TextStyle(color: Colors.grey, fontSize: 14)),
              Divider(),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          laki = true;
                          perempuan = false;
                          gender = 'L';
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color: laki ? Colors.lightBlue[300] : Colors.lightBlue[50],
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(child: Text('Laki-Laki', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          laki = false;
                          perempuan = true;
                          gender = 'P';
                        });
                      },
                      child: Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color: perempuan ? Colors.pink[300] : Colors.pink[50],
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(child: Text('Perempuan', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  if (query.isEmpty) {
                    Fluttertoast.showToast(msg: 'nama tidak boleh kosong');
                  }else if(laki == false && perempuan == false){
                    Fluttertoast.showToast(msg: 'pilih salah satu gender');
                  }else{
                    _simpanData();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/2.2,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 50, 172, 111)
                  ),
                  child: Center(
                    child: Text('Masuk Forum', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              
              SizedBox(height: 20,),
              Text('pendaftaran ini hanya untuk menampilkan nama saja pada forum, jadi tidak ada data anda yang disimpan oleh pihak WAQTU Indonesia', style: TextStyle(color: Colors.grey, fontSize: 11), textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }
}