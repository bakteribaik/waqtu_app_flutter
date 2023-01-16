import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/SCREEN/AsmaulHusnaPages/AsmaulHusnaPage.dart';
import 'package:waqtuu/SCREEN/DigitalCounter/DigitalCounterPage.dart';
import 'package:waqtuu/SCREEN/DoaHarianPages/DoaHarianPages.dart';
import 'package:waqtuu/SCREEN/Forum%20Chat/DataCheck.dart';
import 'package:waqtuu/SCREEN/HomePages/DonationScreen.dart';
import 'package:waqtuu/SCREEN/KalkulatorZakatPage/KalkulatorZakatPage.dart';
import 'package:waqtuu/SCREEN/Qibla/QiblaPages.dart';
import 'package:waqtuu/SCREEN/Quran/ListQuran.dart';
import 'package:waqtuu/SCREEN/WaktuShalat/WaktuShalat.dart';
import 'package:waqtuu/ad_helper.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {

  BannerAd? _bannerAd;

  final hadishaian = [
    '“Tidak sempurna iman seseorang, sehingga dia mencintai saudaranya seperti mencintai dirinya sendiri.”',
    '“Sebagian dari kebaikan Islam, seseorang meninggalkan sesuatu yang tidak berguna.”',
    '“Barangsiapa beriman kepada Allah dan hari akhirat maka hendaklah memuliakan tamu.”',
    '“Kebanyakan dosa anak-anak Adam itu ada pada lisannya.”',
    '“Orang yang menunjukkan jalan kebaikan, mendapat pahala seperti yang melakukannya.”',
    '“Sesungguhnya sebagian akhlaq Islam adalah rasa malu.”',
    '“Sesungguhnya Allah itu indah dan mencintai keindahan.”',
    '“Senyum engkau dihadapan saudaramu adalah sedekah.”',
    '“Kebersihan itu sebagian dari iman.”',
    '“Setiap kebaikan adalah sedekah,”',
    '“Shalat adalah tiang agama.”',
    '“Surga itu ada dibawah telapak kaki Ibu."',
    '"Kita adalah makhluk yang suka menyalahkan dari luar, tidak menyadari bahwa masalah biasanya dari dalam."',
    '"Jangan berduka, apa pun yang hilang darimu akan kembali lagi dalam wujud lain."',
    '"Barangsiapa diharamkan atasnya kasih sayang, maka segala bentuk kebaikan akan dihilangkan darinya."',
    '"Barangsiapa yang tidak mensyukuri yang sedikit, maka ia tidak akan mampu mensyukuri sesuatu yang banyak."',
    '"Selalu ada pahala bagi setiap pelaku kebaikan kepada seluruh makhluk hidup."',
    '"Aku tak pernah sekalipun menyesali diamku. Tapi berkali-kali menyesali bicaraku."',
    '"Jika kamu mencintai seseorang, biarkan dia pergi. Jika ia kembali, maka ia milikmu. Namun jika tidak kembali, ketahuilah maka dia bukan milikmu."',
    '"Dan barang siapa bertawakal kepada Allah, niscaya Allah akan mencukupkan keperluannya."',
    '"Salatlah agar hatimu tenang, istighfarlah agar kecewamu hilang. Dan berdoalah agar bahagiamu segera datang."',
    '"Takkan pernah ada yang senantiasa bersamamu dalam setiap situasi, kecuali Allah."',
    '"Titik lelahnya diganti bahagia, fase diamnya diganti senyuman, usahanya diganti keberhasilan, doanya Allah ijabah tepat dengan waktunya."',
    '"Bercermin itu penting agar kita mengetahui siapa diri kita, apa saja kekurangan kita, sebelum memutuskan untuk menilai orang lain."',
    '"Lelahmu akan berubah manis ketika niatnya lillah karena Allah."',
    '"Jangan sampai tampilan sudah baik tapi hati masih munafik karena Allah melihat ikhlasnya hati, bukan sucinya penampilan fisik."',
    '"Ikhlas adalah perpaduan antara keinginan dan niat seseorang."',
    '"Orang yang paling ikhlas adalah dia yang paling mencintai Allah dan paling percaya kepada-Nya."',
    '"Berbuatlah dengan ikhlas karena Allah Maha Tahu apa yang ada dalam hati."',
    '"Tanda pertama dari sebuah keikhlasan adalah keberadaanmu ketika di hadapan banyak orang maupun saat sendiri tidak ada bedanya."',
  ];

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  @override
  void initState() {
    super.initState();

    initializeDateFormatting('id', null);
    
    _initGoogleMobileAds();

      BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        centerTitle: true,
        title: Text('WAQTU', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14),),
        actions: [
          TextButton.icon(
              onPressed: (){
                Fluttertoast.showToast(
                  msg: 'Gunakan Forum Chat Jika Butuh Bantuan',
                );
              }, 
              icon: Icon(Icons.headset_mic, color: Colors.blueGrey, size: 18,), 
              label: Text('Bantuan', style: TextStyle(fontSize: 12, color: Colors.grey),)
            ),
          SizedBox(width: 5,)
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.only(top: 7, bottom: 5, left:25, right: 25),
                  height: 70,
                  width: MediaQuery.of(context).size.width/1.2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        if(DateTime.now().hour >= 18 && DateTime.now().hour <= 24)
                          Color.fromARGB(255, 113, 129, 133)
                        else
                        Color(0xFFD7F3FA),
                        Color.fromARGB(255, 130, 197, 214)
                      ],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      stops: [0.0, 0.7],
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            if(DateTime.now().hour >= 5 && DateTime.now().hour <= 11)
                              Text('menuju sholat dzuhur', style: TextStyle(fontSize: 13, color: Colors.white),)
                            else if (DateTime.now().hour >= 11 && DateTime.now().hour <= 14)
                              Text('menuju sholat ashar', style: TextStyle(fontSize: 13, color: Colors.white),)
                            else if (DateTime.now().hour >= 14 && DateTime.now().hour <= 17)
                              Text('menuju sholat maghrib', style: TextStyle(fontSize: 13, color: Colors.white),)
                            else if (DateTime.now().hour >= 17 && DateTime.now().hour <= 18)
                              Text('menuju sholat isya', style: TextStyle(fontSize: 13, color: Colors.white),)
                            else if (DateTime.now().hour >= 18 && DateTime.now().hour <= 22)
                              Text('jangan lupa sholat malam 😁', style: TextStyle(fontSize: 13, color: Colors.white),)
                            else
                              Text('menuju sholat subuh', style: TextStyle(fontSize: 13, color: Colors.white),),

                            Text('${DateFormat('EEEE, dd MMMM yyyy', 'id').format(DateTime.now())}', style: TextStyle(fontSize: 13, color: Colors.white),),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StreamBuilder(
                              stream: Stream.periodic(Duration(seconds: 1)),
                              builder: (context, snapshot){
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AnimatedFlipCounter(
                                        duration: Duration(milliseconds: 500),
                                        value: int.parse(DateFormat('HH').format(DateTime.now())),
                                        curve: Curves.easeInOutCirc,
                                        textStyle: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                    ),
                                    Text(':', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                                    AnimatedFlipCounter(
                                        duration: Duration(milliseconds: 500),
                                        value: int.parse(DateFormat('mm').format(DateTime.now())),
                                        curve: Curves.easeInOutCirc,
                                        textStyle: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ), // akhir dari container waktu

                SizedBox(height: 40,),

                Container(
                  width: MediaQuery.of(context).size.width/1.1,
                  // color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => WaktuShalat(
                            
                          )));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 49, 221, 150)
                              ),
                              //child: SvgIcon('assets/svg/sujud.svg', color: Colors.white,),
                              child: Center(child: FaIcon(FontAwesomeIcons.clock, size: 30, color: Colors.white,)),
                            ),
                            SizedBox(height: 3,),
                            Container(
                              child: Text('Waktu\nSholat', style: TextStyle(fontSize: 11, color: Colors.grey),),
                            )
                          ],
                        ),
                      ),

                      SizedBox(width: 13,),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ListQuran()));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 49, 221, 150)
                              ),
                              // child: SvgIcon('assets/svg/quran.svg', color: Colors.white,),
                              child: Center(child: FaIcon(FontAwesomeIcons.bookQuran, color: Colors.white, size: 30,)),
                            ),
                            SizedBox(height: 3,),
                            Container(
                              child: Text('Qur`an\nOffline', style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center,),
                            )
                          ],
                        ),
                      ),

                      SizedBox(width: 13,),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => QiblaPages()));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 49, 221, 150)
                              ),
                              child: Center(child: FaIcon(FontAwesomeIcons.kaaba, color: Colors.white, size: 30,))
                            ),
                            SizedBox(height: 3,),
                            Container(
                              child: Text('Arah\nQiblah', style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center,),
                            )
                          ],
                        ),
                      ),

                      SizedBox(width: 13,),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DoaHarianPages()));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 49, 221, 150)
                              ),
                              child: Icon(Icons.handshake, size: 40, color: Colors.white,)
                            ),
                            SizedBox(height: 3,),
                            Container(
                              child: Text('Do`a\nHarian', style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center,),
                            )
                          ],
                        ),
                      ),

                      SizedBox(width: 13,),

                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap:() {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DataCheckForum()));
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 49, 221, 150)
                                  ),
                                  child: Center(child: FaIcon(FontAwesomeIcons.comments, color: Colors.white, size: 30,))
                                ),
                                SizedBox(height: 3,),
                                Container(
                                  child: Text('Forum\nChat', style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center,),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ), // bottom of atas

                SizedBox(height: 10,),

                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AsmaulHusnaPage()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 49, 221, 150)
                              ),
                              child: SvgIcon('assets/svg/allah.svg', color: Colors.white,),
                            ),
                            SizedBox(height: 3,),
                            Container(
                              child: Text('Asmaul\nHusna', style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center,),
                            )
                          ],
                        ),

                        SizedBox(width: 13,),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DigitalCounterPage()));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 49, 221, 150)
                                ),
                                child: SvgIcon('assets/svg/tasbih.svg', color: Colors.white,)
                              ),
                              SizedBox(height: 3,),
                              Container(
                                child: Text('Counter\nDigital', style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center,),
                              )
                            ],
                          ),
                        ),

                        SizedBox(width: 13,),

                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => KalkulatorZakatPage()));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 49, 221, 150)
                                ),
                                child: Icon(Icons.calculate_outlined, color: Colors.white, size: 35,),
                              ),
                              SizedBox(height: 3,),
                              Container(
                                child: Text('Kalkulator\nZakat', style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center,),
                              )
                            ],
                          ),
                        ),

                        SizedBox(width: 13,),

                        GestureDetector(
                          onTap: () {
                            // launchUrl(Uri.parse('https://saweria.co/zedd'));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DonationPage()));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 49, 221, 150)
                                ),
                                child: Center(child: FaIcon(FontAwesomeIcons.circleDollarToSlot, size: 26, color: Colors.white,))
                              ),
                              SizedBox(height: 3,),
                              Container(
                                child: Text('Donasi\nke Dev..', style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center,),
                              )
                            ],
                          ),
                        ),

                        SizedBox(width: 13,),

                        GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=com.waqtuindonesia'));
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 49, 221, 150)
                                ),
                                child: Icon(Icons.star_border, size: 34, color: Colors.white,),
                              ),
                              SizedBox(height: 3,),
                              Container(
                                child: Text('Beri Kami\nRating', style: TextStyle(fontSize: 11, color: Colors.grey), textAlign: TextAlign.center,),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ), // bottom of menu bawah

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  // color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if(_bannerAd !=null)
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: _bannerAd!.size.width.toDouble(),
                            height: _bannerAd!.size.height.toDouble(),
                            child: AdWidget(ad: _bannerAd!),
                          ),
                        )
                      else 
                        Center(
                          child: Text('Selamat Datang di WAQTU', style: TextStyle(color: Colors.black54),),
                        )
                    ],
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width/1.15,
                  height: MediaQuery.of(context).size.width/2.5,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      initialPage: 1,
                      height: 150,
                      clipBehavior: Clip.none,
                      autoPlayCurve: Curves.easeInOutQuart,
                      scrollDirection: Axis.horizontal,
                      pauseAutoPlayOnTouch: true,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 500)
                    ),
                    itemCount: hadishaian.length,
                    itemBuilder: (context, index, realindex){
                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.symmetric(vertical: 1),
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 49, 221, 150),
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${hadishaian[index]}', style: TextStyle(color: Colors.white, fontSize: 14,), textAlign: TextAlign.center,),
                          ],
                        )
                      );
                    },
                  )
                ),

                SizedBox(height: 20,),
                Text('WAQTU Social Media', style: TextStyle(fontSize: 10, color: Colors.grey),),
                SizedBox(height: 10,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.vibrate();
                          launchUrl(Uri.parse('https://discord.gg/Ky5rRBV3Ka'));
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.teal[100]
                          ),
                          child: Center(child: FaIcon(FontAwesomeIcons.discord, size: 15, color: Colors.white,)),
                        ),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.vibrate();
                          launchUrl(Uri.parse('https://www.instagram.com/waqtu.studio/'));
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.teal[100]
                          ),
                          child: Center(child: FaIcon(FontAwesomeIcons.instagram, size: 18, color: Colors.white,)),
                        ),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.vibrate();
                          launchUrl(Uri.parse('https://www.youtube.com/channel/UCSx-RJN-ahoXO1QKlQcGIFw'));
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.teal[100]
                          ),
                          child: Center(child: FaIcon(FontAwesomeIcons.youtube, size: 16, color: Colors.white,)),
                        ),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () async {
                          PackageInfo packageInfo = await PackageInfo.fromPlatform();
                          showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (context){
                            return Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('info Aplikasi', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                                  Divider(),
                                  Text('Publisher: Stara Studio\nBuild Author: @zulfikaralwilubis on IG\nApp Version: ${packageInfo.version}', style: TextStyle(color: Colors.grey, fontSize: 13),),
                                ],
                              ),
                            );
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.teal[100]
                          ),
                          child: Center(child: FaIcon(FontAwesomeIcons.circleInfo, size: 16, color: Colors.white,)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 60,
      //   color: Colors.white,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       TextButton.icon(
      //         onPressed: (){}, 
      //         icon: Icon(Icons.headset_mic, color: Colors.blueGrey,), 
      //         label: Text('Support')
      //       ),
      //       IconButton(
      //         onPressed: (){}, 
      //         icon: Icon(Icons.coffee_maker_outlined, color: Colors.blueGrey,)
      //       ),
      //       IconButton(
      //         onPressed: (){}, 
      //         icon: Icon(Icons.star_half, color: Colors.blueGrey,)
      //       ),
      //     ],
      //   ),
      // )
    );
  }
}