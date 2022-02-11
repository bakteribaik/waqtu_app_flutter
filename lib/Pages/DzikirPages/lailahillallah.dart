import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Pages/DzikirPages/alfatiha.dart';
import 'package:waqtuu/Pages/DzikirPages/azirnaminannar.dart';
import 'package:waqtuu/Pages/home_menu.dart';

class LailahaillahPage extends StatefulWidget {
  const LailahaillahPage({ Key? key }) : super(key: key);

  @override
  _LailahaillahPageState createState() => _LailahaillahPageState();
}

class _LailahaillahPageState extends State<LailahaillahPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dzikir 2',
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff2EB086),
        actions: [
          TextButton(
              onPressed: () async {
                final url =
                    'https://wa.me/6283808503597?text=hallo%20admin%20waqtu';
                if (await canLaunch(url) &&
                    await Connectivity().checkConnectivity() ==
                        ConnectivityResult.wifi &&
                    await Connectivity().checkConnectivity() ==
                        ConnectivityResult.wifi) {
                  await launch(url);
                } else
                  (Fluttertoast.showToast(msg: 'No Internet Connection'));
              },
              child: Text(
                'Need Help?',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text('3x Baca'),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'لَاإِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيْكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ يُحْيِيْ وَيُمِيْتُ وَهُوَ عَلَى كُلِّ شَيْئٍ قَدِيْرٌ',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Misbah',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              counter.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: Text("Laa Ilaaha Illallaahu wahdahu Laa Syariikalahu, Lahul Mulku Walahul Hamdu, Yuhyii, Wayumiitu, Wahuwa Hayyun Laa Yamuutu, Biyadihil Khairu, Wahuwa 'alaa Kulli Syai-in Qadiir", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),),
            ),            
          ],
        ),
      ),
       bottomNavigationBar: Container(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  enableFeedback: true,
                  onTap: () async {
                    if (counter == 2) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AzirnaPage()));
                    }setState(() {
                      counter++;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xff2EB086),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text('✓', textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.white,
                      fontSize: 50
                    ),),
                  ),
                )),
    );
  }
}