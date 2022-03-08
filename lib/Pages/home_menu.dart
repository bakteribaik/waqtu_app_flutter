import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Models/hij_models.dart';
import 'package:waqtuu/Pages/Counter_page.dart';
import 'package:waqtuu/Pages/DoaHarian.dart';
import 'package:waqtuu/Pages/DrawerMenu/HomeSideMenu.dart';
import 'package:waqtuu/Pages/DzikirHome.dart';
import 'package:waqtuu/Pages/MoreMenu/more_menu.dart';
import 'package:waqtuu/Pages/PublicChat/publicChat_home.dart';
import 'package:waqtuu/Pages/Router/router.dart';
import 'package:waqtuu/Pages/SettingsPages/SettingsPage.dart';
import 'package:waqtuu/Pages/asma_pages.dart';
import 'package:waqtuu/Pages/waqtu_listSurah.dart';
import 'package:waqtuu/Pages/waqtu_shalat.dart';
import 'package:waqtuu/Service/service_data.dart';
import 'package:badges/badges.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class homeMenu extends StatefulWidget {
  const homeMenu({ Key? key }) : super(key: key);

  @override
  _homeMenuState createState() => _homeMenuState();
}

class _homeMenuState extends State<homeMenu> {

  final items = <String>[
    "Demi Allah, tidaklah kehidupan dunia dibandingkan akhirat melainkan hanya seperti salah satu dari kalian mencelupkan tangannya ke dalam lautan, maka silakan dilihat apa yang dibawa oleh jarinya. (HR. Muslim)",
    "Ketahuilah bahwa kemenangan bersama kesabaran, kelapangan bersama kesempitan, dan kesulitan bersama kemudahan. (HR Tirmidzi)",
    "Bangunlah pagi hari untuk mencari rezeki dan kebutuhan-kebutuhanmu. Sesungguhnya pada pagi hari terdapat barakah dan keberuntungan. (HR At-Thabrani dan Al-Bazzar)",
    "Kerjakanlah urusan duniamu seakan-akan kamu hidup selamanya dan laksanakanlah urusan akhiratmu seakan-akan kamu akan mati besok. (HR. Ibnu Asakir)",
    "Barangsiapa datang kepada tukang ramal kemudian menanyakan sesuatu dan dia mempercayainya, maka tidak diterima salatnya selama empat puluh hari, (HR. Muslim)",
    "Hijrah adalah meninggalkan hal yang buruk. (HR. Ahmad)",
    "Sebaik-baik manusia ialah orang yang senantiasa mengingat Allah, dan seburuk-buruk manusia adalah orang yang suka mengadu domba, suka memecah belah antara orang-orang yang saling mengasihi, suka berbuat zalim, suka mencerai-beraikan manusia, dan selalu menimbulkan kesusahan. (HR. Ahmad)"
  ];  
  int second = 15;
  String item = 'Tidaklah suatu kegalauan, kesedihan, kebimbangan, kekalutan yang menimpa seorang mukmin atau bahkan tertusuk duri sekalipun, melainkan karenanya Allah akan menggugurkan dosa-dosanya". (HR Bukhari dan Muslim)';

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

  bool isDarkMode = false;
  bool onInternet = false;
  bool getData    = false;

  HijService hijService = HijService();
  HijYear data = HijYear();

  String tanggal = DateFormat("d-MM-yyyy").format(DateTime.now());
  String _hari = DateFormat("EEEE").format(DateTime.now());
  String _tanggal = DateFormat("dd").format(DateTime.now());
  String _bulan = DateFormat("MMMM").format(DateTime.now());
  String _tahun = DateFormat("yyyy").format(DateTime.now());
  String hari = '';
  String bulan = '';
  String _date = DateFormat("dd MMMM yyyy").format(DateTime.now());
  String _timeString = '';

  //====================== badge counter =============
  bool newMessage = false;
  bool showBadge = false;
  int index = 0;
  // _messageStream(){
  //   if(!this.mounted) return;
  //   Stream<QuerySnapshot> _messageStream = FirebaseFirestore.instance.collection('message').snapshots();
  //   _messageStream.listen((event) {
  //     if (event.docChanges.single.type.name == 'added') {
  //         if (this.mounted) {
  //           setState(() {
  //             index++;
  //           });
  //         }
  //         if(index > 0){
  //           if (this.mounted) {
  //             setState(() {
  //               showBadge = true;
  //             });
  //           }
  //         }else{
  //           return;
  //         }
  //     } else {
  //       return;
  //     }
  //   });
  // }
      
