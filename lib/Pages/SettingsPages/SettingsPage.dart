import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final bool isDarkMode;
  const SettingsPage({ Key? key, required this.isDarkMode}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

  bool isDarkMode = false;

  Future<bool>_loadPreferences() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getBool('isDarkMode') ?? false;
  }

  @override
  void initState() {
    _loadPreferences().then((value){
      setState(() {
        isDarkMode = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? BColor : LColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Pengaturan WAQTU', style: TextStyle(color: Colors.white),),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                   color: widget.isDarkMode ? DColor : Colors.white,
                   borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Aktifkan mode gelap?', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black87),),
                    Switch(
                      activeColor: LColor,
                      value: isDarkMode, 
                      onChanged: (value)async{
                        SharedPreferences pref = await SharedPreferences.getInstance();
                          setState(() {
                            isDarkMode = value;
                          });
                        pref.setBool('isDarkMode', isDarkMode);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.white,
                              content: Text('Silakan mulai ulang aplikasi untuk melihat perubahan pada aplikasi', style: TextStyle(color: Colors.grey), textAlign: TextAlign.center,),
                              // action: SnackBarAction(
                              //   label: 'Restart Sekarang',
                              //   onPressed: (){
                              //     exit(0);
                              //   },
                              // )
                            )
                          );
                      }
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}