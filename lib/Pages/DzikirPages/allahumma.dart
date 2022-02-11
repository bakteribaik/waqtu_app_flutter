import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Pages/DzikirPages/alfatiha.dart';
import 'package:waqtuu/Pages/DzikirPages/azirnaminannar.dart';
import 'package:waqtuu/Pages/DzikirPages/lailahillallah.dart';
import 'package:waqtuu/Pages/home_menu.dart';

class AllahummaPages extends StatefulWidget {
  const AllahummaPages({ Key? key }) : super(key: key);

  @override
  _AllahummaPagesState createState() => _AllahummaPagesState();
}

class _AllahummaPagesState extends State<AllahummaPages> {
   int counter = 0;
   bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dzikir 4',
          style: TextStyle(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff2EB086),
        //leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu), color: Color(0xff2EB086),),
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
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'للَّهُمَّ أَنْتَ السَّلاَمُ، وَمِنْكَ السَّلَامُ، وَإِلَيْكَ يَعُوْدُ السَّلَامُ فَحَيِّنَارَبَّنَا بِالسَّلَامِ وَاَدْخِلْنَا الْـجَنَّةَ دَارَ السَّلَامِ تَبَارَكْتَ رَبَّنَا وَتَعَالَيْتَ يَا ذَاالْـجَلَالِ وَاْلإِكْرَام',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Misbah',
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
                              builder: (context) => const AlfatihaPages()));
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