import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqtuu/SCREEN/HomePages/HomePages.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

_getPermission(context) async {
  var LocationStatus = await Permission.location.request();
  if (LocationStatus == LocationStatus.isGranted) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePages()));
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('FirstOpen', true);
  }else{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePages()));
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('FirstOpen', true);
  }
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.teal,
                radius: 30,
                child: FaIcon(FontAwesomeIcons.locationDot, color: Colors.white, size: 30,)
              ),
              SizedBox(height: 15,),
              Text('Izin akses lokasi\npada latar belakang', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54), textAlign: TextAlign.center,),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width/1.5,
                child: Text('WAQTU mengumpulkan data lokasi untuk mengaktifkan fitur penghitungan waktu shalat dan penentuan arah kiblat, bahkan saat aplikasi ditutup atau sedang tidak digunakan serta digunakan juga untuk mendukung iklan.', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.black54),)
              ),
              SizedBox(height: 25,),
              GestureDetector(
                onTap: (){
                  _getPermission(context);
                },
                child: Container(
                  width: 240,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: Text('Izinkan', style: TextStyle(color: Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}