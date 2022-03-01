import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Pages/DzikirPages/allahumma.dart';
import 'package:waqtuu/Pages/home_menu.dart';

class AzirnaPage extends StatefulWidget {
  final bool isDarkMode;
  const AzirnaPage({ Key? key, required this.isDarkMode }) : super(key: key);

  @override
  _AzirnaPageState createState() => _AzirnaPageState();
}

class _AzirnaPageState extends State<AzirnaPage> {

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
            Text('7x Allahumma ajirni minan-naar', style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'اَللَّهُمَّ أَجِرْنِـى مِنَ النَّارِ',
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
              child: Text("Allahumma ajirni minan-naar", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),),
            ),            
          ],
        ),
      ),
       bottomNavigationBar: Container(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () async {
                    if (counter == 6) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllahummaPages(
                                isDarkMode: widget.isDarkMode,
                              )));
                    }
                    setState(() {
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