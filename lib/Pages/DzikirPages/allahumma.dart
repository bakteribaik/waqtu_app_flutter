import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Pages/DzikirPages/alfatiha.dart';
import 'package:waqtuu/Pages/DzikirPages/azirnaminannar.dart';
import 'package:waqtuu/Pages/DzikirPages/lailahillallah.dart';
import 'package:waqtuu/Pages/home_menu.dart';

class AllahummaPages extends StatefulWidget {
  final bool isDarkMode;
  const AllahummaPages({ Key? key, required this.isDarkMode }) : super(key: key);

  @override
  _AllahummaPagesState createState() => _AllahummaPagesState();
}

class _AllahummaPagesState extends State<AllahummaPages> {

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
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'للَّهُمَّ أَنْتَ السَّلاَمُ، وَمِنْكَ السَّلَامُ، وَإِلَيْكَ يَعُوْدُ السَّلَامُ فَحَيِّنَارَبَّنَا بِالسَّلَامِ وَاَدْخِلْنَا الْـجَنَّةَ دَارَ السَّلَامِ تَبَارَكْتَ رَبَّنَا وَتَعَالَيْتَ يَا ذَاالْـجَلَالِ وَاْلإِكْرَام',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Misbah',
                  color: widget.isDarkMode ? Colors.white : Colors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: Text("Allahumma Angtassalam, Wamingkassalam, Wa Ilayka Ya'uudussalam Fakhayyina Rabbanaa Bissalaam Wa-Adkhilnaljannata Darossalaam Tabarokta Rabbanaa Wata'alayta Yaa Dzaljalaali Wal Ikraam", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),),
            ),

            SizedBox(height: 100,),

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
                              builder: (context) => AlfatihaPages(
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