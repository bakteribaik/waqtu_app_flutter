import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class QiblaPages extends StatefulWidget {
  const QiblaPages({Key? key}) : super(key: key);

  @override
  State<QiblaPages> createState() => _QiblaPagesState();
}

class _QiblaPagesState extends State<QiblaPages> {

  bool isInternet = false;

  _checkPermission() async {
    var _permission = await FlutterQiblah.androidDeviceSensorSupport();
    if(_permission == null){
      Fluttertoast.showToast(msg: 'Perangkat tidak mendukung');
    }else{
      print(_permission);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Container(
        color: Colors.lightBlue[50],
        height: MediaQuery.of(context).size.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MediaQuery.of(context).size.height/1.8,
              decoration: BoxDecoration(
                color: Colors.lightBlue[200]
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Penunjuk arah kiblat', style: TextStyle(color: Colors.white,)),
                    StreamBuilder(
                      stream: Stream.periodic(Duration(seconds: 1)),
                      builder: (context, snapshot){
                        return Text(DateFormat('HH:mm').format(DateTime.now()), style: TextStyle(color: Colors.white, fontSize: 31, fontWeight: FontWeight.bold),);
                      },
                    ),
                    Text(DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()), style: TextStyle(color: Colors.white, fontSize: 21),)
                  ],
                )
              ),
            ),
            Positioned(
              bottom: 0.1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.045,
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Text('sejajarkan tanda panah dengan jarum kompas..', style: TextStyle(color: Colors.grey[400], fontSize: 10), textAlign: TextAlign.center,),
                      ),
                    ),
                    Positioned(
                      top: 1,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Icon(Icons.arrow_circle_up_sharp,color: Colors.green,),
                      ),
                    ),
                    StreamBuilder(
                      stream: FlutterQiblah.qiblahStream,
                      builder: (context, AsyncSnapshot<QiblahDirection>snapshot){
                        var direction = snapshot.data;
                        if (snapshot.hasData) {
                          return Transform.rotate(
                            angle: ((direction!.qiblah) * (pi / 180) * -1.04),
                            child: Container(
                              child: Image.asset('assets/images/jarum_kompas.png')
                            ),
                          );
                        }else{
                          return Text('Loading...');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}