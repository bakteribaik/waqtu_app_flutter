import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Pages/LoginPages/Login_Home.dart';
import 'package:waqtuu/Service/google_sign_in.dart';
import 'package:marquee/marquee.dart';

class HomeSideMenuPage extends StatefulWidget {
  const HomeSideMenuPage({ Key? key }) : super(key: key);

  @override
  _HomeSideMenuPageState createState() => _HomeSideMenuPageState();
}

class _HomeSideMenuPageState extends State<HomeSideMenuPage> {
    ScrollController _scrollController = ScrollController();
    int speedFactor = 20;
    bool scroll = true;

  String version = '';

  bool isFetch = false;

  String namanama = 'THANKS TO\n\nAllah S.W.T\nSutanlab\nwaktusholat.org\n\nContributor:\n\nDimas Agung Pratama\nDedy Priyatna\nDewi Yulianti\nIkhsanul Dzikri\nPandu Wicaksana\ndan masih banyak yang lainnya';

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
              Container(
                height: 60,
                width: 60,
                child: Image(image: AssetImage('assets/images/icon.png')),
              ),
              Text("WAQTU: Qur'an Digital", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
              Text('Application Info', style: TextStyle(color: Colors.white, fontSize: 13),),

              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.all(10),
                height: 125,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  controller:_scrollController,
                  child: Text(namanama, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Publish Authority: @vive.vio on > ', style: TextStyle(fontSize: 10, color: Colors.white),),
                  InkWell(
                    onTap: () async{
                      await launch('https://instagram.com/vive.vio/');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.pink,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      padding: EdgeInsets.only(left: 2, right: 2),
                      child: FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 13,),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Build author: @zulfikaralwilubis on > ', style: TextStyle(fontSize: 10, color: Colors.white),),
                  InkWell(
                    onTap: () async{
                      await launch('https://instagram.com/zulfikaralwilubis/');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.pink,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      padding: EdgeInsets.only(left: 2, right: 2),
                      child: FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 13,),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('UI Design by: @mrjulianto on > ', style: TextStyle(fontSize: 10, color: Colors.white),),
                  InkWell(
                    onTap: () async{
                      await launch('https://instagram.com/mrjulianto/');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.pink,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      padding: EdgeInsets.only(left: 2, right: 2),
                      child: FaIcon(FontAwesomeIcons.instagram, color: Colors.white, size: 13,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              isFetch ? Text('App Version: v${version}', style: TextStyle(
                fontSize: 12,
                color: Colors.white
              ),) : SizedBox(),
              SizedBox(height: 30,),
            ],
          ),
        )
      )
    );
  }
}