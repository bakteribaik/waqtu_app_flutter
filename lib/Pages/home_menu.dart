import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Pages/DoaHarian.dart';
import 'package:waqtuu/Pages/DrawerMenu/HomeSideMenu.dart';
import 'package:waqtuu/Pages/DzikirHome.dart';
import 'package:waqtuu/Pages/waqtu_listSurah.dart';
import 'package:waqtuu/Pages/waqtu_shalat.dart';
import 'package:waqtuu/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class homeMenu extends StatefulWidget {
  const homeMenu({ Key? key }) : super(key: key);

  @override
  _homeMenuState createState() => _homeMenuState();
}

class _homeMenuState extends State<homeMenu> {

  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  bool? internet;

  @override
  void initState() {

    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          print('banner loaded');
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd.dispose();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeSideMenuPage(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff2EB086)),
        centerTitle: true,
        title: Text('WAQTU', style: TextStyle(fontSize: 24, color: Color(0xff2EB086), fontWeight: FontWeight.bold),),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        // actions: [
        //   IconButton( onPressed: () async {
        //       final url = 'https://wa.me/6283808503597?text=hallo%20admin%20waqtu';
        //       if(await canLaunch(url) && await Connectivity().checkConnectivity() == ConnectivityResult.wifi && await Connectivity().checkConnectivity() == ConnectivityResult.wifi){
        //         await launch(url);
        //       }else(
        //         Fluttertoast.showToast(msg: 'No Internet Connection')
        //       );
        //     }, icon: Icon(Icons.headset_mic))
        // ],
      ),
      body: SafeArea(
       child: Container(
         width: MediaQuery.of(context).size.width,
         padding: EdgeInsets.all(20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
              if(_isBannerAdReady)
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                ),
              SizedBox(height: 10,),

                   Text("WaQtu is an app for read digital Al Quran \nand known time for dzikir and pray", style: TextStyle(color: Colors.grey, fontSize: 12), textAlign: TextAlign.center,),
        

               SizedBox(height: 30,),

             Container(
               height: MediaQuery.of(context).size.height/1.6,
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                //color: Colors.red
               ),
               child: Column(
                 children: [
                   Container(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         InkWell(
                           onTap: () async {
                             if( await Connectivity().checkConnectivity() == ConnectivityResult.wifi || await Connectivity().checkConnectivity() == ConnectivityResult.mobile){
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => const WaqtuHome()));
                             }else{
                               Fluttertoast.showToast(msg: 'No internet Connection', backgroundColor: Color(0xffB8045E), textColor: Colors.white,);
                             }
                           },
                           child:  Container(
                             width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xffCDB699),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.timer, color: Colors.white,  size: 40,),
                                  SizedBox(height: 10,),
                                  Text('Waqtu Shalat', style: TextStyle(color: Colors.white),),
                                ],
                              ),
                          ),
                         ),

                          SizedBox(height: 10,),

                         InkWell(
                           onTap: (){
                              Navigator.push(context, 
                             MaterialPageRoute(builder: (context) => const ListSurahPage()));
                           },
                           child:  Container(
                             width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff2EB086),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.menu_book, color: Colors.white, size: 40,),
                                  SizedBox(height: 10,),
                                  Text("Waqtu Al'Quran", style: TextStyle(color: Colors.white),),
                                ],
                              ),
                          ),
                         ),
                         
                          SizedBox(height: 10,),

                         InkWell(
                           onTap: (){
                              Navigator.push(context, 
                             MaterialPageRoute(builder: (context) => const DzikirPage()));
                           },
                           child:  Container(
                             width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff298A9E),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.dashboard_customize_outlined,color: Colors.white, size: 40,),
                                  SizedBox(height: 10,),
                                  Text("Waqtu Dzikir", style: TextStyle(color: Colors.white),),
                                ],
                              ),
                          ),
                         ),

                          SizedBox(height: 10,),

                         InkWell(
                           highlightColor: Colors.amber,
                           borderRadius: BorderRadius.circular(10),
                           splashColor: Colors.amber,
                           enableFeedback: true,
                           onTap: (){
                            //  Fluttertoast.showToast(msg: 'Doa harian is Coming Soon');
                                  Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => const DoaHarianPages()));
                           },
                           child:  Container(
                             width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff313552),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.favorite,color: Colors.white, size: 40,),
                                  SizedBox(height: 10,),
                                  Text("Doa Doa Harian", style: TextStyle(color: Colors.white),),
                                ],
                              ),
                          ),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
      )
      
    );
  }
}