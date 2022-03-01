import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_menu.dart';

class AyatKursiPages extends StatefulWidget {
  final isDarkMode;
  const AyatKursiPages({ Key? key, required this.isDarkMode }) : super(key: key);

  @override
  _AyatKursiPagesState createState() => _AyatKursiPagesState();
}

class _AyatKursiPagesState extends State<AyatKursiPages> {

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
              height: 30,
            ),
            Text('Membaca Ayat Kursi', style: TextStyle(color: widget.isDarkMode ?  Colors.white : Colors.black),),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ. بِسْمِ اللهِ الرَّحْمَنِ الرَّحِيْمِ. اَللهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَّلَانَوْمٌ، لَهُ مَافِي السَّمَاوَاتِ وَمَافِي اْلأَرْضِ مَن ذَا الَّذِيْ يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِ يَعْلَمُ مَابَيْنَ أَيْدِيْهِمْ وَمَاخَلْفَهُمْ وَلَا يُحِيْطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَآءَ، وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَاْلأَرْضَ وَلَا يَـؤدُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيْمُ',
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
                      Navigator.of(context).pop();
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
