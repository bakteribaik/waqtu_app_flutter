import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Pages/DzikirPages/allahumma.dart';
import 'package:waqtuu/Pages/home_menu.dart';

class AzirnaPage extends StatefulWidget {
  const AzirnaPage({ Key? key }) : super(key: key);

  @override
  _AzirnaPageState createState() => _AzirnaPageState();
}

class _AzirnaPageState extends State<AzirnaPage> {
    int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dzikir 3',
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
            Text('7x Allahumma ajirni minan-naar'),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'اَللَّهُمَّ أَجِرْنِـى مِنَ النَّارِ',
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
                              builder: (context) => const AllahummaPages()));
                    }
                    setState(() {
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