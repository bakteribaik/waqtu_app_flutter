import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Pages/DzikirPages/allahumma.dart';
import 'package:waqtuu/Pages/DzikirPages/azirnaminannar.dart';
import 'package:waqtuu/Pages/DzikirPages/lailahillallah.dart';

class DzikirPage extends StatefulWidget {

  final isDarkMode;

  const DzikirPage({Key? key,
  required this.isDarkMode}) : super(key: key);

  @override
  _DzikirPageState createState() => _DzikirPageState();
}

class _DzikirPageState extends State<DzikirPage> {

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? BColor : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ISTIGHFAR',
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: widget.isDarkMode? Colors.transparent : Colors.teal,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text('3x Istighfar', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'أَسْتَغْفِرُ اللهَ الْعَظِـيْمِ الَّذِيْ لَااِلَهَ اِلَّا هُوَ الْحَيُّ الْقَيُّوْمُ وَأَتُوْبُ إِلَيْهِ',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Misbah',
                  color: widget.isDarkMode ? Colors.white : Colors.black
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              counter.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: widget.isDarkMode ? Colors.white : Colors.black),
            ),

            Container(
              padding: EdgeInsets.all(10),
              child: Text("Astagfirullah hal'adzim, aladzi laailaha illahuwal khayyul qoyyuumu wa'atubuubuh ilahii", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),),
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
                              builder: (context) => LailahaillahPage(
                                  isDarkMode: widget.isDarkMode,
                              )));
                    }setState(() {
                      counter++;
                    });
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
                )),
    );
  }
}
