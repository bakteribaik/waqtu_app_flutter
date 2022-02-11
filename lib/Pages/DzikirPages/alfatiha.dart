import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Pages/DzikirPages/ayatKursi.dart';
import 'package:waqtuu/Pages/home_menu.dart';

class AlfatihaPages extends StatefulWidget {
  const AlfatihaPages({ Key? key }) : super(key: key);

  @override
  _AlfatihaPagesState createState() => _AlfatihaPagesState();
}

class _AlfatihaPagesState extends State<AlfatihaPages> {
  int counter = 0;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Al Fatihah',
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
            Text('Membaca Al fatiha'),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ\n\nالْحَمْدُ لِلَّهِ رَبِّ الْعالَمِينَ\nالرَّحْمنِ الرَّحِيمِ\nمَالِكِ يَوْمِ الدِّينِ\nإِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ\nاهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ\nصِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلا الضَّالِّينَ',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Misbah',
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: Text("", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),),
            ),

            SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  activeColor: Color(0xff2EB086),
                  value: isChecked, 
                  onChanged: (bool?value){
                  setState(() {
                    isChecked = value!;
                  });
                  print(isChecked);
                  }
                ),

                Text('Sudah membacanya?')
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: isChecked ? Container(
        padding: EdgeInsets.all(10),
        child: InkWell(
                  onTap: () async {
                    
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AyatKursiPages()));
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
                ),
      ) : SizedBox(),
    );
  }
}
