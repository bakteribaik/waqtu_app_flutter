import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CounterPage extends StatefulWidget {

  final bool isDarkMode;

  const CounterPage({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

  int Counter = 0;
  int savedCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? BColor : LColor,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 90,
              child: Container(
                width: 300,
                child: Text('kamu bisa menggunakan ini sebagai penghitung dzikir, dan segala sesuatu yang butuh hitungan', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
              )
               
            ),

            Container(
              padding: EdgeInsets.only(left: 10),
              child: Center(
                child: Text(Counter.toString(), style: TextStyle(
                fontSize: MediaQuery.of(context).size.width/3,
                color: Colors.white
                ),
              ),
              ),
            ),
            
            Positioned(
              bottom: 100,
              child: Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                          setState(() {
                            Counter = 0;
                          });
                    }, icon: Icon(Icons.replay_outlined, size: 40, color: Colors.white,)),
                    SizedBox(width: 50,),
                    IconButton(onPressed: (){
                            AudioCache().play('audio/sfx/click_sound.mp3');
                            Clipboard.setData(ClipboardData());
                            HapticFeedback.heavyImpact();
                            if (Counter <= 9999) {
                               setState(() {
                                 Counter++;
                               });
                            }else{
                               showDialog(context: context, builder: (BuildContext context){
                                 return  AlertDialog(
                                    title: Column(
                                      children: [
                                        Text('yeay kamu sudah mencapai batas maksimal loh'),
                                        Text('untuk kembali ke 0 kamu bisa tekan reset'),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(onPressed: (){
                                        setState(() {
                                          Counter = 0;
                                        });
                                        Navigator.of(context).pop();
                                      }, child: Text('Reset?'))
                                    ],
                                  );
                                });
                            }
                    }, icon: Icon(Icons.control_point, size: 40, color: Colors.white,)),
                  ],
                ),
              )
            )
          ],
        )
      )
    );
  }
}