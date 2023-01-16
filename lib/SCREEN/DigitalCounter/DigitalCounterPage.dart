import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DigitalCounterPage extends StatefulWidget {
  const DigitalCounterPage({Key? key}) : super(key: key);

  @override
  State<DigitalCounterPage> createState() => _DigitalCounterPageState();
}

class _DigitalCounterPageState extends State<DigitalCounterPage> {


  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey
        ),
        backgroundColor: Colors.transparent,
        title: Text('Penghitung Digital', style: TextStyle(color: Color.fromARGB(255, 50, 172, 111), fontWeight: FontWeight.bold, fontSize: 15),),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Kamu bisa menggunakan penghitung ini untuk menghitung dzikir dll.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey),),
            SizedBox(height: 30,),

            AnimatedFlipCounter(
              duration: Duration(milliseconds: 500),
              value: count,
              curve: Curves.easeInOutCirc,
              textStyle: TextStyle(fontSize: 80, color: Colors.lightBlue[300]),
            ),

            SizedBox(height: 100,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.vibrate();
                      if (count <= 0) {
                        setState(() {
                          count = 0;
                        });
                      } else {
                        setState(() {
                          count--;
                        });
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlue[300],
                      radius: 25,
                      child: Icon(Icons.remove_circle_outline, color: Colors.white,),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.vibrate();
                      setState(() {
                          count = 0;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlue[300],
                      radius: 25,
                      child: Icon(Icons.restart_alt, color: Colors.white,),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.vibrate();
                      if (count >= 9999) {
                        setState(() {
                          count = 0;
                        });
                      } else {
                        setState(() {
                          count++;
                        });
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlue[300],
                      radius: 25,
                      child: Icon(Icons.add_circle_outline, color: Colors.white,),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}