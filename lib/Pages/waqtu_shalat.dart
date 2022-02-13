import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:waqtuu/Models/waqtu_model.dart';
import 'package:waqtuu/Service/service_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class WaqtuHome extends StatefulWidget {
  const WaqtuHome({ Key? key }) : super(key: key);

  @override
  _WaqtuHomeState createState() => _WaqtuHomeState();
}

class _WaqtuHomeState extends State<WaqtuHome> {

  String _timeString = '';

  String date = DateFormat("d MMM yyyy").format(DateTime.now());
  String time = DateFormat("HH:mm").format(DateTime.now());
  String dateInput = DateFormat("yyyy-MM-dd").format(DateTime.now());

  DataService dataService = DataService();
  Sholat sholat = Sholat();

  bool isFetch = false;

  String Address = '';

  String long = '';
  String lat = '';

  bool sended = false;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
 
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      print('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    Address = place.subAdministrativeArea.toString();
    long = position.longitude.toString();
    lat = position.latitude.toString();
    setState((){});
  }

  _getData () async {
    sholat = await dataService.fetchData(long, lat, dateInput);
    isFetch = true;
    setState(() {});
  }

   _getTime() {
    final String formattedDateTime =
        DateFormat('HH:mm').format(DateTime.now()).toString();
    if (this.mounted) {
      setState(() {
      _timeString = formattedDateTime;
      });
    }
  }

  _getLocation() async {
    Position position = await _getGeoLocationPosition();
    GetAddressFromLatLong(position);
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
    _getData();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  //sholat.results!.datetime![0].times!.dhuhr.toString() manggil waktu sholat
  //sholat.results!.location!.city.toString() kota


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xff2EB086)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        title: isFetch ? Text(sholat.results!.datetime![0].date!.hijri! + ' Hijriah', style: TextStyle(
          color: Color(0xff2EB086),
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Poppins'
        )) : Text('Loading...'),
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
                          Text(Address,style: TextStyle( // Nama kota
                            color: Colors.grey
                          ),),

                          SizedBox(width: 5,),

                          Container(
                            padding: EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 5),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('Mazhab: ' + sholat.results!.settings!.juristic!, style: TextStyle(
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
                          Text(date, style: TextStyle( // TANGGAL
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          ),),

                          SizedBox(width: 7,),

                          Text(_timeString, style: TextStyle( // JAM
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.end,)
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
                decoration: BoxDecoration(
                  color: Color(0xff2EB086),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                           width: MediaQuery.of(context).size.width/2.8,
                           child: Text('Imsak', style: TextStyle(fontSize: 14),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/4,
                           child: Text('± ' + sholat.results!.datetime![0].times!.imsak.toString(), style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 17,
                             color: Color(0xff2EB086)
                           ),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/5.5,
                           child: IconButton(onPressed: (){
                             Fluttertoast.showToast(msg: 'Comming Soon', backgroundColor: Color(0xff2EB086), textColor: Colors.white);
                           }, icon: Icon(Icons.alarm),),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),
             
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                           width: MediaQuery.of(context).size.width/2.8,
                           child: Text('Fajar', style: TextStyle(fontSize: 14),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/4,
                           child: Text('± ' + sholat.results!.datetime![0].times!.fajr.toString(), style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 17,
                             color: Color(0xff2EB086)
                           ),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/5.5,
                           child: IconButton(onPressed: (){
                             Fluttertoast.showToast(msg: 'Coming Soon', backgroundColor: Color(0xff2EB086), textColor: Colors.white);
                           }, icon: Icon(Icons.alarm),),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                           width: MediaQuery.of(context).size.width/2.8,
                           child: Text('Dzuhur', style: TextStyle(fontSize: 14),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/4,
                           child: Text('± ' + sholat.results!.datetime![0].times!.dhuhr.toString(), style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 17,
                             color: Color(0xff2EB086)
                             
                           ),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/5.5,
                           child: IconButton(onPressed: (){
                             Fluttertoast.showToast(msg: 'Coming Soon', backgroundColor: Color(0xff2EB086), textColor: Colors.white);
                           }, icon: Icon(Icons.alarm),),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                           width: MediaQuery.of(context).size.width/2.8,
                           child: Text('Ashar', style: TextStyle(fontSize: 14),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/4,
                           child: Text('± ' + sholat.results!.datetime![0].times!.asr.toString(), style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 17,
                             color: Color(0xff2EB086)
                           ),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/5.5,
                           child: IconButton(onPressed: (){
                             Fluttertoast.showToast(msg: 'Coming Soon', backgroundColor: Color(0xff2EB086), textColor: Colors.white);
                           }, icon: Icon(Icons.alarm),),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                           width: MediaQuery.of(context).size.width/2.8,
                           child: Text('Maghrib', style: TextStyle(fontSize: 14),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/4,
                           child: Text('± ' + sholat.results!.datetime![0].times!.maghrib.toString(), style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 17,
                             color: Color(0xff2EB086)
                           ),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/5.5,
                           child: IconButton(onPressed: (){
                             Fluttertoast.showToast(msg: 'Coming Soon', backgroundColor: Color(0xff2EB086), textColor: Colors.white);
                           }, icon: Icon(Icons.alarm),),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),

                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(
                           width: MediaQuery.of(context).size.width/2.8,
                           child: Text('Isya', style: TextStyle(fontSize: 14),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/4,
                           child: Text('± ' + sholat.results!.datetime![0].times!.isha.toString(), style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 17,
                             color: Color(0xff2EB086)
                           ),),
                          ),
                           Container(
                           width: MediaQuery.of(context).size.width/5.5,
                           child: IconButton(onPressed: (){
                             Fluttertoast.showToast(msg: 'Coming Soon', backgroundColor: Color(0xff2EB086), textColor: Colors.white);
                           }, icon: Icon(Icons.alarm),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),

              Container(
                padding: EdgeInsets.all(10),
                // height: MediaQuery.of(context).size.height/5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.grey),
                              Text(' Reminder! ', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey
                              ),),
                            ],
                          ),

                          SizedBox(height: 10,),

                          Text('Tidak ada shalat yang paling berat dilakukan oleh orang munafik kecuali shalat Shubuh dan shalat Isya. [HR. Bukhari no. 657 dan Muslim no. 651]',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10
                          ),)
                        ],
                      ),
                    ),
              )
            ],
          ),
        ) : SizedBox(
          child: Center(
            child: CircularProgressIndicator(color: Color(0xff2EB086),),
          ),
        ),
      )
    );
  }
}