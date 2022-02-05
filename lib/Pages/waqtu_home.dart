import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waqtuu/Models/waqtu_model.dart';
import 'package:waqtuu/Service/service_data.dart';

class WaqtuHome extends StatefulWidget {
  const WaqtuHome({ Key? key }) : super(key: key);

  @override
  _WaqtuHomeState createState() => _WaqtuHomeState();
}

class _WaqtuHomeState extends State<WaqtuHome> {

  String _timeString = '';

  String date = DateFormat("d MMM").format(DateTime.now());
  String time = DateFormat("HH:mm").format(DateTime.now());
  String dateInput = DateFormat("yyyy-MM-dd").format(DateTime.now());

  DataService dataService = DataService();
  Sholat sholat = Sholat();

  bool isFetch = false;


  _getData () async {
    sholat = await dataService.fetchData('ciputat', dateInput);
    setState(() {});
    isFetch = true;
  }

   _getTime() {
    final String formattedDateTime =
        DateFormat('HH:mm').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  //sholat.results!.datetime![0].times!.dhuhr.toString() manggil waktu sholat
  //sholat.results!.location!.city.toString() kota

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        title: Text('WAQTU SHALAT', style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Poppins'
        )),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.exit_to_app),
            color: Colors.black87,)
        ],
      ),

      body: SafeArea(
        child: isFetch ? Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Container(
                     child: Row(
                       children: [
                          Text(sholat.results!.location!.city.toString(),style: TextStyle( // Nama kota
                            color: Colors.grey
                          ),),

                          SizedBox(width: 5,),

                          Container(
                            padding: EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('realtime', style: TextStyle(
                              fontSize: 10,
                              color: Colors.white
                            ),),
                          )
                       ],
                     ),
                   ),
                    
                    Container(
                      child: Row(
                        children: [
                          Text(date, style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                          ),),

                          SizedBox(width: 5,),

                          Text(_timeString, style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),)
                        ],
                      ),
                    )
                  ],
                ),
              ), // end of container waktu

              SizedBox(height: 20,),

              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.green[600],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10,),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Reminder ! ', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white
                          ),),

                          SizedBox(height: 10,),

                          Text('Tidak ada shalat yang paling berat dilakukan \noleh orang munafik kecuali shalat Shubuh dan \nshalat Isya. [HR. Bukhari no. 657 dan Muslim no. 651]',
                          style: TextStyle(
                            color: Colors.white60,
                            fontStyle: FontStyle.italic,
                            fontSize: 13
                          ),)
                        ],
                      ),
                    ),

                    SizedBox(height: 40,),

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                           width: MediaQuery.of(context).size.width/2.5,
                           child: Text('Subuh', style: TextStyle(fontSize: 18),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/4,
                           child: Text(sholat.results!.datetime![0].times!.fajr.toString(), style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 17,
                             color: Colors.greenAccent
                           ),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/5.5,
                           child: IconButton(onPressed: (){}, icon: Icon(Icons.alarm),),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                           width: MediaQuery.of(context).size.width/2.5,
                           child: Text('Dzuhur', style: TextStyle(fontSize: 18),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/4,
                           child: Text(sholat.results!.datetime![0].times!.dhuhr.toString(), style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 17,
                             color: Colors.greenAccent
                           ),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/5.5,
                           child: IconButton(onPressed: (){}, icon: Icon(Icons.alarm),),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                           width: MediaQuery.of(context).size.width/2.5,
                           child: Text('Ashar', style: TextStyle(fontSize: 18),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/4,
                           child: Text(sholat.results!.datetime![0].times!.asr.toString(), style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 17,
                             color: Colors.greenAccent
                           ),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/5.5,
                           child: IconButton(onPressed: (){}, icon: Icon(Icons.alarm),),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                           width: MediaQuery.of(context).size.width/2.5,
                           child: Text('Maghrib', style: TextStyle(fontSize: 18),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/4,
                           child: Text(sholat.results!.datetime![0].times!.maghrib.toString(), style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 17,
                             color: Colors.greenAccent
                           ),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/5.5,
                           child: IconButton(onPressed: (){}, icon: Icon(Icons.alarm),),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                           width: MediaQuery.of(context).size.width/2.5,
                           child: Text('Isya', style: TextStyle(fontSize: 18),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/4,
                           child: Text(sholat.results!.datetime![0].times!.isha.toString(), style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 17,
                             color: Colors.greenAccent
                           ),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/5.5,
                           child: IconButton(onPressed: (){}, icon: Icon(Icons.alarm),),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),

                  ],
                ),
              ),

              SizedBox(height: 50,),

              Center(child: Text('Copyrighted (c) Zulfikar Alwi Studio 2022', style: TextStyle(
                fontSize: 12,
                color: Colors.grey
              ),),)
            ],
          ),
        ) : SizedBox(),
      )
    );
  }
}