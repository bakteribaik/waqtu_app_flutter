import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Pages/DzikirPages/ayatKursi.dart';
import 'package:waqtuu/Pages/home_menu.dart';

class AlfatihaPages extends StatefulWidget {
  final bool isDarkMode;
  const AlfatihaPages({ Key? key, required this.isDarkMode}) : super(key: key);

  @override
  _AlfatihaPagesState createState() => _AlfatihaPagesState();
}

class _AlfatihaPagesState extends State<AlfatihaPages> {

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

  int counter = 0;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? BColor : Colors.white,
      appBar: AppBar(
       centerTitle: true,
        title: Text(
          'WAQTU Dzikir',
          style: TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: widget.isDarkMode ? Colors.transparent : Colors.teal,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text('Membaca Al fatiha', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ\n\nالْحَمْدُ لِلَّهِ رَبِّ الْعالَمِينَ\nالرَّحْمنِ الرَّحِيمِ\nمَالِكِ يَوْمِ الدِّينِ\nإِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ\nاهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ\nصِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلا الضَّالِّينَ',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Misbah',
                  color: widget.isDarkMode ? Colors.white : Colors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),


            SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  activeColor: widget.isDarkMode ? Colors.grey : Color(0xff2EB086),
                  value: isChecked, 
                  onChanged: (bool?value){
                  setState(() {
                    isChecked = value!;
                  });
                  print(isChecked);
                  }
                ),

                Text('Sudah membacanya?', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),)
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
                              builder: (context) => AyatKursiPages(
                                isDarkMode: widget.isDarkMode,
                              )));
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.teal,
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
