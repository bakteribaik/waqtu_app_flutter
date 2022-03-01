import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waqtuu/Models/waqtu_model.dart';
import 'package:waqtuu/Service/service_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:waqtuu/ad_helper.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';


class WaqtuHome extends StatefulWidget {

  final bool isDarkMode;
  const WaqtuHome({ Key? key, required this.isDarkMode }) : super(key: key);

  @override
  _WaqtuHomeState createState() => _WaqtuHomeState();
}

class _WaqtuHomeState extends State<WaqtuHome> {

  final LColor = Color(0xff01937C);
  final DColor = Color(0xff2C3333);
  final BColor = Color(0xff395B64);

  String _timeString = '';

  String date = DateFormat("EEEE, d MMMM yyyy").format(DateTime.now());
  String time = DateFormat("HH:mm").format(DateTime.now());
  String dateInput = DateFormat("yyyy-MM-dd").format(DateTime.now());

  DataService dataService = DataService();
  Sholat sholat = Sholat();

  bool isFetch = false;
  bool subuh  = false;
  bool dzuhur  = false;
  bool ashar  = false;
  bool maghrib  = false;
  bool isya  = false;

  String Address = '';

  String long = '';
  String lat = '';

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

  Future<bool>_loadSubuh() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getBool('subuh') ?? false;
  }

  Future<bool>_loadDzuhur() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getBool('dzuhur') ?? false;
  }

  Future<bool>_loadAshar() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getBool('ashar') ?? false;
  }

  Future<bool>_loadMagrib() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getBool('maghrib') ?? false;
  }

  Future<bool>_loadIsya() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getBool('isya') ?? false;
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
    _getData();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    _loadSubuh().then((value){
      subuh = value;
    });
    _loadDzuhur().then((value){
      dzuhur = value;
    });
    _loadAshar().then((value){
      ashar = value;
    });
    _loadMagrib().then((value){
      maghrib = value;
    });
    _loadIsya().then((value){
      isya = value;
    });
  }

  //sholat.results!.datetime![0].times!.dhuhr.toString() manggil waktu sholat
  //sholat.results!.location!.city.toString() kota
  //sholat.results!.settings!.juristic! mashab


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? BColor : LColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        actions: [
          TextButton(onPressed: (){launch('https://api.whatsapp.com/send?phone=6283808503597&text=halo%20admin%20*WAQTU*');}, child: Text('need help?', style: TextStyle(color: Colors.white, fontSize: 12),))
        ],
      ),

      body: SafeArea(
        child: Column(
            children: [

              // Text(date, style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),),
              Text(_timeString,  style: TextStyle(color: Colors.white, fontSize: 80, fontWeight: FontWeight.bold),),
              Text(Address,  style: TextStyle(color: Colors.white),),
              SizedBox(height: 10,),

              Container(
                width: 150,
                padding: EdgeInsets.only(top: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: isFetch ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: isFetch ? Text('Zona Waktu: ${sholat.results!.location!.timezone}', style: TextStyle(fontSize: 10, color: Colors.white),) : Text('loading..', style: TextStyle(fontSize: 10, color: Colors.white),) ,),
              ),

              SizedBox(height: 30,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: widget.isDarkMode ? DColor : Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: isFetch ? Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.teal[50],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Subuh           '),
                              Text('± ${sholat.results!.datetime![0].times!.fajr}'),
                              IconButton(onPressed: () async{
                                
                                if (subuh == false){
                                  setState((){
                                    subuh = true;                        
                                  });

                                  // String jam = sholat.results!.datetime![0].times!.fajr!;
                                  // final idx = jam.split(':');
                                  // DateTime now = new DateTime.now();
                                  // AndroidAlarmManager.oneShotAt(DateTime(now.year, now.month, now.day,  int.parse(idx[0]), 15), 1, _subuhExecute, alarmClock: true, exact: true, wakeup: true, rescheduleOnReboot: true);

                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('subuh', subuh);
                                }else{
                                  setState((){
                                    subuh = false;
                                  });
                                  //AndroidAlarmManager.cancel(1);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('subuh', subuh);
                                }
                              }, icon: subuh ? Icon(Icons.notifications_none_outlined, color: Colors.teal,) : Icon(Icons.notifications_off_outlined, color: Colors.grey,))
                            ],
                          ),
                        ),

                        SizedBox(height: 5,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.teal[50],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Dzuhur         '),
                              Text('± ${sholat.results!.datetime![0].times!.dhuhr}'),
                              IconButton(onPressed: ()async{
                                if (dzuhur == false) {
                                  setState(() {
                                    dzuhur = true;
                                  });

                                  // String jam = sholat.results!.datetime![0].times!.dhuhr!;
                                  // final idx = jam.split(':');
                                  // DateTime now = new DateTime.now();
                                  // AndroidAlarmManager.oneShotAt(DateTime(now.year, now.month, now.day,  int.parse(idx[0]), int.parse(idx[1])), 2, _dzuhurExecute, alarmClock: true,exact: true, wakeup: true, rescheduleOnReboot: true);

                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('dzuhur', dzuhur);
                                } else {
                                  setState(() {
                                    dzuhur = false;
                                  });
                                  //AndroidAlarmManager.cancel(2);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('dzuhur', dzuhur);
                                }
                              }, icon: dzuhur ? Icon(Icons.notifications_none_outlined, color: Colors.teal,) : Icon(Icons.notifications_off_outlined, color: Colors.grey,))
                            ],
                          ),
                        ),

                        SizedBox(height: 5,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.teal[50],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Ashar           '),
                              Text('± ${sholat.results!.datetime![0].times!.asr}'),
                              IconButton(onPressed: ()async{
                                if (ashar == false) {
                                  setState(() {
                                    ashar = true;
                                  });

                                  // String jam = sholat.results!.datetime![0].times!.asr!;
                                  // final idx = jam.split(':');
                                  // DateTime now = new DateTime.now();
                                  // AndroidAlarmManager.oneShotAt(DateTime(now.year, now.month, now.day,  int.parse(idx[0]), 15), 3, _asharExecute, alarmClock: true,exact: true, wakeup: true, rescheduleOnReboot: true);

                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('ashar', ashar);
                                } else {
                                  setState(() {
                                    ashar = false;
                                  });
                                  // AndroidAlarmManager.cancel(3);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('ashar', ashar);
                                }
                              }, icon: ashar ? Icon(Icons.notifications_none_outlined, color: Colors.teal,) : Icon(Icons.notifications_off_outlined, color: Colors.grey,))
                            ],
                          ),
                        ),

                        SizedBox(height: 5,),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.teal[50],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Maghrib      '),
                              Text('± ${sholat.results!.datetime![0].times!.maghrib}'),
                              IconButton(onPressed: ()async{
                                if (maghrib == false) {
                                  setState(() {
                                    maghrib = true;
                                  });

                                  // String jam = sholat.results!.datetime![0].times!.maghrib!;
                                  // final idx = jam.split(':');
                                  // DateTime now = new DateTime.now();
                                  // AndroidAlarmManager.oneShotAt(DateTime(now.year, now.month, now.day,  int.parse(idx[0]), 15), 4, _magribExecute, alarmClock: true);

                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('maghrib', maghrib);
                                } else {
                                  setState(() {
                                    maghrib = false;
                                  });
                                  // AndroidAlarmManager.cancel(4);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('maghrib', maghrib);
                                }
                              }, icon: maghrib ? Icon(Icons.notifications_none_outlined, color: Colors.teal,) : Icon(Icons.notifications_off_outlined, color: Colors.grey,))
                            ],
                          ),
                        ),

                        SizedBox(height: 5,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.teal[50],
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Isya              '),
                              Text('± ${sholat.results!.datetime![0].times!.isha}'),
                              IconButton(onPressed: ()async{
                                if (isya == false) {
                                  setState(() {
                                    isya = true;
                                  });

                                  // String jam = sholat.results!.datetime![0].times!.isha!;
                                  // final idx = jam.split(':');
                                  // DateTime now = new DateTime.now();
                                  // AndroidAlarmManager.oneShotAt(DateTime(now.year, now.month, now.day,  int.parse(idx[0]), int.parse(idx[1])), 5, _isyaExecute, rescheduleOnReboot: true);

                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('isya', isya);
                                } else {
                                  setState(() {
                                    isya = false;
                                  });
                                  // AndroidAlarmManager.cancel(5);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('isya', isya);
                                }
                              }, icon: isya ? Icon(Icons.notifications_none_outlined, color: Colors.teal,) : Icon(Icons.notifications_off_outlined, color: Colors.grey,))
                            ],
                          ),
                        ),

                        SizedBox(height: 25,),

                        Flexible(child: Text('Note: untuk fitur alarm dan notifikasi masih dalam masa perkembangan\nuntuk fitur suara adzan belum dapat ditentukan\nkapan perilisannya di adakan', textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromARGB(255, 255, 139, 139),
                          fontSize: 10
                        ),))
                      ],
                    ),
                  ): Center(child: CircularProgressIndicator(),),
                )
              )
            ],
          ) 
        ),
    );
  }
}