  //=================================================

  _getTime() {
    final String formattedDateTime =
        DateFormat('HH:mm').format(DateTime.now()).toString();
      if (this.mounted) {
        setState(() {
          _timeString = formattedDateTime;
        });
      }
  }

  _getData() async {
      data = await hijService.fetchData(tanggal);
      setState(() {
          onInternet = true;
      });
  }

  _internetChecker(){
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if (result != await ConnectivityResult.none) {
         _getData();
      }else{
        setState(() {
          onInternet = false;
        });
      }
    });
  }

  Future<bool>_loadPreferences() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getBool('isDarkMode') ?? false;
  }

  _translateHari(){
    if (_hari == 'Sunday') {
      setState(() {
         hari = 'Minggu';
      });
    }else if(_hari == 'Monday'){
      setState(() {
         hari = 'Senin';
      });
    }else if(_hari == 'Tuesday'){
      setState(() {
         hari = 'Selasa';
      });
    }else if(_hari == 'Wednesday'){
      setState(() {
         hari = 'Rabu';
      });
    }else if(_hari == 'Thursday'){
      setState(() {
         hari = 'Kamis';
      });
    }else if(_hari == 'Friday'){
      setState(() {
         hari = "Jum'at";
      });
    }else if(_hari == 'Saturday'){
      setState(() {
         hari = 'Sabtu';
      });
    }
  }

  _translateBulan(){
    if (_bulan == 'January') {
      setState(() {
        bulan = 'Januari';
      });
    }else if(_bulan == 'February'){
      setState(() {
        bulan = 'Februari';
      });
    }else if(_bulan == 'March'){
      setState(() {
        bulan = 'Maret';
      });
    }
    else if(_bulan == 'April'){
      setState(() {
        bulan = 'April';
      });
    }
    else if(_bulan == 'May'){
      setState(() {
        bulan = 'Mei';
      });
    }
    else if(_bulan == 'June'){
      setState(() {
        bulan = 'Juni';
      });
    }
    else if(_bulan == 'July'){
      setState(() {
        bulan = 'Juli';
      });
    }
    else if(_bulan == 'August'){
      setState(() {
        bulan = 'Agustus';
      });
    }
    else if(_bulan == 'September'){
      setState(() {
        bulan = 'September';
      });
    }
    else if(_bulan == 'October'){
      setState(() {
        bulan = 'Oktober';
      });
    }
    else if(_bulan == 'November'){
      setState(() {
        bulan = 'November';
      });
    }
    else if(_bulan == 'December'){
      setState(() {
        bulan = 'Desember';
      });
    }
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _internetChecker());
    _translateHari();
    _translateBulan();
    Timer.periodic(Duration(seconds: 15), (_) {
      item = items[Random().nextInt(items.length)];
    });
    _loadPreferences().then((value){
        isDarkMode = value;
        print('home: ' + isDarkMode.toString());
    });
    // _messageStream();
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeSideMenuPage(),
      backgroundColor: isDarkMode ? BColor : LColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.white),
        actions: [
           IconButton(onPressed:(){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => SettingsPage(
              isDarkMode : isDarkMode
            )));
          }, icon: Icon(Icons.settings, size: 20,)),
        ],
      ),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          backgroundColor: LColor,

          content: Text('Tekan kembali lagi untuk keluar', textAlign: TextAlign.center,)),
        child: SafeArea(
        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                Container(
                                  // color: Colors.amber,
                                  child: Column(
                                    children: [
                                      Text("WAQTU : Qur'an Digital", style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                  ),
                                  Text(_timeString, style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                  ),
                                  Text('${hari}, ${_tanggal} ${bulan} ${_tahun}', style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white
                                      ),
                                  ),
                                  SizedBox(height: 5),
                                  onInternet ?
                                  Text('${data.data!.hijri!.day} ${data.data!.hijri!.month!.en} ${data.data!.hijri!.year} Hijriah', style: TextStyle(
                                        fontFamily: '',
                                        fontSize: 13,
                                        color: Colors.white
                                      ),
                                  )
                                  : SizedBox(height: 15,),
                                    ],
                                  ),
                                ),
                                              
                                SizedBox(height: 29,),

                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: isDarkMode ? DColor : Colors.white,
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          // color: Colors.amber,
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Column( // Menu 1
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      if(onInternet == false){
                                                           ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              backgroundColor: Colors.red[300],
                                                              content: Text('No Internet Connection!', textAlign: TextAlign.center,)
                                                            )
                                                          );
                                                      }else{
                                                          Navigator.push(context,
                                                          MaterialPageRoute(builder: (context) => WaqtuHome(isDarkMode: isDarkMode)));
                                                      }
                                                    },
                                                      child: Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          Container(
                                                              padding: EdgeInsets.all(8),
                                                            width: 50,
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                              color: isDarkMode ? Color(0xff395B64) : LColor,
                                                              borderRadius: BorderRadius.circular(10),
                                                              border: Border.all(color: Colors.white, width: 2),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors.grey,
                                                                  offset: Offset(1,1),
                                                                  blurRadius: 5
                                                                )
                                                              ]
                                                            ),
                                                            child: Center(
                                                              child: SvgPicture.asset('assets/svg/sujud.svg', color: Colors.white, fit: BoxFit.contain,),
                                                            ),
                                                          ),

                                                          // Positioned(
                                                          //   top: -5,
                                                          //   right: -10,
                                                          //   child: Container(
                                                          //     decoration: BoxDecoration(
                                                          //       color: Colors.red,
                                                          //       borderRadius: BorderRadius.circular(5)
                                                          //     ),
                                      
                                                          //     padding: EdgeInsets.only(top: 1, bottom: 2, left: 3, right: 3),
                                                          //     child: Text('iklan', style: TextStyle(fontSize: 9, color: Colors.white),),
                                                          //   )
                                                          // )
                                                        ],
                                                      )
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text('Sholat', style: TextStyle(color: isDarkMode ? Colors.white : LColor),),
                                                  SizedBox(height: 10,),
                                                InkWell(
                                                    onTap: (){
                                                      Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => CounterPage(
                                                        isDarkMode : isDarkMode
                                                      )));
                                                    },
                                                      child: Container(
                                                        padding: EdgeInsets.all(8),
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ? Color(0xff395B64) : LColor,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Colors.white, width: 2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(1,1),
                                                            blurRadius: 5
                                                          )
                                                        ]
                                                      ),
                                                      child: Center(
                                                        child: SvgPicture.asset('assets/svg/counter.svg', color: Colors.white,),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text('Counter', style: TextStyle(color: isDarkMode ? Colors.white : LColor),),
                                                ],
                                              ),

                                              Column( // Menu 2
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ListSurahPage(
                                                        isDarkMode : isDarkMode
                                                      )));
                                                    },
                                                      child: Container(
                                                        padding: EdgeInsets.all(8),
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ? Color(0xff395B64) : LColor,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Colors.white, width: 2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(1,1),
                                                            blurRadius: 5
                                                          )
                                                        ]
                                                      ),
                                                      child: Center(
                                                        child: SvgPicture.asset('assets/svg/quran.svg', color: Colors.white, fit: BoxFit.contain,),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text("Qur'an", style: TextStyle(color: isDarkMode ? Colors.white : LColor),),
                                                  SizedBox(height: 10,),
                                                InkWell(
                                                    onTap: (){
                                                      Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => AsmaPages(
                                                        isDarkMode : isDarkMode
                                                      )));
                                                    },
                                                      child: Container(
                                                        padding: EdgeInsets.all(10),
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ? Color(0xff395B64) : LColor,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Colors.white, width: 2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(1,1),
                                                            blurRadius: 5
                                                          )
                                                        ]
                                                      ),
                                                      child: Center(
                                                        child: SvgPicture.asset('assets/svg/allah.svg', color: Colors.white, fit: BoxFit.contain,),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text('Asmaul', style: TextStyle(color: isDarkMode ? Colors.white : LColor),),
                                                ],
                                              ),

                                              Column( // Menu 3
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => DoaHarianPages(
                                                        isDarkMode : isDarkMode
                                                      )));
                                                    },
                                                      child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ? Color(0xff395B64) : LColor,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Colors.white, width: 2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(1,1),
                                                            blurRadius: 5
                                                          )
                                                        ]
                                                      ),
                                                      child: Center(
                                                        child: FaIcon(FontAwesomeIcons.prayingHands, color: Colors.white,),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text("Do'a", style: TextStyle(color: isDarkMode ? Colors.white : LColor),),
                                                  SizedBox(height: 10,),
                                                InkWell(
                                                    onTap: (){
                                                      if (onInternet == false) {
                                                         ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              backgroundColor: Colors.red[300],
                                                              content: Text('No Internet Connection!', textAlign: TextAlign.center,)
                                                            )
                                                          );
                                                      } else {
                                                        Navigator.push(context, 
                                                        MaterialPageRoute(builder: (context) => PublicChatHome(isDarkMode: isDarkMode)));
                                                      }
                                                    },
                                                      child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ? Color(0xff395B64) : LColor,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Colors.white, width: 2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(1,1),
                                                            blurRadius: 5
                                                          )
                                                        ]
                                                      ),
                                                      child: Center(
                                                        child: Icon(Icons.email, color: Colors.white, size: 28,),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text('Masukan', style: TextStyle(color: isDarkMode ? Colors.white : LColor),),
                                                ],
                                              ),

                                              Column( // Menu 4
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                      Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => DzikirPage(
                                                        isDarkMode : isDarkMode
                                                      )));
                                                    },
                                                      child: Container(
                                                      padding: EdgeInsets.all(7),
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ? Color(0xff395B64) : LColor,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Colors.white, width: 2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(1,1),
                                                            blurRadius: 5
                                                          )
                                                        ]
                                                      ),
                                                      child: Center(
                                                        child: SvgPicture.asset('assets/svg/tasbih.svg', color: Colors.white,),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text('Dzikir', style: TextStyle(color: isDarkMode ? Colors.white : LColor),),
                                                  SizedBox(height: 10,),
                                                InkWell(
                                                    onTap: (){
                                                      Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => MoreMenuPage()));
                                                      // ScaffoldMessenger.of(context).showSnackBar(
                                                      //       SnackBar(
                                                      //         backgroundColor: Colors.red[300],
                                                      //         content: Text('Fitur masih dalam pengembangan', textAlign: TextAlign.center,)
                                                      //       )
                                                      // );
                                                    },
                                                      child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: isDarkMode ? Color(0xff395B64) : LColor,
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Colors.white, width: 2),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(1,1),
                                                            blurRadius: 5
                                                          )
                                                        ]
                                                      ),
                                                      child: Center(
                                                        child: FaIcon(FontAwesomeIcons.gripHorizontal, color: Colors.white,),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text('Lainnya', style: TextStyle(color: isDarkMode ? Colors.white : LColor),),
                                                ],
                                              ),
                                            ],
                                          )
                                        ),

                                        Container(
                                          padding: EdgeInsets.only(left: 20, right: 10),
                                          child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Kumpulan Hadist', style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: Colors.grey
                                            ),
                                            textAlign: TextAlign.left,),

                                            TextButton(
                                              onPressed: (){
                                                Fluttertoast.showToast(msg: 'Coming Soon', textColor: Colors.white, backgroundColor: LColor);
                                              }, child: Text('Lihat Semua >', style: TextStyle(
                                                color: Colors.grey
                                              ),))
                                          ],
                                        ),
                                        ),
                    
                                        Expanded(
                                          child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.only(left: 10, right: 10),
                                          child: Container(
                                            height: MediaQuery.of(context).size.height,
                                            padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: isDarkMode ? Color(0xff395B64) : Colors.white,
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: Colors.grey, width: 1),
                                              ),
                                              child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text('Hadist Of The Day', style: TextStyle(color: isDarkMode ? Colors.white : Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),),
                                                      //Text('(updates in $second)', style: TextStyle(color: isDarkMode ? Colors.white : Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),),
                                                    ],
                                                  ),
                                                  Divider(thickness: 1,),
                                                  Text(item, style: TextStyle(color: isDarkMode ? Colors.white : Colors.grey, fontSize: 12), textAlign: TextAlign.justify,)
                                                ],
                                              ),
                                          )
                                        ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          )
             ),
      )

            //  bottomNavigationBar: Container(
            //    decoration: BoxDecoration(
            //      color: Colors.white
            //    ),
            //    height: 50,
            //    child: Center(
            //      child: InkWell(
            //        onTap: (){
            //          print('dwadwadwa');
            //        },
            //          child: Column(
            //            mainAxisAlignment: MainAxisAlignment.center,
            //            children: [
            //              FaIcon(FontAwesomeIcons.bookOpen, size: 20, color: LColor,),
            //               Text('kumpulan hadis',  style: TextStyle(fontSize: 10, color: LColor),)
            //            ],
            //          ),
            //      )
            //    ),
            //  )
        );
    }
}