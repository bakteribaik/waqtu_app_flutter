import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   elevation: 0,
      //   iconTheme: IconThemeData(
      //     color: Colors.grey
      //   ),
      //   backgroundColor: Colors.transparent,
      //   title: Text('Donasi ke Pengembang', style: TextStyle(color: Color.fromARGB(255, 50, 172, 111), fontWeight: FontWeight.bold, fontSize: 15),),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.6,
            image: AssetImage('assets/images/paper_tekstur.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width/1.2,
                child: Text('Assalamualaikum, sebelumnya terimakasih telah menginstall WAQTU Digital Quran indonesia...\n\nsegala macam bentuk donasi akan sangat kami terima dan akan kami gunakan untuk pengembangan WAQTU : Quran Digital Indonesia kedepannya, untuk pengembangan server dan pengembangan fitur lainnya.\n\nterus support pengembang indonesia 💪', textAlign: TextAlign.center, style: TextStyle(fontSize: 13),)
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse('https://saweria.co/waqtu'));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/1.4,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[300],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: Text('Lanjutkan donasi dengan saweria', style: TextStyle(color: Colors.white),)),
                ),
              ),
              SizedBox(height: 5,),
              Text('support: Dana, GoPay, OVO, dan lainnya...', style: TextStyle(fontSize: 11, color: Colors.grey),)
            ],
          ),
        ),
      ),
    );
  }
}