// void  _subuhExecute(){
//   print('Alarm Subuh EXECUTE');
//   AudioCache player = AudioCache();
//   player.play('audio/adzan/adzan_subuh.mp3');
// }

// void  _dzuhurExecute(){
//   print('Alarm dzuhur EXECUTE');
//   AudioCache player = AudioCache();
//   player.play('audio/adzan/adzan.mp3');
// }

// void  _asharExecute(){
//   print('Alarm ashar EXECUTE');
//   AudioCache player = AudioCache();
//   player.play('audio/adzan/adzan.mp3');
// }

// void _magribExecute(){
//   print('Alarm maghrib EXECUTE');
//   String time = DateFormat("HH:mm").format(DateTime.now());
//   Sholat sholat = Sholat();
//   if (time == sholat.results!.datetime![0].times!.maghrib) {
//     AudioCache player = AudioCache();
//     player.play('audio/adzan/adzan.mp3');
//   }
// }

// void  _isyaExecute(){
//   print('Alarm isya EXECUTE');
//   String time = DateFormat("HH:mm").format(DateTime.now());
//   Sholat sholat = Sholat();
//   if (time == sholat.results!.datetime![0].times!.isha) {
//     print('playing adzan isya');
//     AudioCache player = AudioCache();
//     player.play('audio/adzan/adzan.mp3');
//   }
// }