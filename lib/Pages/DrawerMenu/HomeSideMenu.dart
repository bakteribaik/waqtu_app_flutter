import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeSideMenuPage extends StatefulWidget {
  const HomeSideMenuPage({ Key? key }) : super(key: key);

  @override
  _HomeSideMenuPageState createState() => _HomeSideMenuPageState();
}

class _HomeSideMenuPageState extends State<HomeSideMenuPage> {

  String version = '';

  bool isFetch = false;

  _getData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    isFetch = true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('WAQTU', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
              Text('application info', style: TextStyle(color: Colors.white, fontSize: 13),),

              SizedBox(height: 30,),

              // Container(
              //   padding: EdgeInsets.only(top: 20, bottom:20, left: 60, right: 60),
              //   decoration: BoxDecoration(
              //     color: Color(0xff2EB086),
              //     borderRadius: BorderRadius.circular(20)
              //   ),
              //   child: InkWell(
              //     onTap: (){
              //       print('setting');
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.settings, color: Colors.white,),
              //         SizedBox(width: 10,),
              //         Text('Settings', style: TextStyle(color: Colors.white),)
              //       ],
              //     ),
              //   ),
              // ),

              // SizedBox(height: 10,),
              // Container(
              //   padding: EdgeInsets.only(top: 20, bottom:20, left: 60, right: 60),
              //   decoration: BoxDecoration(
              //     color: Color(0xff2EB086),
              //     borderRadius: BorderRadius.circular(20)
              //   ),
              //   child: InkWell(
              //     onTap: (){
              //       print('setting');
              //     },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.info, color: Colors.white,),
              //         SizedBox(width: 10,),
              //         Text('About us', style: TextStyle(color: Colors.white),)
              //       ],
              //     ),
              //   ),
              // ),
              Text('Thanks To', style: TextStyle(fontSize: 20, color: Colors.white),),
              Text("Allah S.W.T\nSutanlab sebagai penyedia API Qur'an\nwaktusholat.org sebagai penyedia API waktu sholat", style: TextStyle(fontSize: 12,color: Colors.white), textAlign: TextAlign.center,),
              SizedBox(height: 10,),

              Text('Contributors', style: TextStyle(fontSize: 20, color: Colors.white),),
              Text('Muhammad Rizky Julianto, Dimas Agung Pratama, Ari Setiawan, Dewi Yulianti, Takyudin, Dedy Priyatna, Ikhsanul Dzikri dan masih banyak lagi', style: TextStyle(fontSize: 12,color: Colors.white), textAlign: TextAlign.center,),

              SizedBox(height: 80,),
              Text('Build Author: @zulfikaralwilubis', style: TextStyle(color: Colors.white54),),
              isFetch ? Text('Application Version: v${version}', style: TextStyle(
                fontSize: 12,
                color: Colors.white
              ),) : SizedBox()
            ],
          ),
        )
      )
    );
  }
}