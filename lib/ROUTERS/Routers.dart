import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waqtuu/ROUTERS/PermissionScreen.dart';
import 'package:waqtuu/SCREEN/HomePages/HomePages.dart';

class Routers extends StatefulWidget {
  const Routers({Key? key}) : super(key: key);

  @override
  State<Routers> createState() => _RoutersState();
}

class _RoutersState extends State<Routers> {

  _FirstScreen() async {
    print('FirstOpen');
    final prefs = await SharedPreferences.getInstance();
    bool isOpen = prefs.getBool('FirstOpen') ?? false;
    print(isOpen);
    if (isOpen == false) {
      Future.delayed(Duration.zero,(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PermissionScreen()));
      });
    }else{
      Future.delayed(Duration.zero,(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePages()));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _FirstScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}